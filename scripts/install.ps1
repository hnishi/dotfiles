if (!(Test-Path $env:USERPROFILE\Documents\WindowsPowerShell)) {
    mkdir $env:USERPROFILE\Documents\WindowsPowerShell
}

if (!(Test-Path $env:USERPROFILE\Documents\WindowsPowerShell\Modules\posh-git)) {
    Install-Module posh-git -Scope CurrentUser
}

copy windows\Microsoft.PowerShell_profile.ps1 $env:USERPROFILE\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1

