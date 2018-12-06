#!/bin/bash

echo "Création du fichier vagrant"
touch Vagrantfile
echo "Choisissez votre nom de dossier partagé"
read -p "./" dir
mkdir $dir

cat > vagrantfile << eof
# -- mode: ruby --
# vi: set ft=ruby :
Vagrant.configure("2") do |config|
config.vm.box = "ubuntu/xenial64"
config.vm.network "private_network", ip: "192.168.33.30"
config.vm.synced_folder "./$dir", "/var/www/html"
config.vm.provision "shell", inline: <<-SHELL
    sudo apt update
    sudo apt install apache2 php7.0 libapache2-mod-php7.0 -y
SHELL
end
eof
vagrant up
vagrant ssh

# echo "Que voulez vous faire ?"
# echo "1)Donner la liste des vagrants qui sont lancés"
# echo "2)Intéragir avec unes des Vagrants allumées"
# read choice
# if [ $choice == "1" ]
# then
#   echo "Voici la liste des vagrants lancés :"
#   ps xev
# elif [ $choice == "2" ]
# then
#   echo "Voulez-vous éteindre la Vagrants ?"
#   ????
# else
#   echo "Vous avez tapé un mauvais chiffre."
# fi
