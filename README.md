# README

Install the distribution (anaconda, miniconda) corresponding to your Python version. Init it with the shell of your choice.

```
conda config --set auto_activate_base false # disable automatic start
conda create --name ENV_NAME python=PYTHON_VERSION # create env
conda install --file requirements.txt
source activate ENV_NAME
source deactivate
```
