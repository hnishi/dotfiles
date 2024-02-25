# hnishi's dotfiles

I aim to make my dotfiles simple, minimal, and dependent only on bash.

Also see the following materials (only in Japanese).

- [bashとcurlで実現する初めてのdotfiles - Qiita](https://qiita.com/hnishi/items/28ad11df1dde8b0ed368)
- [Slides](https://hnishi.github.io/slides-dotfiles/#/) (or its source: [GitHub - hnishi/slides-dotfiles: 勉強会資料](https://github.com/hnishi/slides-dotfiles) )

## For your personal use

To get started with this repository as a template of your dotfiles, you may use the tag version of [minimal-template-v0](https://github.com/hnishi/dotfiles/tree/minimal-template-v0) .

You can download a zip file from [Release page](https://github.com/hnishi/dotfiles/releases/tag/minimal-template-v0) .

The master branch includes my personal cofiguration; e.g. github user name.

## Requirements

- bash
- curl

## How to install

### Mac/Linux

```shell
curl -L raw.githubusercontent.com/hnishi/dotfiles/master/scripts/download.sh | bash
```

or

```shell
cd ~
git clone https://github.com/hnishi/dotfiles.git .dotfiles
cd .dotfiles/scripts
bash install.sh
```

### Windows

For powershell,

```powershell
. .\scripts\install.ps1
```

> On Windows, script execution policy must be set to either RemoteSigned or Unrestricted. Check the script execution policy setting by executing Get-ExecutionPolicy. If the policy is not set to one of the two required values, run PowerShell as Administrator and execute `Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Confirm`.

Ref: https://github.com/dahlbyk/posh-git#prerequisites

## References

My "dotfiles" was inspired by ...

- https://qiita.com/yutakatay/items/c6c7584d9795799ee164
  -  https://github.com/yutakatay/dotfiles-mini
- https://qiita.com/b4b4r07/items/b70178e021bef12cd4a2
  - https://github.com/b4b4r07/dotfiles

