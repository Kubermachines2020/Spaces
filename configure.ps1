# Kubermachines configure
#
# Usage:
#   iex ((new-object net.webclient).DownloadString('https://raw.githubusercontent.com/tilt-dev/tilt/master/scripts/install.ps1')

Copy-Item $home\contextfile.yml -Destination $home\.kube\config

$context = Get-Content $home\.kube\config | Select-String -Pattern '^current-context' |ForEach-Object {
    -split $_.Line |Select-Object -Last 1
}

kubectl config use-context $context
