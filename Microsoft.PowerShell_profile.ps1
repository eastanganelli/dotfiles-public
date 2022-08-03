## Variables
$DEV = $Env:DEV_TOOLS

## INSTALLS
function Instaladores() {
    Install-Module -Name Terminal-Icons -Repository PSGallery
    Install-Module -Name z
    Install-Module -Name PSFzf
    Install-Module discordrpc -Scope CurrentUser
}

## Init
function Iniciadores() {
    ## OH-MY-POSH
    Import-Module posh-git
    Import-Module oh-my-posh

    ## PSReadLine
    Set-PSREadLineOption -PredictionSource History

    ## Terminal-Icons
    Import-Module -Name Terminal-Icons
    ##Get-Item ./README.md
    ##Get-ChildItem
    ##Get-ChildItem | Format-List
    ##Get-ChildItem | Format-Wide

    ## Fzf
    Import-Module PSFzf
    Set-PsFzfOption -PSReadLineChordProvider 'Ctrl+f' -PSReadLineChordReverseHistory 'Ctrl+r'

    ## Set theme
    Set-PoshPrompt -Theme cinnomon

    ## Load prompt configs
    oh-my-posh --init --shell pwsh --config "~/.cinnomon.omp.json" | Invoke-Expression
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

## Discord Presence
$params = @{
    Details      = "Version $($PSVersionTable.PSVersion.Major).$($PSVersionTable.PSVersion.Minor)"
    State        = (Split-Path -Path $pwd -Leaf)
    Start        = "Now"
    UpdateScript = {
        # show the directory you are in. you can do anything here.
        ## Update-DSRichPresence -State (Split-Path -Path $pwd -Leaf)
        Update-DSRichPresence -State (State)
    }
}

## Expressions
# Invoke-Expression Instaladores

## Alias (Optional)
Set-Alias g git
Set-Alias ll ls
Set-Alias grep findstr
Set-Alias tig "C:\Program Files\Git\usr\bin\tig.exe"
Set-Alias less "C:\Program Files\Git\usr\bin\less.exe"
Set-Alias python ($DEV + "\python\python.exe")
    
New-Alias -Name clr  -Value Cleaning

Invoke-Expression Iniciadores

# Start-DSClient @params

Invoke-Expression Cleaning
# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"

if (Test-Path($ChocolateyProfile)) {
    Import-Module "$ChocolateyProfile"
}

