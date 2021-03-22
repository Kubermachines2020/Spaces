param(
  [parameter(Mandatory=$true)]
  [String] 
  $flag,

  [parameter(Mandatory=$false)]
  [String] 
  $path
)

Process {


  if($flag -ceq "install") {

           iex ((new-object net.webclient).DownloadString('https://raw.githubusercontent.com/Kubermachines2020/Spaces/windows/install.ps1'))

  } elseif($flag -ceq "configure"){

           iex ((new-object net.webclient).DownloadString('https://raw.githubusercontent.com/Kubermachines2020/Spaces/windows/configure.ps1'))

   } elseif(($flag -ceq "configure") -and ($path -ceq "-f") ){

           iex ((new-object net.webclient).DownloadString('https://raw.githubusercontent.com/Kubermachines2020/Spaces/windows/configure.ps1'))

  } elseif($flag -ceq "up"){

          tilt up

  } elseif($flag -ceq "down"){
  
          tilt down
          
  } elseif($flag -ceq "help"){

          "help"

  } else {"kubermachines: '$flag' is not a kubermachines command. See 'kubermachines help' for usage."}


 }

