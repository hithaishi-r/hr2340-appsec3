FROM python:3.8-alpine


ENV PATH="/scripts:${PATH}"

COPY requirements.txt /requirements.txt

#### AA: There seems to be a lot of packages here
# RUN apk add openjdk11
# RUN apk add --no-cache mono --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing && \
#     apk add --no-cache --virtual=.build-dependencies ca-certificates && \
#     cert-sync /etc/ssl/certs/ca-certificates.crt && \
#     apk del .build-dependencies

RUN apk add --update --no-cache --virtual .tmp gcc libc-dev linux-headers
RUN apk add --update mysql-client
RUN apk add --update mariadb-dev
RUN pip3 install -r /requirements.txt

RUN apk del .tmp

RUN mkdir /GiftcardSite

COPY ./GiftcardSite /GiftcardSite

WORKDIR /GiftcardSite

COPY ./scripts /scripts

RUN chmod +x /scripts/*

RUN mkdir -p /vol/web/media
RUN mkdir -p /vol/web/static

RUN adduser -D django-app

RUN chown -R django-app:django-app /vol

RUN chmod -R 755 /vol/web

RUN chown -R django-app:django-app /GiftcardSite

# Todo change to user 'django-app'
USER django-app

CMD ["entrypoint.sh"]
