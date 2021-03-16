# Kubermachines installer
#
# Usage:
#   iex ((new-object net.webclient).DownloadString('https://raw.githubusercontent.com/Kubermachines2020/Spaces/windows/install.ps1')


$version = "0.18.13"
$url = "https://github.com/tilt-dev/tilt/releases/download/v" + $version + "/tilt." + $version + ".windows.x86_64.zip"
$zip = "tilt-" + $version + ".zip"
$extractDir = "tilt-" + $version
$binDir = "$HOME\bin"
$dest = "$binDir\tilt.exe"

$useScoop = ""
if (Get-Command "scoop" 2>$null) {
   $useScoop = "true"
}

if ("true" -eq $useScoop) {
    Write-Host "Scoop detected! (https://scoop.sh)"
    scoop bucket add tilt-dev https://github.com/tilt-dev/scoop-bucket
    scoop install tilt
    scoop update tilt
    tilt version
    tilt verify-install
    Write-Output "Tilt installed with Scoop! Run 'tilt up' to start."
    return
}

Write-Output "Downloading $url"
if (Test-Path "$zip") {
    Remove-Item -Force "$zip"
}
Invoke-WebRequest $url -OutFile $zip

Write-Output "Extracting $zip"
if (Test-Path "$extractDir") {
    Remove-Item -Force -Recurse "$extractDir"
}
Expand-Archive $zip -DestinationPath $extractDir

Write-Output "Installing Tilt as $dest"
New-Item -ItemType Directory -Force -Path $binDir >$null
Move-Item -Force -Path "$extractDir\tilt.exe" -Destination "$dest"

Remove-Item -Force -Path "$zip"
Remove-Item -Force -Recurse -Path "$extractDir"

iex "$dest version"
iex "$dest verify-install"

.\setx /M path "%path%;$HOME\bin"

#Set-Alias kubermachines "$HOME\bin\tilt.exe" -Scope Global

Write-Output "Kubermachines installed!"
Write-Output "Run 'kubermachines up' to start."
