#!/bin/bash
( set -x
sudo apt-get -y update &&
sudo add-apt-repository -y ppa:ondrej/php &&
sudo apt-get -y update &&
sudo apt-get install -y php5.6 &&
sudo apt-get install -y apache2 &&
sudo apt-get install -y libapache2-mod-php5.6 &&
sudo apt-get install -y php-memcache &&
sudo apt-get -y install awscli &&
sudo apt-get install -y php5.6-curl &&
sudo apt-get install -y php5.6-xml  &&
sudo apt-get install -y php5.6-xmlrpc &&
sudo apt-get install -y php5.6-mysql &&
sudo apt-get -y install unzip  &&
sudo apt-get install -y php7.0 php7.0-mysql libapache2-mod-php7.0 php7.0-cli php7.0-cgi php7.0-gd &&
sudo apt-get install -y python-software-properties &&
sudo aws s3 cp s3://arun-cloudfront-logs/AJ_web/asha-jyothi.zip /var/www/ &&
cd /var/www
rm -rf html
sudo unzip asha-jyothi.zip &&
sudo chmod -R 775 /var/www/html/ &&
sudo service apache2 restart
) 2>&1 | tee /tmp/aj-bootstrap.log