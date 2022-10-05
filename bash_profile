# First run script for ArchWSL
echo Initialize keyring
rm -rf /etc/pacman.d/gnupg/
rm -rf /root/.gnupg/
clear
pacman-key --init
pacman-key --populate

clear

# WSL1 check
FSTYPE_LIST=$(cat /proc/self/mounts | awk '{print $3}')
if [[ $FSTYPE_LIST == *lxfs* || $FSTYPE_LIST == *wslfs* ]] ; then
    echo ----- WARNING -----
    echo This distribution instance running in WSL1 now.
    echo You need patched glibc to continue working with WSL1.
    echo Please refer the documentation for more details.
    echo
    read -p "Would you like to install the glibc-linux4 package? (y/n):" -n 1 -r
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        yes | pacman -U /root/glibc-linux4.pkg.tar.zst
        echo
        echo glibc-linux4 is a 3rd party package and will not be updated automatically.
        echo You need to manage this package with AUR helpers or 3rd party repositories.
        echo
    fi
fi

rm /root/glibc-linux4.pkg.tar.zst
rm /root/.bash_profile