FROM nginx:1.19-alpine
COPY docker/nginx/nginx.conf /etc/nginx/nginx.conf
COPY docker/nginx/web.conf /etc/nginx/conf.d/default.conf
COPY docker/nginx/conf/*.conf /etc/nginx/conf.d/
COPY docker/nginx/conf/*.tpl /etc/nginx/conf.d/
ADD web/ /usr/share/nginx/html
COPY docker/nginx/entrypoint.sh /
COPY docker/nginx/main /
CMD ["/entrypoint.sh"]