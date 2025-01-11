# Copyright (c) IntechCore GmbH - All Rights Reserved
# SPDX-License-Identifier: APACHE-2.0

FROM debian:bookworm
RUN apt-get update && apt-get install -y --no-install-recommends --no-install-suggests \
  locales \
  apache2 \
  libapache2-mod-svn \
  subversion \
  unzip \
  wget \
  expect \
  && rm -rf /var/lib/apt/lists/* \
  && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8

ENV LANG en_US.utf8

WORKDIR /opt/jdk
RUN wget --no-check-certificate -nv https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.9%2B9/OpenJDK17U-jdk_x64_linux_hotspot_17.0.9_9.tar.gz && \
  tar xzf OpenJDK17U-jdk_x64_linux_hotspot_17.0.9_9.tar.gz && \
  rm OpenJDK17U-jdk_x64_linux_hotspot_17.0.9_9.tar.gz

ENV JAVA_HOME="/opt/jdk/jdk-17.0.9+9" \
    JDK_HOME="/opt/jdk/jdk-17.0.9+9"
ENV PATH="$JAVA_HOME/bin":$PATH

WORKDIR /opt/distr

RUN adduser --quiet --disabled-password --gecos -M polarion

COPY ./manual_install-runner.exp .
COPY ./install.sh .
#ENTRYPOINT ["./install.sh"]
CMD ./install.sh
