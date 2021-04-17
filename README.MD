# Tạo mới 1 site :
- chạy command : sh docker/tools/create-site.sh

# Điền các thông tin :
- Site folder name : folder code cuả site định tạo (trong docker/www)

# Config nginx Magento 2 :
- docker/nginx/site-enable/...conf

upstream fastcgi_backend {
    server php73:9000;
}

server {

    listen       80;
    listen       443;
    server_name  <site_name>;

    set $MAGE_ROOT /var/www/html/folder-site;
    set $MAGE_MODE developer;
    set $PHP fastcgi_backend;
    set $MAGE_DEBUG_SHOW_ARGS 1;
    include /etc/nginx/snippest/magento2-php.conf;
}

# Config nginx Laravel

server {

    listen 80;
    listen 443;
    server_name  <site_name>;

    index index.php index.html;
    error_log  /var/log/nginx/error.log;
    access_log /var/log/nginx/access.log;
    root /var/www/html/folder-site/public;

    location ~ \.php$ {
        try_files $uri =404;
        fastcgi_split_path_info ^(.+\.php)(/.+)$;
        fastcgi_pass php73:9000;
        fastcgi_index index.php;
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        fastcgi_param PATH_INFO $fastcgi_path_info;

    }

    location / {
        try_files $uri $uri/ /index.php?$query_string;
        gzip_static on;
    }
}

# Tạo xong restart lại nginx và php
- docker restart nginx
- docker restart php73

# Config và test Elasticsearch local
- Stores -> Configuration -> Catalog -> Catalog -> Catalog Search
- bin/magento indexer:reindex catalogsearch_fulltext 
- bin/magento cache:flush
- $ curl -XGET 'localhost:9200/_search?size=1' -H 'Content-Type:application/json' -d '{ "query": { "match_all": {} } }'