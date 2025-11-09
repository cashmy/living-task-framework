param([string]$Org = "<your-org>")
git submodule update --init --recursive
Write-Host "Submodules initialized."
