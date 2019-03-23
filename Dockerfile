FROM certbot/certbot
LABEL maintainer="Andreas Peters <support@aventer.biz>"

EXPOSE 80

RUN apk add bash curl

COPY run.sh /opt/certbot/run.sh
COPY post_cert.py /opt/certbot/post_cert.py

ENTRYPOINT ["/opt/certbot/run.sh"]
