FROM ubuntu

RUN apt-get install -y mysql-server

RUN apt-get install -y apache2 php5 php5-mysql
RUN a2dissite 000-default
ADD apache-wordpress.conf /etc/apache2/sites-available/wordpress.conf
RUN a2ensite wordpress

ADD https://wordpress.org/latest.tar.gz /
RUN tar xf latest.tar.gz
ADD wp-config.php /wordpress/

ADD run.sh /
CMD /run.sh; bash
