Copy-Item $home\kubermachines.ps1 -Destination $home\bin\kubermachines.ps1
Set-Alias kubermachines "$HOME\bin\kubermachines.ps1" -Scope Global
