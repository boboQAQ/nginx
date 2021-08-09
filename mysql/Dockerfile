FROM mysql:5.7
ENV MYSQL_ROOT_PASSWORD uiotstack_1234
COPY my.cnf /etc/mysql/my.cnf
COPY db.sql /docker-entrypoint-initdb.d/
COPY update/* /docker-entrypoint-initdb.d/