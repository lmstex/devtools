# DEVENV project

[x] - Create an installer script for the devenv to help with the installation of the
      projutils framework in other machines.

      Progress:
        [CLOSED]: 16-03-2022

[] - Prepare the documentation for the project to document the installation and
     usage of the projutils framework.

     Progress:
        [WIP]: 16-03-2022
          OBS> Added a usage file for documentation of how to use the projutils
               high-level commands

[x] - Upload to remote repository 

      Progress:
        [CLOSED]: 15-03-2022

[x] - Add modifications to the mkvirtualenv premkproject and postmkproject files to
      the repository.

      Progress:
        [CLOSED]: 15-03-2022
          OBS> The premkproject is no longer in use and it was removed from the
               repository

[x] - create a bin directory for holding binaries to generate the projects. Update
      the tests and documentation for the usage of those binaries. Those binaries should be
      the main user interface of the tool.

      Progress:
        [CLOSED]: 15-03-2022
          OBS> A different approach was prefered. A set of high level functions is
               now available to the user for accessing the tool main functionality.he
               premkproject is no longer in use and it was removed from the repository

[] - the tests create a test project but do not perform any kind of clean up. We need
to either properly document this behaviour or perform some clean up at the end of the
test. 
