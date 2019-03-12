# pdfsplit-docker
Very custom image to split PDFs

This image is based on Ubuntu OS.

### Background
* container starts with sshd service listening on port 22
* one user is created to be used to connect to this container via a Windows client (using plink.exe)
* the user has permissions to mount CIFS directories thanks to /etc/sudoers modifications
* a script is present on /usr/local/sbin directory (not included because of very custom paths and functions)
* this script is the default shell for the user
* ... coming other infos
