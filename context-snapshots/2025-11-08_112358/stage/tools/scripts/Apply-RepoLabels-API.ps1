param(
  [Parameter(Mandatory=$true)][string]$Owner,
  [Parameter(Mandatory=$true)][string]$Repo
)

$ErrorActionPreference = "Stop"

if (-not (Test-Path ".github/labels.json")) { Write-Host "[x] Missing .github/labels.json"; exit 1 }
if (-not $env:GITHUB_TOKEN) { Write-Host "[x] Set GITHUB_TOKEN env var."; exit 1 }

$labels = Get-Content ".github/labels.json" -Raw | ConvertFrom-Json
$base = "https://api.github.com/repos/$Owner/$Repo/labels"
$headers = @{ Authorization = "token $($env:GITHUB_TOKEN)"; "User-Agent" = "ltf-label-sync" }

foreach ($lbl in $labels) {
  $body = @{
    name = $lbl.name
    color = $lbl.color
    description = $lbl.description
  } | ConvertTo-Json

  # Try create; if exists, PATCH
  try {
    Invoke-RestMethod -Method Post -Uri $base -Headers $headers -Body $body -ContentType "application/json" | Out-Null
    Write-Host "[+] Created: $($lbl.name)" -ForegroundColor Green
  } catch {
    $target = "$base/$($lbl.name -replace ' ','%20')"
    Invoke-RestMethod -Method Patch -Uri $target -Headers $headers -Body $body -ContentType "application/json" | Out-Null
    Write-Host "[~] Updated: $($lbl.name)" -ForegroundColor Yellow
  }
}
Write-Host "[✓] Labels synchronized." -ForegroundColor Green
