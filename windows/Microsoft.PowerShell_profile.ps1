Import-Module posh-git

Set-PSReadLineKeyHandler -Chord Ctrl+a -Function BeginningOfLine
Set-PSReadLineKeyHandler -Chord Ctrl+e -Function EndOfLine
Set-PSReadLineKeyHandler -Chord Alt+LeftArrow -Function BackwardWord
Set-PSReadLineKeyHandler -Chord Alt+RightArrow -Function NextWord
Set-PSReadlineOption -BellStyle None

### PROMPT ###

$GitPromptSettings.DefaultPromptPrefix.Text = '$(Get-Date -f "yyyy-MM-dd HH:mm:ss") '
$GitPromptSettings.DefaultPromptPrefix.ForegroundColor = [ConsoleColor]::Green
$GitPromptSettings.DefaultPromptBeforeSuffix.Text = '`n'

function global:PromptWriteErrorInfo() {
    if ($global:GitPromptValues.DollarQuestion) { return }

    if ($global:GitPromptValues.LastExitCode) {
        "`e[31m(" + $global:GitPromptValues.LastExitCode + ") `e[0m"
    }
    else {
        "$([char]27)[31m! $([char]27)[0m"
# "`e[31m! `e[0m"
    }
}

$global:GitPromptSettings.DefaultPromptBeforeSuffix.Text = ' $(PromptWriteErrorInfo)`n'

# see https://github.com/dahlbyk/posh-git#customizing-the-posh-git-prompt

### ALIAS ###

# Determine size of a file or total size of a directory
Set-Alias fs Get-DiskUsage

# Reload the shell
Set-Alias reload Reload-Powershell

# http://xkcd.com/530/
Set-Alias mute Set-SoundMute
Set-Alias unmute Set-SoundUnmute

# Set GVim as default vim
Set-Alias vi vim
