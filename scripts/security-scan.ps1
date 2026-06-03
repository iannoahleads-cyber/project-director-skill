$ErrorActionPreference = "Stop"

$patterns = @(
  "OPENAI_API_KEY=.+",
  "ANTHROPIC_API_KEY=.+",
  "DEEPSEEK_API_KEY=.+",
  "AO_PROVIDER=.*https://",
  "OPENAI_BASE_URL=https://",
  "gx-[A-Za-z0-9]{20,}",
  "sk-[A-Za-z0-9_-]{20,}"
)

$failed = $false

foreach ($pattern in $patterns) {
  $matches = rg --hidden --glob "!.git" --glob "!*.example" --glob "!scripts/security-scan.ps1" $pattern .
  if ($LASTEXITCODE -eq 0 -and $matches) {
    Write-Host "Potential secret match for pattern: $pattern" -ForegroundColor Red
    Write-Host $matches
    $failed = $true
  }
}

if ($failed) {
  throw "Secret scan failed."
}

Write-Host "Secret scan passed."

