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



