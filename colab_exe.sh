#! /bin/bash

# Make Instance Ready for Remote Desktop or RDP

b='\033[1m'
r='\E[31m'
g='\E[32m'
c='\E[36m'
endc='\E[0m'
enda='\033[0m'

clear

# Branding

printf """$c$b   

      ██╗     ██╗███╗  ██╗██╗   ██╗██╗  ██╗   
      ██║░░░░░██║████╗░██║██║░░░██║╚██╗██╔╝   
      ██║░░░░░██║██╔██╗██║██║░░░██║░╚███╔╝░   
      ██║░░░░░██║██║╚████║██║░░░██║░██╔██╗░    
      ███████╗██║██║░╚███║╚██████╔╝██╔╝╚██╗    
      ╚══════╝╚═╝╚═╝░░╚══╝░╚═════╝░╚═╝░░╚═╝    
      
$endc$enda""";



# Used Two if else type statements, one is simple second is complex. So, don't get confused or fear by seeing complex if else statement '^^.

# Creation of user
printf "\n\nCreating user " >&2
if sudo useradd -m linux &> /dev/null
then
  printf "\ruser created $endc$enda\n" >&2
else
  printf "\r$r$b Error Occured $endc$enda\n" >&2
  exit
fi

# Add user to sudo group
sudo adduser linux sudo

# Set password of user to 'root'
echo 'linux:2112' | sudo chpasswd

# Change default shell from sh to bash
sed -i 's/\/bin\/sh/\/bin\/bash/g' /etc/passwd

# Initialisation of Installer
printf "\n\n$c$b    Loading Installer $endc$enda" >&2
if sudo apt-get update &> /dev/null
then
    printf "\r$g$b    Installer Loaded $endc$enda\n" >&2
else
    printf "\r$r$b    Error Occured $endc$enda\n" >&2
    exit
fi

# Installing Chrome Remote Desktop
printf "\n$g$b    Installing Chrome Remote Desktop $endc$enda" >&2
{
    wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb
    sudo dpkg --install chrome-remote-desktop_current_amd64.deb
    chmod +x ./chrome-remote-desktop_current_amd64.deb
    sudo apt install --assume-yes --fix-broken
} &> /dev/null &&
printf "\r$c$b    Chrome Remote Desktop Installed $endc$enda\n" >&2 ||
{ printf "\r$r$b    Error Occured $endc$enda\n" >&2; exit; }



# Install Desktop Environment (XFCE4)
printf "$g$b    Installing Desktop Environment $endc$enda" >&2
{
    sudo DEBIAN_FRONTEND=noninteractive \
        apt install --assume-yes xfce4 desktop-base xfce4-terminal
    sudo bash -c 'echo "exec /etc/X11/Xsession /usr/bin/xfce4-session" > /etc/chrome-remote-desktop-session'
    sudo apt remove --assume-yes gnome-terminal  
    sudo apt install --assume-yes xscreensaver
    sudo systemctl disable lightdm.service
} &> /dev/null &&
printf "\r$c$b    Desktop Environment Installed $endc$enda\n" >&2 ||
{ printf "\r$r$b    Error Occured $endc$enda\n" >&2; exit; }



# Install Google Chrome
printf "$g$b    Installing Google Chrome $endc$enda" >&2
{
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo dpkg --install google-chrome-stable_current_amd64.deb
    sudo apt install --assume-yes --fix-broken
} &> /dev/null &&
printf "\r$c$b    Google Chrome Installed $endc$enda\n" >&2 ||
printf "\r$r$b    Error Occured $endc$enda\n" >&2



# Install CrossOver (Run exe on linux)
printf "$g$b    Installing CrossOver $endc$enda" >&2
{
    wget https://media.codeweavers.com/pub/crossover/cxlinux/demo/crossover_20.0.4-1.deb
    sudo dpkg -i crossover_20.0.4-1.deb
    sudo apt install --assume-yes --fix-broken
} &> /dev/null &&
printf "\r$c$b    CrossOver Installed $endc$enda\n" >&2 ||
printf "\r$r$b    Error Occured $endc$enda\n" >&2

# Install Avidemux1
printf "$g$b    Installing Avidemux1 $endc$enda" >&2
{
    wget https://www.deb-multimedia.org/pool/main/a/avidemux-dmo/avidemux_2.7.8+20210616.gitdc323dac9-dmo1_amd64.deb
    sudo dpkg -i avidemux_2.7.8+20210616.gitdc323dac9-dmo1_amd64.deb
    sudo apt install --assume-yes --fix-broken
} &> /dev/null &&
printf "\r$c$b    CrossOver Installed $endc$enda\n" >&2 ||
printf "\r$r$b    Error Occured $endc$enda\n" >&2

