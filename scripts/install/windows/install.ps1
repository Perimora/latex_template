$ErrorActionPreference = "Stop"

function Refresh-Path {
    $machinePath = [Environment]::GetEnvironmentVariable("Path", "Machine")
    $userPath = [Environment]::GetEnvironmentVariable("Path", "User")
    $env:Path = "$machinePath;$userPath"
}

function Test-TexToolchain {
    $commands = @("pdflatex", "bibtex", "latexmk")
    foreach ($command in $commands) {
        if (-not (Get-Command $command -ErrorAction SilentlyContinue)) {
            return $false
        }
    }
    return $true
}

Refresh-Path

if (Test-TexToolchain) {
    Write-Host "TeX toolchain already installed."
    exit 0
}

if (-not (Get-Command miktex -ErrorAction SilentlyContinue) -and
    -not (Get-Command pdflatex -ErrorAction SilentlyContinue)) {
    if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
        throw "winget is required to install MiKTeX automatically."
    }

    Write-Host "Installing MiKTeX via winget..."
    winget install --id MiKTeX.MiKTeX --exact --accept-package-agreements --accept-source-agreements --silent

    if ($LASTEXITCODE -ne 0) {
        throw "MiKTeX installation failed with exit code $LASTEXITCODE."
    }

    Refresh-Path
}

if (Get-Command initexmf -ErrorAction SilentlyContinue) {
    Write-Host "Enabling automatic installation of missing MiKTeX packages..."
    initexmf --set-config-value="[MPM]AutoInstall=1"
}

if (-not (Get-Command latexmk -ErrorAction SilentlyContinue)) {
    if (-not (Get-Command miktex -ErrorAction SilentlyContinue)) {
        throw "MiKTeX is installed, but its package manager is not available on PATH."
    }

    Write-Host "Installing latexmk via the MiKTeX package manager..."
    miktex packages install latexmk
    Refresh-Path
}

if (-not (Test-TexToolchain)) {
    throw "MiKTeX installation completed, but pdflatex, bibtex, or latexmk is not available on PATH."
}

Write-Host "Windows TeX toolchain installation complete."
