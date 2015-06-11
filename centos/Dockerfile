FROM centos:6.6
MAINTAINER Hollman Enciso <hollman.enciso@gmail.com>

#Se instalan paquetes necesarios
RUN yum -y install httpd php5
ADD html/index.html /var/www/html/
ADD scripts/run_services.sh /usr/bin/run_services.sh
RUN chmod 755 /usr/bin/run_services.sh
RUN echo "ServerName localhost" >> /etc/httpd/conf/httpd.conf
#RUN echo "service httpd start" >> /etc/rc.local
#CMD ["/usr/bin/run_services.sh"]
