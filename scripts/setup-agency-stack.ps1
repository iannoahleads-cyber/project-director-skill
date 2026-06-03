param(
  [string]$InstallDir = ".\agency-stack"
)

$ErrorActionPreference = "Stop"

Write-Host "Installing agency-orchestrator CLI..."
npm install -g agency-orchestrator

$root = Resolve-Path "."
$stack = Join-Path $root $InstallDir
New-Item -ItemType Directory -Force -Path $stack | Out-Null

function Download-ZipRepo {
  param(
    [string]$Name,
    [string]$ZipUrl
  )

  $target = Join-Path $stack $Name
  $zip = Join-Path $stack "$Name.zip"

  if (Test-Path $target) {
    Write-Host "$Name already exists, skipping download."
    return
  }

  Write-Host "Downloading $Name..."
  Invoke-WebRequest -Uri $ZipUrl -OutFile $zip
  Expand-Archive -LiteralPath $zip -DestinationPath $stack -Force
  Remove-Item -LiteralPath $zip -Force

  $expanded = Get-ChildItem -LiteralPath $stack -Directory |
    Where-Object { $_.Name -like "$Name-*" } |
    Sort-Object LastWriteTime -Descending |
    Select-Object -First 1

  if (-not $expanded) {
    throw "Cannot find expanded directory for $Name"
  }

  Rename-Item -LiteralPath $expanded.FullName -NewName $Name
}

Download-ZipRepo -Name "agency-agents-zh" -ZipUrl "https://codeload.github.com/jnMetaCode/agency-agents-zh/zip/refs/heads/main"
Download-ZipRepo -Name "agency-orchestrator" -ZipUrl "https://codeload.github.com/jnMetaCode/agency-orchestrator/zip/refs/heads/main"

$workflowSrc = Join-Path $stack "agency-orchestrator\workflows"
$workflowDest = Join-Path $root "workflows"
New-Item -ItemType Directory -Force -Path $workflowDest | Out-Null

if (Test-Path $workflowSrc) {
  Copy-Item -Path (Join-Path $workflowSrc "*") -Destination $workflowDest -Recurse -Force
}

Write-Host ""
Write-Host "Agency stack installed."
Write-Host "Next:"
Write-Host "  1. Copy .env.example to .env"
Write-Host "  2. Fill provider settings locally"
Write-Host "  3. Run: ao validate .\workflows\local-smoke-test.yaml"

