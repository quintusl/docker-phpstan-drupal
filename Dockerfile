FROM ghcr.io/phpstan/phpstan:latest-php8.1
LABEL maintainer="Quintus Leung"

RUN apk --update --progress --no-cache add icu-dev libxml2-dev libpng-dev curl-dev libzip-dev \
	&& docker-php-ext-install gd bcmath curl zip
RUN composer global config --no-plugins allow-plugins.phpstan/extension-installer true
RUN composer global config --no-plugins allow-plugins.mglaman/composer-drupal-lenient true
RUN composer global require phpstan/extension-installer
RUN composer global require mglaman/phpstan-drupal
RUN composer global require phpstan/phpstan-deprecation-rules
RUN composer global require mglaman/composer-drupal-lenient
RUN mkdir /output
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

WORKDIR /drupal
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
