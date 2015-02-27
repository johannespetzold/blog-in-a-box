FROM ubuntu

RUN apt-get install -y mysql-server

RUN apt-get install -y apache2 php5 php5-mysql
RUN a2dissite 000-default
ADD apache-wordpress.conf /etc/apache2/sites-available/wordpress.conf
RUN a2ensite wordpress
RUN a2enmod ssl

ADD https://wordpress.org/latest.tar.gz /
RUN tar xf latest.tar.gz
ADD wp-config.php /wordpress/
RUN chown -R www-data wordpress

RUN apt-get install -y wget
RUN wget https://api.wordpress.org/secret-key/1.1/salt
RUN ex +'g/put your unique phrase here/d' +r/salt +wq /wordpress/wp-config.php

ADD run.sh /
CMD /run.sh; bash
