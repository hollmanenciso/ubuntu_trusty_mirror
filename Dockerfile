FROM ubuntu:latest
MAINTAINER Hollman Enciso <hollman.enciso@gmail.com>

#upgrade our OS and install the neccesary packages
RUN apt-get update && apt-get -y dist-upgrade
RUN apt-get install -y apt-mirror apache2
RUN rm /var/www/html/index.html

#Add the file with all repository that we need
ADD files/mirror.list /etc/apt/

#Add crontalb to update your mirror server every days at 4 AM -- you can change this
RUN echo "0 4 * * * apt-mirror  > /var/spool/apt-mirror/var/cron.log" >> /etc/crontab

#Start downloading the pachages for the mirror
RUN apt-mirror

#create a symbolic link of the mirror to the document root of apache
RUN ln -s /var/spool/apt-mirror/skel/archive.ubuntu.com/ubuntu/ /var/www/html/ubuntu

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
