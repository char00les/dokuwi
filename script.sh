#!/bin/bash


echo "Installing Packages"
sudo apt-get install apache2 libapache2-mod-php php-xml --yes

echo "Restarting Apache2"
sudo systemctl restart apache2

echo "Download Dokuwiki"
sudo wget https://download.dokuwiki.org/src/dokuwiki/dokuwiki-stable.tgz -P /var/www/
sudo tar xzvf /var/www/dokuwiki-stable.tgz -C /var/www/

echo "Get folder name"
getFolderName=$(ls /var/www/ | grep dokuwiki | grep -v tgz)
echo "This is the folder name = $getFolderName"

echo "Change Folder Name to dokuwiki"
sudo mv /var/www/$getFolderName /var/www/dokuwiki/

echo "change ownership"
sudo chown -R www-data:www-data /var/www/dokuwiki

echo "copy over config"
sudo cat config/000-default.conf > /etc/apache2/sites-enabled/000-default.conf
sudo cat config/apache2-dokuwiki.conf > /etc/apache2/sites-available/apache2-dokuwiki.conf
sudo cat config/apache2.conf > /etc/apache2/apache2.conf

echo "reload apache"
sudo systemctl reload apache2

echo "Delete Downloaded File"
sudo rm /var/www/dokuwiki-stable.tgz

echo "done"
