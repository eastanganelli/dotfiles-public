## Variables
   $DEV = $Env:WINAPPS
   $DEPTHAI = $Env:DEPTHAI

## Imports
   Import-Module PSReadLine
   Set-PSReadLineOption -PredictionSource History

## Installers
   function ModuleInstallers () {
      Install-Module discordrpc -Scope CurrentUser
   }

## Ultilities (Optional)
   function which ($command) {
      Get-Command -Name $command -ErrorAction SilentlyContinue |
         Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
   }

   function Cleaning {
      Invoke-Expression clear
      $Ui = (Get-Host).UI.RawUI
      $Height = $UI.WindowSize.Height
      $Coordinates = New-Object System.Management.Automation.Host.Coordinates 0,($Height - 1)
      $Ui.CursorPosition = $Coordinates
   }

   function oakcam {
      python  $DEPTHAI"\\depthai_demo.py"  --app=uvc
   }

   function ctt {
      irm christitus.com/win | iex
   }

## Alias (Optional)
   Set-Alias g git
   Set-Alias ll ls
   Set-Alias grep findstr
   Set-Alias tig  "C:\\Program Files\\Git\\usr\\bin\\tig.exe"
   Set-Alias less "C:\\Program Files\\Git\\usr\\bin\\less.exe"
   New-Alias -Name clr -Value Cleaning

## Oh My Posh
   oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\1_shell.omp.json" | Invoke-Expression
   $ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
   if (Test-Path($ChocolateyProfile)) {
      Import-Module "$ChocolateyProfile"
   }

## Discord Presence
   $params = @{
      Details      = "Version $($PSVersionTable.PSVersion.Major).$($PSVersionTable.PSVersion.Minor)"
      State        = (Split-Path -Path $pwd -Leaf)
      Start        = "Now"
      UpdateScript = {
         Update-DSRichPresence -State (Split-Path -Path $pwd -Leaf)
      }
   }
   Start-DSClient @params

clr