# Install Avidemux2
printf "$g$b    Installing Avidemux2 $endc$enda" >&2
{
    wget https://www.deb-multimedia.org/pool/main/a/avidemux-dmo/avidemux-plugins_2.7.8+20210616.gitdc323dac9-dmo1_amd64.deb
    sudo dpkg -i avidemux-plugins_2.7.8+20210616.gitdc323dac9-dmo1_amd64.deb
    sudo apt install --assume-yes --fix-broken
} &> /dev/null &&
printf "\r$c$b    Avidemux1 Installed $endc$enda\n" >&2 ||
printf "\r$r$b    Error Occured $endc$enda\n" >&2


# Install Avidemux3
printf "$g$b    Installing Avidemux3 $endc$enda" >&2
{
    wget https://www.deb-multimedia.org/pool/main/a/avidemux-dmo/avidemux-qt_2.7.8+20210616.gitdc323dac9-dmo1_amd64.deb
    sudo dpkg -i avidemux-qt_2.7.8+20210616.gitdc323dac9-dmo1_amd64.deb
    sudo apt install --assume-yes --fix-broken
} &> /dev/null &&
printf "\r$c$b    Avidemux3 Installed $endc$enda\n" >&2 ||
printf "\r$r$b    Error Occured $endc$enda\n" >&2

# Install Aegisub1
printf "$g$b    Installing Aegisub1 $endc$enda" >&2
{
    wget http://ftp.br.debian.org/debian/pool/main/a/aegisub/aegisub_3.2.2+dfsg-6+b1_amd64.deb
    sudo dpkg -i aegisub_3.2.2+dfsg-6+b1_amd64.deb
    sudo apt install --assume-yes --fix-broken
} &> /dev/null &&
printf "\r$c$b    Aegisub1 Installed $endc$enda\n" >&2 ||
printf "\r$r$b    Error Occured $endc$enda\n" >&2

# Install Aegisub1
printf "$g$b    Installing Aegisub1 $endc$enda" >&2
{
    wget http://ftp.br.debian.org/debian/pool/main/a/aegisub/aegisub-l10n_3.2.2+dfsg-6_all.deb
    sudo dpkg -i aegisub-l10n_3.2.2+dfsg-6_all.deb
    sudo apt install --assume-yes --fix-broken
} &> /dev/null &&
printf "\r$c$b    Aegisub2 Installed $endc$enda\n" >&2 ||
printf "\r$r$b    Error Occured $endc$enda\n" >&2

# Install Font-Manager
printf "$g$b    Installing Font-manager $endc$enda" >&2
{
    wget http://ftp.br.debian.org/debian/pool/main/f/font-manager/font-manager_0.8.7-1_amd64.deb
    sudo dpkg -i font-manager_0.8.7-1_amd64.deb
    sudo apt install --assume-yes --fix-broken
} &> /dev/null &&
printf "\r$c$b    Font-manager Installed $endc$enda\n" >&2 ||
printf "\r$r$b    Error Occured $endc$enda\n" >&2

# Install ffmpeg
printf "$g$b    Installing ffmpeg $endc$enda" >&2
{
    wget http://ftp.br.debian.org/debian/pool/main/f/ffmpeg/ffmpeg_4.4-6_amd64.deb
    sudo dpkg -i ffmpeg_4.4-6_amd64.deb
    sudo apt install --assume-yes --fix-broken
} &> /dev/null &&
printf "\r$c$b    ffmpeg Installed $endc$enda\n" >&2 ||
printf "\r$r$b    Error Occured $endc$enda\n" >&2


# Install VLC Media Player 
printf "$g$b    Installing VLC Media Player $endc$enda" >&2
{
    sudo apt install vlc -y
} &> /dev/null &&
printf "\r$c$b    VLC Media Player Installed $endc$enda\n" >&2 ||
printf "\r$r$b    Error Occured $endc$enda\n" >&2

# Install other tools like nano
sudo apt-get install gdebi -y &> /dev/null
sudo apt-get install vim -y &> /dev/null
printf "$g$b    Installing other Tools $endc$enda" >&2
if sudo apt install nautilus nano -y &> /dev/null
then
    printf "\r$c$b    Other Tools Installed $endc$enda\n" >&2
else
    printf "\r$r$b    Error Occured $endc$enda\n" >&2
fi



printf "\n$g$b    Installation Completed $endc$enda\n\n" >&2



# Adding user to CRP group
sudo adduser linux chrome-remote-desktop

# Finishing Work
printf '\nvisit http://remotedesktop.google.com/headless and copy the debian linux command after authentication\n'
read -p "paste command here: " CRP
su - linux -c """$CRP"""

printf "\n$c$b I Hope this code helped you ' $endc$enda\n" >&2
printf "\n$c$b https://remotedesktop.google.com/access/ to access this virtual machine, do not close browser tab to keep colab running ' $endc$enda\n" >&2
printf "\n$g$b Finished Succesfully$endc$enda"
