FROM marvambass/nginx-ssl-secure
MAINTAINER codedevote

# Set this to rancher url via docker option '-e RANCHER_URL=myrancher.example.org'
ENV RANCHER_URL localhost

# add nginx config for rancher server
ADD rancher.conf /etc/nginx/conf.d/rancher.conf

# overwrite entrypoint script
ADD entrypoint.sh /opt/entrypoint.sh
RUN chmod a+x /opt/entrypoint.sh

EXPOSE 80 443