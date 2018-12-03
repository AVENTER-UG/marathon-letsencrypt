FROM debian:latest
MAINTAINER Andreas Peters <mailbox@andreas-peters.net>

WORKDIR /
ENV DEBIAN_FRONTEND=noninteractive
ENV CERTBOT_VERSION=v0.28.0
RUN apt-get update \
  && apt-get install -y unzip curl python-pip python \
  && pip install --upgrade pip \
  && pip install virtualenv --upgrade  \
#  && pip install cryptography --upgrade \
  && curl -Ls -o /certbot.zip https://github.com/certbot/certbot/archive/${CERTBOT_VERSION}.zip \
  && unzip certbot.zip \
  && mv certbot-${CERTBOT_VERSION} certbot \
  && cd certbot \
  && ./certbot-auto --os-packages-only --noninteractive \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 80

WORKDIR /certbot
COPY run.sh /certbot/run.sh
COPY post_cert.py /certbot/post_cert.py

ENTRYPOINT ["/certbot/run.sh"]
