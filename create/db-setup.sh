#!/bin/bash

mysql_app_user="root"
mysql_app_password="trinity"
database_hostname="localhost"
database_port="3306"

function prepare_database {

# setup mangos database
echo "$(date) [INFO]: Launching initial database setup ..."
echo "$(date) [INFO]: Creating databases"

 
echo "creating db"
mysql -u"${mysql_app_user}" -p"${mysql_app_password}"  < ../db/1.sql
echo "done creating db"

echo "auth.sql"
mysql -u"${mysql_app_user}" -p"${mysql_app_password}"  auth < ../db/2.sql
echo "done auth.sql"

echo "auth.sql"
mysql -u"${mysql_app_user}" -p"${mysql_app_password}"  characters < ../db/3.sql
echo "done char.sql"

echo "Full DB"
mysql -u"${mysql_app_user}" -p"${mysql_app_password}"  world < ../db/world.sql
echo "Full DB done"

echo "custom, updates and world sql files"
for sql_file in $(ls ../db/custom/auth/*.sql); do mysql -uroot -p"${mysql_app_password}" --database=auth < $sql_file ; done
for sql_file in $(ls ../db/custom/characters/*.sql); do mysql -uroot -p"${mysql_app_password}" --database=characters < $sql_file ; done
for sql_file in $(ls ../db/custom/world/*.sql); do mysql -uroot -p"${mysql_app_password}" --database=world < $sql_file ; done

for sql_file in $(ls ../db/updates/auth/3.3.5/*.sql); do mysql -uroot -p"${mysql_app_password}" --database=auth < $sql_file ; done
for sql_file in $(ls ../db/updates/characters/3.3.5/*.sql); do mysql -uroot -p"${mysql_app_password}" --database=characters < $sql_file ; done
for sql_file in $(ls ../db/updates/world/3.3.5/*.sql); do mysql -uroot -p"${mysql_app_password}" --database=world < $sql_file ; done

echo "Done with custom, updates and world sql files"



echo "done with db stuff"


}

function init {
prepare_database
}

init