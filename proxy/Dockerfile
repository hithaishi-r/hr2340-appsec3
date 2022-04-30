FROM nginx:mainline-alpine

COPY ./default.conf /etc/nginx/conf.d/default.conf
COPY ./uwsgi_params /etc/nginx/uwsgi_params
COPY ./sleep.sh /sleep.sh

USER root

RUN mkdir -p /vol/static
RUN chmod 777 /vol/static
RUN chmod +x /sleep.sh
RUN chmod 777 /var

RUN chown -R nginx:nginx /vol
RUN chown -R nginx:nginx /var
RUN touch /var/run/nginx.pid && chown -R nginx:nginx /run/nginx.pid
# ToDo Create a user with username 'nginx'

USER nginx