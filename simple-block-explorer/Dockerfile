FROM php:7.1-apache

ARG MAIN_ENDPOINT_PROTOCOL=http
ARG MAIN_ENDPOINT_HOST=127.0.0.1
ARG MAIN_ENDPOINT_PORT=8332

ARG TEST_ENDPOINT_PROTOCOL=http
ARG TEST_ENDPOINT_HOST=127.0.0.1
ARG TEST_ENDPOINT_PORT=18332

WORKDIR /var/www/html
ADD https://raw.githubusercontent.com/jonasschnelli/simple-block-explorer/refs/heads/master/index.php index.php
RUN chown www-data:www-data index.php && chmod 644 index.php

# preparation for the replacement of the args
RUN sed -i '0,/http/{s/http/MAIN_ENDPOINT_PROTOCOL/}' index.php
RUN sed -i '0,/127.0.0.1/{s/127.0.0.1/MAIN_ENDPOINT_HOST/}' index.php
RUN sed -i '0,/8332/{s/8332/MAIN_ENDPOINT_PORT/}' index.php

RUN sed -i '0,/http/{s/http/TEST_ENDPOINT_PROTOCOL/}' index.php
RUN sed -i '0,/127.0.0.1/{s/127.0.0.1/TEST_ENDPOINT_HOST/}' index.php
RUN sed -i '0,/8332/{s/18332/TEST_ENDPOINT_PORT/}' index.php

# replace the placeholders with the actual values
RUN sed -i '0,/MAIN_ENDPOINT_PROTOCOL/{s/MAIN_ENDPOINT_PROTOCOL/'"${MAIN_ENDPOINT_PROTOCOL}"'/}' index.php
RUN sed -i 's/MAIN_ENDPOINT_HOST/'"${MAIN_ENDPOINT_HOST}"'/g' index.php
RUN sed -i 's/MAIN_ENDPOINT_PORT/'"${MAIN_ENDPOINT_PORT}"'/g' index.php

RUN sed -i '0,/TEST_ENDPOINT_PROTOCOL/{s/TEST_ENDPOINT_PROTOCOL/'"${TEST_ENDPOINT_PROTOCOL}"'/}' index.php
RUN sed -i 's/TEST_ENDPOINT_HOST/'"${TEST_ENDPOINT_HOST}"'/g' index.php
RUN sed -i 's/TEST_ENDPOINT_PORT/'"${TEST_ENDPOINT_PORT}"'/g' index.php
