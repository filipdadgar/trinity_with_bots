FROM mariadb
RUN apt-get update -y && apt-get upgrade -y

RUN DEBIAN_FRONTEND="noninteractive" apt-get install -y \
	bash

ENV MYSQL_ROOT_PASSWORD trinity
#ENV MYSQL_USER trinity
ENV MYSQL_PASSWORD trinity

RUN mkdir -p /db
ADD db /db


ADD create/db-setup.sh /docker-entrypoint-initdb.d

USER mysql
VOLUME /var/lib/mysql

#ADD my.cnf /etc/mysql/

EXPOSE 3306
CMD ["mysqld", "--max-allowed-packet=32505856"]