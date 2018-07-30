#!/bin/bash

echo "Configure PHP..."

# Load configurations
cp -f $ASSETS_DIRECTORY/config/php-cli/php.ini /etc/php/7.0/cli/php.ini
cp -f $ASSETS_DIRECTORY/config/php-fpm/php.ini /etc/php/7.0/fpm/php.ini

# Config PHP Timezone
sed -i "s|date.timezone =.*|date.timezone = ${PHP_TIMEZONE}|g" /etc/php/7.0/fpm/php.ini
sed -i "s|date.timezone =.*|date.timezone = ${PHP_TIMEZONE}|g" /etc/php/7.0/cli/php.ini

# Logs
mkdir -p $DATA_DIRECTORY/php-fpm
mkdir -p $DATA_DIRECTORY/php-cli
sed -i "s|error_log =.*|error_log = ${DATA_DIRECTORY}/php-fpm/errors.log|g" /etc/php/7.0/fpm/php.ini
sed -i "s|error_log =.*|error_log = ${DATA_DIRECTORY}/php-cli/errors.log|g" /etc/php/7.0/cli/php.ini

sed -i "s|www-data|root|g" /etc/php/7.0/fpm/pool.d/www.conf

# Load permissions
chown -R root:root \
    $DATA_DIRECTORY/php-fpm \
    $DATA_DIRECTORY/php-cli
