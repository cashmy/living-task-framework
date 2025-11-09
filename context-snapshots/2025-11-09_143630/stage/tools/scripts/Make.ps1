param(
  [ValidateSet("help","init","update","status","push")]
  [string]$Task = "help"
)

switch ($Task) {
  "help"   { "Tasks: init | update | status | push" }
  "init"   { git submodule update --init --recursive; "Submodules initialized." }
  "update" { ./tools/scripts/Update-Submodules.ps1 }
  "status" { git status; ""; git submodule status }
  "push"   {
    if (-not (git remote get-url origin 2 -gt $null)) { throw "No remote 'origin' set." }
    git push -u origin main
  }
}
