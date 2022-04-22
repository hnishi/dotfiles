# Python environments

## Version Control of Python

use pyenv

### Install

```shell
brew install pyenv
```

Ref: https://github.com/pyenv/pyenv

## Version Control of Packages 

use venv

- venv is a standard tool
- you can create an isolated python environment

### Install

You do not need to install venv because it is pre-installed.

### how to use

```shell
python -m venv .venv  # create a .venv directory
source .venv/bin/activate  # enter the virtual environment
#pip install -r requirements.txt  # install packages with desired version
#pip install .  # install your own package only in the virtual environment
deactivate  # exit the virtual environment
```
