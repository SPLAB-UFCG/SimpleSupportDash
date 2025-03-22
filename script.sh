#!/bin/bash
sed -i 's/^LoadModule autoindex_module modules\/mod_autoindex.so/# LoadModule autoindex_module modules\/mod_autoindex.so/' /usr/local/apache2/conf/httpd.conf
exec "$@"
