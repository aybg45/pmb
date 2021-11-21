#!/bin/bash

function initialiser_db {
	service mysql stop
	mysql_install_db
	service mysql start
	echo "CREATE USER 'admin'@'localhost' IDENTIFIED BY 'admin'; GRANT ALL PRIVILEGES ON *.* TO 'admin'@'localhost' WITH GRANT OPTION;" | mysql -uroot
}

function initialiser_parametres {
	mkdir /etc/pmb
	touch /etc/pmb/db_param.inc.php
	chown www-data:www-data /etc/pmb/db_param.inc.php
	ln -s /etc/pmb/db_param.inc.php /var/www/html/pmb/includes/db_param.inc.php
    ln -s /etc/pmb/db_param.inc.php /var/www/html/pmb/opac_css/includes/opac_db_param.inc.php
}

ls /var/www/html/pmb/includes/db_param.inc.php || initialiser_parametres
chown -R mysql:mysql /var/lib/mysql
service mysql start
echo '' | mysql -uadmin -padmin || initialiser_db
service php7.0-fpm start
nginx -g 'daemon off;'


#Welcome Jperon, it's one of your pupil. I'd like help you this but I don't know this language. Ayth
