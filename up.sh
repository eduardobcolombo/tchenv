#!/bin/sh
# Usage: To load a specific ssh git aws config 
# Author: Eduardo B Colombo
# -------------------------------------------------
# clear
home="/Users/ecolombo"
basepath="$home/.ssh/configs"

printf "Below are the found configurations.\n\n"

index=1
for entry in "$basepath"/*/
do
	echo "$index) $(basename "$entry")"

	array[ $index ]="$(basename "$entry")"        
   ((index++))
done

printf "\n"

read -p "Type the number of the wished config: " foldername
echo "Ok, working on it ..."

foldername=${array[$foldername]}
rm -r  ~/.ssh/config
ln -sf $basepath/$foldername/config ~/.ssh/config
rm -r  ~/.gitconfig
ln -sf $basepath/$foldername/.gitconfig ~/.gitconfig
rm -r  ~/.ssh/id_rsa
ln -sf $basepath/$foldername/id_rsa ~/.ssh/id_rsa
rm -r  ~/.ssh/id_rsa.pub
ln -sf $basepath/$foldername/id_rsa.pub ~/.ssh/id_rsa.pub
rm -r  ~/.ssh/known_hosts
ln -sf $basepath/$foldername/known_hosts ~/.ssh/known_hosts
rm -rf $home/.aws
ln -s $basepath/$foldername/.aws ~/.aws	

#source $basepath/$foldername/.bash_profile

chmod 0600 ~/.ssh/id_rsa.pub ~/.ssh/id_rsa

export GPG_TTY=$(tty)

echo "\nDone. Your environment is configured as \"$foldername\""
