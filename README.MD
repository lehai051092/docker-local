# Tạo mới 1 site :
- chạy command : sh docker/tools/create-site.sh

# Điền các thông tin :
- Site folder name : folder code cuả site định tạo (trong docker/www)

# Config nginx Magento 2 :
- docker/nginx/site-enable/...conf

upstream fastcgi_backend {
    server phpfpm7.3:9000;
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

# Tạo xong restart lại nginx và php
- docker restart nginx
- docker restart php73
