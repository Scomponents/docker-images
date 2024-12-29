FROM eclipse-temurin:21.0.4_7-jre

RUN apt-get update && apt-get install -y \
	xorg \
	libasound2t64 \
	libgtk2.0-0 \
	&& rm -rf /var/lib/apt/lists/*

ENV MAINPATH=/opt/jpro-loadbalancer

WORKDIR $MAINPATH

# COPY ./files .

CMD ["java", "-jar", "jpro-loadbalancer.jar"]

# EXPOSE 8080-8120
