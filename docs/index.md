# Welcome to Projutils

Projutils is a set of utilities for management of the development environments,
regardless of the development type. It is centered in three main third-party packages
as follows:

* vim - the default editor to be used for all different kind of projects
* tmux - a terminaml multiplexer for supporting many virtual terminal session over
  the same TTY terminal.
* mkvirtualenv - a python based virtual environment manager that may also be used for
  managing other types of projects. This is the core dependency of the projutil tool.

## Installation 

After cloning the repo, the installation process is started via the ```install.sh```
command. 

Executing this command performs the follwing tasks:

* checks whether all dependecies are available in the system, namely the mkvirtualenv
  dependency.
* copies a set of files to the installation directory
  ```$HOME/.local/share/projutils```


## Design

WIP

### Project creation

**Command**: ```proj-new```

The ```mkproject``` command from the ```virtualenvwrapper``` is at the heart of this
function - it is used to create a new project. The proutils uses the postmkproject to
perform further customisations as per the  ```utils/postmkproject``` file. The custom
behavior is as follows:

* Generate the project postactivate hook file from the template ```utils/postactivate.tpl```.
* Load/reload the newly generated project (note that the newly created postactivate hook gets executed) to load all the project definition settings. Note that the postactivate script sources the ```utils/.env``` file, which contains the definition of all projutils enviroment hooks.
* run the ```utils/mkproj.sh``` script for installing the project type specific tools
  and artifacts.

----------------------------------------------------

**Note**

All projects generated using this command will be located under the directory
specified in the ```$PROJECT_HOME``` variable.

----------------------------------------------------

### Project activation

**Command**: ```workon [PROJECT]``` 

The ```workon``` command from the ```virtualwrapper``` is at the core of this
feature. This postactivate hook is used for each project to perform the following
actions:

* Load the project specific enviromnet settings (e.g REPO_DIR, etc...) settings.
  Project specific modifications (using the ```.proj``` and/or ```.tmux``` files
  should not rely on the ```virtualenvwrapper``` environment definitions but reather
  on the projutil definitios initialised in the postactivate hook.
  The postactivate hook is generated whenever creating/importing a project.
* The postactivate also sources the .env file which is the responsible for loading
  all project specific customisations (see the project customisation section).

### Project import

**Command**: ```proj-import [PATH]``` 

The ```mkproject``` command from the ```virtualwrapper``` is at the core of this
feature. The feature implementation performs the following actions:

* move the existing project directory to a temporary location.
* sets the "CUSTOM_PROJECT_HOME" enviroment variable (if needed)
* create a new project using the ```mkproject``` command.
* copy original project directory from the temporary location back to the original
  project location.

The ```CUSTOM_PROJECT_HOME``` environment variable is the mechanism to allow
projutils to override the ```PROJECT_HOME``` contraint imposed by ```virtualenvwrapper```. 

----------------------------------------------------

**Note**

The override of the ```PROJECT_HOME``` limitation is currently only available via the
```proj-import``` feature.

----------------------------------------------------


### Project customisation

#### .proj
 WIP

#### .tmux

WIP


### Project utils startup

The ```projutils``` framework installer updated the .zshrc file to source the
```utils/projutils.sh``` file. This action adds a few utility functions into the
environment (see the usage.txt file for more information on the available commands),
starts the ```/usr/bin/ssh-agent``` process with whatever keys exist in the SSH_KEYS
environment variables. The SSH_KEYS should be defined as an array of paths to the ssh
key (private) key files.

------------------------------------------------------------------------

**Note**

Password protected ssh keys are currently not supported. Make sure the SSH_KEYS env
var does not include a PATH to a file associated to a password protected ssh key.

------------------------------------------------------------------------

