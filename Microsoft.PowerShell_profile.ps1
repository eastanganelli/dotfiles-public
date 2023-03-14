## Variables
$DEV = $Env:WINAPPS
$DEPTHAI = $Env:DEPTHAI

Import-Module PSReadLine
Set-PSReadLineOption -PredictionSource History

## Init
function Iniciadores() {

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
    python3  $DEPTHAI"\\depthai_demo.py"  --app=uvc
}

function ctt {
    irm christitus.com/win | iex
}

## Expressions
# Invoke-Expression Instaladores

## Alias (Optional)
Set-Alias g git
Set-Alias ll ls
Set-Alias grep findstr
Set-Alias tig  "C:\\Program Files\\Git\\usr\\bin\\tig.exe"
Set-Alias less "C:\\Program Files\\Git\\usr\\bin\\less.exe"

New-Alias -Name clr  -Value Cleaning

oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\1_shell.omp.json" | Invoke-Expression
# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

clr
