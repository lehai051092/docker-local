#!/bin/bash
read -p "Site folder name: " NAME

read -p "MYSQL root password: " MYSQL_ROOT_PASSWORD
read -p "MYSQL username: " MYSQL_USER
read -p "MYSQL password: " MYSQL_PASSWORD
read -p "MYSQL database: " MYSQL_DATABASE

echo "Create folder code: "

docker exec -i nginx bash -c "mkdir -vp '/var/www/html/${NAME}'"

echo "Create database: ${MYSQL_DATABASE}"
docker exec mariadb mysql -uroot -p${MYSQL_ROOT_PASSWORD} -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE} ;
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
