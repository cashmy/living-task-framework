# PowerShell helper to run the watcher from the workspace root
param(
    [string]$Inbox = "Ideas/Inbox",
    [string]$Processed = "Ideas/Processed",
    [switch]$Once
)

$scriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$requirements = Join-Path $scriptRoot "requirements.txt"
$watcherScript = Join-Path $scriptRoot "watcher.py"

python -m pip install -r $requirements

$watcherArgs = @($watcherScript, "--inbox", $Inbox, "--processed-dir", $Processed)
if ($Once) {
    $watcherArgs += "--once"
}

python @watcherArgs
