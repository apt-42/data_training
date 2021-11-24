# README

Install the distribution (anaconda, miniconda) corresponding to your Python version.  
Init it with the shell of your choice.

```
conda config --set auto_activate_base false # disable automatic startup
conda create --name ENV_NAME python=PYTHON_VERSION # create env
conda activate ENV_NAME # activate env
# Install required tools in your env
conda install --file requirements.txt
source deactivate # deactivate env
```
