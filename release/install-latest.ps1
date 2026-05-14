Param(
    [string]$Repo = 'Ayush12358/agentic-cli-routing'
)

# PowerShell installer for Windows (and PowerShell Core on other platforms)
Set-StrictMode -Version Latest

function Get-LatestTag {
    param($repo)
    try {
        $uri = "https://api.github.com/repos/$repo/releases/latest"
        $resp = Invoke-RestMethod -Uri $uri -UseBasicParsing -ErrorAction Stop
        return $resp.tag_name
    } catch {
        return $null
    }
}

function Download-RepoZip {
    param($repo, $ref, $outPath)
    $zipUrl = "https://github.com/$repo/archive/refs/heads/$ref.zip"
    Invoke-WebRequest -Uri $zipUrl -OutFile $outPath -UseBasicParsing
}

function Run-InstallerFromClone {
    param($tempDir, $repo, $ref)
    $skillPath = Join-Path $tempDir '.github/skills/agentic-cli-routing'
    if (Test-Path $skillPath) {
        $dest = Join-Path (Get-Location) '.github/skills/agentic-cli-routing'
        if (Test-Path $dest) { Remove-Item -Recurse -Force $dest }
        New-Item -ItemType Directory -Force -Path (Split-Path $dest) | Out-Null
        Copy-Item -Path $skillPath -Destination (Split-Path $dest) -Recurse -Force
        Write-Output "Installed skill to $dest"
        return $true
    }
    return $false
}

$tag = Get-LatestTag -repo $Repo
if ([string]::IsNullOrEmpty($tag)) { $tag = 'main' }

$temp = Join-Path $env:TEMP ([System.Guid]::NewGuid().ToString())
New-Item -ItemType Directory -Path $temp | Out-Null

if (Get-Command git -ErrorAction SilentlyContinue) {
    git clone --depth 1 --branch $tag "https://github.com/$Repo.git" $temp
    if (Run-InstallerFromClone -tempDir $temp -repo $Repo -ref $tag) {
        Remove-Item -Recurse -Force $temp
        Write-Output "Installation complete"
        exit 0
    }
}

# Fallback: download ZIP and extract
$zip = Join-Path $temp 'repo.zip'
Download-RepoZip -repo $Repo -ref $tag -outPath $zip
Expand-Archive -LiteralPath $zip -DestinationPath $temp
# repo folder will be like repo-ref
$children = Get-ChildItem -Directory -Path $temp | Where-Object { $_.Name -ne 'repo.zip' }
foreach ($c in $children) {
    if (Run-InstallerFromClone -tempDir $c.FullName -repo $Repo -ref $tag) {
        Remove-Item -Recurse -Force $temp
        Write-Output "Installation complete"
        exit 0
    }
}

Remove-Item -Recurse -Force $temp
Write-Error "Installation failed: skill directory not found in repo"
exit 1
