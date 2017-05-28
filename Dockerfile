FROM debian:jessie

RUN apt-get update && apt-get install -y \
        nginx-extras \
        lua-json \
        lua-ldap \
        lua-filesystem \
        lua-socket

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
	&& ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 80

STOPSIGNAL SIGQUIT

RUN mkdir -p /etc/ssowat/portal/locales
COPY *.lua /etc/ssowat/
COPY portal/* /etc/ssowat/portal/
COPY test/conf.json /etc/ssowat/
COPY test/ssowat.conf /etc/nginx/conf.d/ssowat.conf

CMD ["nginx", "-g", "daemon off;"]
