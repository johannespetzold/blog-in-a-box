FROM ubuntu

RUN apt-key adv --keyserver keys.gnupg.net --recv-keys 1C4CBDCDCD2EFD2A
RUN echo deb http://repo.percona.com/apt trusty main >> /etc/apt/sources.list
RUN echo deb-src http://repo.percona.com/apt trusty main >> /etc/apt/sources.list
RUN apt-get update

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

RUN apt-get install -y duplicity percona-xtrabackup
RUN wget https://bootstrap.pypa.io/get-pip.py
RUN python get-pip.py
RUN pip install boto

ADD run.sh /
CMD /run.sh; bash
