#!/bin/bash

PHP_VERSION=$1
PHP_VERSION=${PHP_VERSION//[-._]/}
UNLOAD_VERSION=$2
PHP_EXTRA_EXTENSION=$3

# install php
yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum -y install https://rpms.remirepo.net/enterprise/remi-release-7.rpm
yum -y install yum-utils

yum-config-manager --enable epel
yum-config-manager --disable 'remi-php*'
yum-config-manager --enable remi-php$PHP_VERSION

# install tools required for a build
yum install npm -y
echo "Extra extensions: $PHP_EXTRA_EXTENSION"
yum install php $PHP_EXTRA_EXTENSION -y

# install composer
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('sha384', 'composer-setup.php') === '55ce33d7678c5a611085589f1f3ddf8b3c52d662cd01d4ba75c0ee0459970c2200a51f492d557530c71c15d8dba01eae') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
php -r "unlink('composer-setup.php');"
mv composer.phar /usr/local/bin/composer
export PATH=~/.composer/vendor/bin:$PATH

# check for packaged binary
if [ -f "unload" ]; then
    echo "Packaged binary exists...skip package installation"
    mv ./unload /usr/bin/unload
    unload --version
    return
fi

# install unload
curl https://github.com/unloadphp/unload/releases/download/$UNLOAD_VERSION/unload -o unload
chmod +x unload
mv ./unload /usr/bin/unload
unload --version
