FROM hypriot/rpi-alpine-scratch

RUN apk update && \
	apk add nginx git php perl php-fpm php-gd &&\
	mkdir /data && mkdir /data/gallery /data/cache &&\
	chmod -R 777 /data/cache/ &&\
	git clone --recursive git://github.com/UberGallery/UberGallery.git /var/www/localhost/htdocs/ &&\
	rm -rf /usr/share/nginx/html/ &&\	
	ln -s /var/www/localhost/htdocs/ /usr/share/nginx/html &&\	
	mv /var/www/localhost/htdocs/resources/sample.galleryConfig.ini /var/www/localhost/htdocs/resources/galleryConfig.ini &&\
	rm -rf /var/www/localhost/htdocs/gallery-images /var/www/localhost/htdocs/resources/cache &&\
	ln -s /data/gallery /var/www/localhost/htdocs/gallery-images &&\
	mkdir /var/www/localhost/htdocs/data &&\
	ln -s /data/cache /var/www/localhost/htdocs/data/cache &&\
	ln -s /data/cache /var/www/localhost/htdocs/resources/cache &&\
	chown -R nginx.nginx /var/www/localhost/htdocs/

ADD files/php.ini /etc/php/ 
ADD files/php-fpm.conf /etc/php/ 
ADD files/nginx.conf /etc/nginx/ 

EXPOSE 80

CMD /usr/bin/php-fpm && /usr/sbin/nginx && tail -f /var/log/nginx/error.log 
