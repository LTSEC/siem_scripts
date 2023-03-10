# HOME
only tested on ubuntu 16.04
use at own risk. for my own reference, and others that keep asking about my setup.

# Usage
It's a git repo full of dotfiles... Use it with git... or just download the zip and do things the more old-school way of moving files.

What I do:

    # go to home dir
    cd

    # initialize empty repo
    git init

    # add remote url. Change if you fork
    git remote add origin git@github.com:samuelmattjohnston/home.git

    # Make sure you save yourself by pullin in the .gitignore
    git fetch
    git checkout origin/master -- .gitignore
    git checkout origin/master -- README.md

    # reset your uninitialzed repo to master, or some other branch so you can see the diffs
    git reset origin/master

From here do what you want. You can checkout my files directly, merge them in using your favourite diff tool, or you can go to setting up your own branch for some redundancy:

    git checkout -b $USER
    git add -A
    git commit -m 'Initial commit of my files'

And you can push this up to your own repo, or just as a backup.

# my ppas
    for APT in `find /etc/apt/ -name \*.list`; do
         grep -o "^deb http://ppa.launchpad.net/[a-z0-9\-]\+/[a-z0-9\-]\+" $APT | while read ENTRY ; do
             USER=`echo $ENTRY | cut -d/ -f4`
             PPA=`echo $ENTRY | cut -d/ -f5`
             echo sudo apt-add-repository ppa:$USER/$PPA
         done
     done

credit to:
https://askubuntu.com/a/148968

## All PPAs I  use

    sudo apt-add-repository ppa:openrazer/stable    
    sudo apt-add-repository ppa:webupd8team/terminix
    sudo apt-add-repository ppa:polychromatic/stable    
    sudo apt-add-repository ppa:webupd8team/atom    
    sudo apt-add-repository ppa:rael-gc/scudcloud    

## Manual install docker


    # Docker community edition repo
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

    # install docker-ce
    sudo apt update && sudo apt install docker-ce

    # Setup and permission docker-compose
    sudo curl -L https://github.com/docker/compose/releases/download/1.18.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose

    # Install nsenter / docker-enter because I am absudly lazy
    docker run --rm -v /usr/local/bin:/target jpetazzo/nsenter

    # Enable docker and local user to use docker commands
    sudo systemctl enable docker
    sudo systemctl start docker
    sudo usermod -aG  docker $USER

    # TODO: oneliner sudoers config for using sudo /usr/bin/docker-enter because I'm lazy.

## update repos when done with all this.
Note you've run sudo apt update if you used my manual docker install shenanigans earlier     
`sudo apt update`


# Stuff needed for work
## apt install

i3    
meld    
atom    
terminator        
vim    
thunar    
docker-ce

## Manual

### nvm
because npm/node is a mess.

`curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh | bash`

### light
laptop backlight controls

    git clone https://github.com/haikarainen/light.git
    cd light
    sudo make
    sudo make install

## Managing your atom packages

Get list of installed community packages:

    apm list --installed --bare > package-list.txt

This will get you a list of community packages you've got installed with atom.

To install again:

    apm install --packages-file package-list.txt

credit to:
https://discuss.atom.io/t/installed-packages-list-into-single-file/12227/2

# extras for life

## apt install

chromium-browser    
arandr    
nfs-common    
ffmpeg    
openrazer-meta    
polychromatic    
scudcloud    
pavucontrol    
paprefs    
pavumeter    
hexchat    

## other/testing

tilix - not recommended due to startup issues i'm having. *should* be quicker than terminator, but due to startup/source logic issues i'm having no luck getting it to run without errors/lag

### Stop nautilus from opening up gnome desktops when launched (Needed for i3wm setups)

    gsettings set org.gnome.desktop.background show-desktop-icons false
    gsettings set org.gnome.desktop.background draw-background false
