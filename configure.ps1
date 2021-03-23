# Kubermachines configure
#
# Usage:
#   iex ((new-object net.webclient).DownloadString('https://raw.githubusercontent.com/Kubermachines2020/Spaces/windows/configure.ps1')

Copy-Item $contextfile -Destination $home\.kube\config

$context = Get-Content $contextfile | Select-String -Pattern '^current-context' | ForEach-Object {
    -split $_.Line |Select-Object -Last 1
}

kubectl config use-context $context
