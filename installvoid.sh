#!/bin/bash

echo "Welcome to a simple script to get a minimally customised Hyprland on Void Linux."
read -p "Would you like to continue (y/n)? " installChoice

case "$installChoice" in
  # User wants to continue installation
  y|Y|yes|Yes|YES )

    read -p "Would you like to perform a system upgrade before continuing (y/n)? " upgradeChoice
    case "$upgradeChoice" in
      y/Y/yes/Yes/YES )
        echo "Upgrading system..."
        sudo xbps-install -Syu
      ;;
      n/N/no/No/NO )
        echo "Skipping system upgrade."
      ;;
    esac

    echo "Preparing to install other packages..."
    ler \
         
        echo "Installing repo nonfree..."  
        sudo xbps-install -Rs void-repo-nonfree    

        echo "Installing Video..."  
        sudo xbps-install -S xf86-video-vmware xf86-video-vesa mesa mesa-drive wayland wayland-protocols wayland-utils dbus avahi curl         

        echo "Installing utilities and system tools..."
        sudo xbps-install -S gdm

        echo "Installing fonts..."
        sudo xbps-install -S fontforge noto-fonts-emoji noto-fonts-cjk nerd-fonts-ttf nerd-fonts google-fonts-ttf
 
        echo "Installing utilities and system tools 2..."
        sudo sudo xbps-install -S hyprland hyprland-devel xdg-desktop-portal-hyprland kitty

        xbps-query -Rs hypr

        echo "Installing additional applications..."
        sudo xbps-install -S neofetch btop grub-customizer gvfs-mtp gvfs ntfs-3g mpv firefox wget git xz unzip zip nano vim gptfdisk xtools mtools mlocate  polkit seatd

        sudo xbps-install -S fuse-exfat bash-completion linux-headers gtksourceview4 ffmpeg mesa-vdpau mesa-vaapi utoconf automake bison m4 make libtool flex meson ninja optipng sassc
        
        echo "Installig audio"
        sudo xbps-install pulseaudio pulseaudio-utils pulsemixer alsa-plugins-pulseaudio bluez xfce4-terminal

        echo "Install LibreOffice:"
        #sudo xbps-install libreoffice-writer libreoffice-calc libreoffice-impress libreoffice-draw libreoffice-math libreoffice-base libreoffice-gnome libreoffice-i18n-pt-BR

        echo "Installing flatpak..."
        #sudo sudo xbps-install -S flatpak

        echo "Installing network-manager..."
        sudo xbps-install NetworkManager network-manager-applet 


        sudo reboot 

        echo "Starting services..."
        sudo ln -s /etc/sv/seatd /var/service/
        sudo ln -s /etc/sv/NetworkManager /var/service/
        sudo ln -sv /etc/sv/polkitd /var/service
        sudo ln -s /etc/sv/dbus /var/service/
        sudo usermod -aG _seatd ka
        

        	
    echo "All done! Please reboot for all changes to take effect."
  ;;

  # User does not want to continue installation.
  n|N|no|No|NO )
    echo "Thanks for trying, Goodbye!";;
esac
