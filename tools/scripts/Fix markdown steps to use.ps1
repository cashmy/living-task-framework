Get-Content "core/taxonomy/DMP_Patterns.md" -Raw
# Fix horizontal rules
$content = $content -replace '- --', '---'
# Fix malformed emphasis at start of lines
$content = $content -replace '(?m)^\* \*([^\*]+)\*\*:', '**$1**:'
# Fix list markers in narrative/example sections (dash to asterisk)
$content = $content -replace '(?m)^- "', '* "'
# Fix other dash list items that should be asterisks
$content = $content -replace '(?m)^- ([A-Z])', '* $1'
$content | Set-Content "core/taxonomy/DMP_Patterns.md" -NoNewline
Write-Host "✓ Fixed markdown formatting"
#
$content = Get-Content "core/taxonomy/DMP_Patterns.md" -Raw
$content = $content -replace '- --', '---'
$content = $content -replace '(?m)^\* \*([^\*]+)\*\*:', '**$1**:'
$content = $content -replace '(?m)^- "', '* "'
$content = $content -replace '(?m)^- ([A-Z])', '* $1'
$content | Set-Content "core/taxonomy/DMP_Patterns.md" -NoNewline
Write-Host "✓ Fixed markdown formatting"
