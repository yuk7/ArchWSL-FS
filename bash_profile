# First run script for ArchWSL
echo Initialize keyring
pacman-key --init
pacman-key --populate

clear
rm ~/.bash_profile