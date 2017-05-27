FROM debian:jessie

RUN apt-get update && apt-get install -y \
        nginx-extras \
        lua-json \
        lua-ldap

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
	&& ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 80

STOPSIGNAL SIGQUIT

CMD ["nginx", "-g", "daemon off;"]
