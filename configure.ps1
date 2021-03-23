# Kubermachines configure
#
# Usage:
#   iex ((new-object net.webclient).DownloadString('https://raw.githubusercontent.com/Kubermachines2020/Spaces/windows/configure.ps1')
Write-Host $env:contextfile
$contextfilepath = Get-Content $env:contextfile
Copy-Item $contextfilepath -Destination $home\.kube\config

$context = Get-Content $contextfilepath | Select-String -Pattern '^current-context' | ForEach-Object {
    -split $_.Line |Select-Object -Last 1
}

kubectl config use-context $context
