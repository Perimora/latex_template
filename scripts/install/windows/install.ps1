$ErrorActionPreference = "Stop"

function Test-TexToolchain {
    $commands = @("pdflatex", "bibtex", "latexmk")
    foreach ($command in $commands) {
        if (-not (Get-Command $command -ErrorAction SilentlyContinue)) {
            return $false
        }
    }
    return $true
}

function Refresh-Path {
    $machinePath = [Environment]::GetEnvironmentVariable("Path", "Machine")
    $userPath = [Environment]::GetEnvironmentVariable("Path", "User")
    $env:Path = "$machinePath;$userPath"
}

if (Test-TexToolchain) {
    Write-Host "TeX toolchain already installed."
    exit 0
}

if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    throw "winget is required to install MiKTeX automatically."
}

Write-Host "Installing MiKTeX via winget..."
winget install --id MiKTeX.MiKTeX --exact --accept-package-agreements --accept-source-agreements --silent

if ($LASTEXITCODE -ne 0) {
    throw "MiKTeX installation failed with exit code $LASTEXITCODE."
}

Refresh-Path

if (-not (Test-TexToolchain)) {
    throw "MiKTeX installation completed, but pdflatex, bibtex, or latexmk is not available on PATH."
}

Write-Host "Windows TeX toolchain installation complete."
