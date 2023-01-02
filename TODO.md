# DEVENV project

[] - Prepare the documentation for the project to document the installation and
     usage of the projutils framework.

     Progress:
        [WIP]: 16-03-2022
          OBS> Added a usage file for documentation of how to use the projutils
               high-level commands
        [WIP]: 22-03-2022
          OBS> Updated the usage file with some new functions added in the meantime
        [WIP]: 02-01-2023
          OBS> Updated the README file with information on how to install the project
               from the repo.

[] - the tests do not perform any kind of clean up. We need to either properly
     document this behaviour or perform some clean up at the end of the test. 

[] - rename the .start_tmux to start_tmux and update the installer to properly
     install the .start_tmux files. Also update the documentation of all matters
     related to the tmux.

[] - migrate existing projects to projutils. We may need to create a projutils-import
     command for this.

     Progress:
        [WIP]: 22-03-2022
          OBS> Migrated the projutils project itself as the first one. But it looks
               like there are still some issues (e.g. REPO_DIR env var is not defined
               for some reason when the project is loaded via the workon command).
        [WIP]: 09-04-2022
          OBS> Fixed the REPO_DIR variable problem. Still not sure whether the proj
               is a projutils project. Further test required.

[] - Update the mkproject to add the git config user name and email. Allow the user
     to configure those via some sort of env vars.

[] - Create a high level projutils command to start the project tmux session.

[] - Generate an automatic .tmux file for the new projects. 

[] - Add pre-commit support to the project as well as to all generated projects. 

[] - Add bump-version support to the project as well as to all generated projects. 

[] - Add a proj-reqs command to update the project dependencies (i.e runs pip3
     install -r requirements.txt if the file is available AND runs the
     install-deps.sh script if it exists)

[] - Add a configuration file to the installed instance to allow the user to enable
     features (e.g plantuml container execution, pgadmin container execution, etc...).

[] - Automatically start the plantuml server if not already running (docker run -d -p
     8080:8080 plantuml/plantuml-server:jetty). If convinient we can use a different
     port or have the port setup as a configuration variable. Make this an option
     which is not enabled by default.

[] - Re-evaluate the implementation of the skip functionality in the .env file. It
     does make much sense to have it implemented at the level of the produtils .env
     file but rather at the level of the proj file.
[] - Add proj-todo function to open the list of TODO action (if any)
