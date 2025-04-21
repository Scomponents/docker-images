FROM eclipse-temurin:21.0.6_7-jre

RUN apt-get update && apt-get install -y \
	xorg \
	libasound2t64 \
	libgtk2.0-0 \
	apache2 \
	&& rm -rf /var/lib/apt/lists/*

RUN a2enmod proxy proxy_http rewrite ssl proxy_wstunnel

ENV MAINPATH=/opt/jpro-loadbalancer

WORKDIR $MAINPATH

COPY ./install.sh .
COPY ./ssl-redirect.conf.template .
COPY ./ports.conf.template .

CMD ./install.sh