FROM ubuntu:latest
MAINTAINER Hollman Enciso <hollman.enciso@gmail.com>
#Upgrade the latest packages of ubuntu and install apache, php and some basic libs
RUN apt-get update && apt-get -y dist-upgrade
RUN apt-get install -y apache2 php5 php5-gd php5-imagick php5-imap php5-mcrypt php5-memcached php5-mysql mysql-client

#Volume
VOLUME ["/var/www/html/"]

#Set some apache variables
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid
ENV APACHE_RUN_DIR /var/run/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2

RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

#Expose default apache port
EXPOSE 80

#run apache on background
CMD ["/usr/sbin/apache2", "-D", "FOREGROUND"]
