***git-switch***
Simple script to easily switch between git remote urls.

----

**Description**

Do you maintian multiple copies of your code in different directories so that you can sync to different remote git urls?  (github.com, gitlab.com, git.yourcompany.com, etc)

This switch will allow you to easily switch between pre-configured upstream providers from within a single directory.  

<img src="http://www.jeffpickell.com/git-switch/images/git-switch_menu.png" alt="git-switch Menu">

- Will initialize a directory if it hasn't already been set up.  
- Updates the final line of the README with a "Last Updated: $date" line to allow for immediate add,comment & push to the new remote url.  If there's no README.md, it will create it and add the datestamp.

**Usage**

-Create a file called ".git-switch" in your home directory containing the user names and urls of the providers you want to switch between with the following format:

<username>:<gitlab.com>
<username>:<github.com>
<username>:<git.mycompany.com>

-Move the git-switch script somewhere in your path so that its easily accessible

cp git-switch /usr/local/bin

-Change the permissions on git-switch so that its executable

chmod +x /usr/local/bin/git-switch

-Run the script from within an existing git controlled directory (if you run it from an uninitialized directory, you will get prompted to initialize it and choose the remote provider)

----

Last Updated: Fri Apr 15 08:23:09 CDT 2016
