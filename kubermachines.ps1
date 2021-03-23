param(
  [parameter(Mandatory=$false, Position = 0)]
  [AllowEmptyString()]
  [String] 
  $flag,

  [parameter(Mandatory=$false, Position = 1)]
  [string] 
  $f
)

Process {

  if($flag -ceq "install") {

           iex ((new-object net.webclient).DownloadString('https://raw.githubusercontent.com/Kubermachines2020/Spaces/windows/install.ps1'))

  } elseif($flag -ceq "configure"){

           if ($f.Length -ne "0"){

           Write-Host $f
           #.\setx /M path "%path%;$f"
           Set-Item -Path Env:contextfile -Value ($Env:contextfile + $f)
           iex ((new-object net.webclient).DownloadString('https://raw.githubusercontent.com/Kubermachines2020/Spaces/windows/configure.ps1'))

           } else {
           
           iex ((new-object net.webclient).DownloadString('https://raw.githubusercontent.com/Kubermachines2020/Spaces/windows/configure.ps1'))
           }

  } elseif($flag -ceq "up"){

          tilt up

  } elseif($flag -ceq "down"){
  
          tilt down
          
  } elseif($flag -ceq "help"){

          "help"

  } else {"kubermachines: '$flag' is not a kubermachines command. See 'kubermachines help' for usage."}


 }
