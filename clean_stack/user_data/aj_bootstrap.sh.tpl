#!/bin/bash
( set -x
sudo yum -y update &&
sudo yum -y install git &&
cd /root/.ssh &&
wget https://s3.amazonaws.com/uploads.hipchat.com/191613/3218019/65nvHVc6cMLmJaM/id_rsa &&
chmod 400 /root/.ssh/id_rsa &&
echo "changed permissions" &&
echo -e "Host github.com\n\tStrictHostKeyChecking no\n" >> ~/.ssh/config &&
sudo yum -y install httpd mod_ssl &&
sudo /usr/sbin/apachectl start &&
sudo iptables -I INPUT -p tcp --dport 80 -j ACCEPT &&
sudo service iptables save &&
sudo /sbin/chkconfig httpd on &&
sudo /sbin/chkconfig --list httpd &&
sudo yum -y install php php-mysql php-devel php-gd php-pecl-memcache php-pspell php-snmp php-xmlrpc php-xml &&
sudo /usr/sbin/apachectl restart &&

#cloning the website
cd /var/www/ &&
git clone git@github.com:arunsanna/aj_site.git &&
rm -rf /var/www/html &&
mv /var/www/aj_site /var/www/html &&

rm -rf /etc/httpd/conf/httpd.conf
mv /var/www/html/httpd.conf /etc/httpd/conf &&
service httpd restart &&
echo "code completed"
) 2>&1 | tee /tmp/aj-bootstrap.log