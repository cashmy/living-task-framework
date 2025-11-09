<#
.SYNOPSIS
  Living Task Framework (LTF) utility command router.

.DESCRIPTION
  Central script to run common LTF tools and utilities.

.PARAMETER Command
  The command to execute (save, resume, fix-md, hooks, labels, help).

.PARAMETER Args
  Additional arguments to pass to the underlying script.

.EXAMPLE
  ./ltf.ps1 help

.EXAMPLE
  ./ltf.ps1 fix-md -FilePath README.md -InPlace

.EXAMPLE
  ./ltf.ps1 save-context -Tier Meso
#>

$ErrorActionPreference = "Stop"

# Parse arguments manually to allow pass-through of all named parameters
$Command = if ($args.Count -gt 0) { $args[0] } else { $null }
$PassThroughArgs = if ($args.Count -gt 1) { $args[1..($args.Count-1)] } else { @() }

# Get the script's directory
$ScriptRoot = $PSScriptRoot

function Show-Help {
    Write-Host ""
    Write-Host "Living Task Framework (LTF) Utilities" -ForegroundColor Cyan
    Write-Host "=====================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Context Management:" -ForegroundColor Yellow
    Write-Host "  save-context   " -ForegroundColor Green -NoNewline
    Write-Host "Create context snapshot"
    Write-Host "                 Examples:" -ForegroundColor Gray
    Write-Host "                   ./ltf.ps1 save-context" -ForegroundColor Gray
    Write-Host "                   ./ltf.ps1 save-context -Tier micro" -ForegroundColor Gray
    Write-Host "                   ./ltf.ps1 save-context -Tier meso" -ForegroundColor Gray
    Write-Host ""
    Write-Host "  resume-context " -ForegroundColor Green -NoNewline
    Write-Host "Extract preamble from snapshot"
    Write-Host "                 Examples:" -ForegroundColor Gray
    Write-Host "                   ./ltf.ps1 resume-context" -ForegroundColor Gray
    Write-Host "                   ./ltf.ps1 resume-context -SnapshotPath path/to/snapshot" -ForegroundColor Gray
    Write-Host ""
    Write-Host "Markdown Linting:" -ForegroundColor Yellow
    Write-Host "  fix-md         " -ForegroundColor Green -NoNewline
    Write-Host "Fix markdown linting errors in file(s)"
    Write-Host "                 Examples:" -ForegroundColor Gray
    Write-Host "                   ./ltf.ps1 fix-md -FilePath README.md -InPlace" -ForegroundColor Gray
    Write-Host "                   ./ltf.ps1 fix-md -FilePath 'docs/**/*.md' -InPlace" -ForegroundColor Gray
    Write-Host ""
    Write-Host "  fix-md-all     " -ForegroundColor Green -NoNewline
    Write-Host "Fix all markdown files in workspace"
    Write-Host "                 Examples:" -ForegroundColor Gray
    Write-Host "                   ./ltf.ps1 fix-md-all" -ForegroundColor Gray
    Write-Host ""
    Write-Host "Repository Management:" -ForegroundColor Yellow
    Write-Host "  install-hooks  " -ForegroundColor Green -NoNewline
    Write-Host "Install git hooks"
    Write-Host "                 Examples:" -ForegroundColor Gray
    Write-Host "                   ./ltf.ps1 install-hooks" -ForegroundColor Gray
    Write-Host ""
    Write-Host "  apply-labels   " -ForegroundColor Green -NoNewline
    Write-Host "Apply repository labels via GitHub API"
    Write-Host "                 Examples:" -ForegroundColor Gray
    Write-Host "                   ./ltf.ps1 apply-labels" -ForegroundColor Gray
    Write-Host ""
    Write-Host "General:" -ForegroundColor Yellow
    Write-Host "  help           " -ForegroundColor Green -NoNewline
    Write-Host "Show this help message"
    Write-Host ""
}

# Handle command
switch ($Command) {
    { $_ -in 'save', 'save-context' } {
        Write-Host "[LTF] Running Save-LTFContext..." -ForegroundColor Cyan
        & "$ScriptRoot/tools/context/Save-LTFContext.ps1" @PassThroughArgs
    }
    
    { $_ -in 'resume', 'resume-context' } {
        Write-Host "[LTF] Running Resume-LTFContext..." -ForegroundColor Cyan
        & "$ScriptRoot/tools/context/Resume-LTFContext.ps1" @PassThroughArgs
    }
    
    'fix-md' {
        Write-Host "[LTF] Running Fix-MarkdownLint..." -ForegroundColor Cyan
        & "$ScriptRoot/tools/scripts/Fix-MarkdownLint.ps1" @PassThroughArgs
    }
    
    'fix-md-all' {
        Write-Host "[LTF] Fixing all markdown files in workspace..." -ForegroundColor Cyan
        & "$ScriptRoot/tools/scripts/Fix-MarkdownLint.ps1" -FilePath "**/*.md" -InPlace @PassThroughArgs
    }
    
    { $_ -in 'hooks', 'install-hooks' } {
        Write-Host "[LTF] Running Install-GitHooks..." -ForegroundColor Cyan
        & "$ScriptRoot/tools/scripts/Install-GitHooks.ps1" @PassThroughArgs
    }
    
    { $_ -in 'labels', 'apply-labels' } {
        Write-Host "[LTF] Running Apply-RepoLabels-API..." -ForegroundColor Cyan
        & "$ScriptRoot/tools/scripts/Apply-RepoLabels-API.ps1" @PassThroughArgs
    }
    
    'help' {
        Show-Help
    }
    
    default {
        if ([string]::IsNullOrWhiteSpace($Command)) {
            Show-Help
        } else {
            Write-Host "[LTF] Unknown command: $Command" -ForegroundColor Red
            Write-Host "[LTF] Use './ltf.ps1 help' for usage information." -ForegroundColor Yellow
            exit 1
        }
    }
}
