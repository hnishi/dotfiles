# Python environments

## Version Control of Python

use pyenv

## Version Control of Packages 

use venv

- venv is a standard tool
- you can create an isolated python environment

### how to use

```shell
python -m venv .venv  # create a .venv directory
source .venv/bin/activate  # enter the virtual environment
#pip install -r requirements.txt  # install packages with desired version
#pip install .  # install your own package only in the virtual environment
deactivate  # exit the virtual environment
```

