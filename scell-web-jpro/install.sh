#!/usr/bin/env bash
# Copyright (c) IntechCore GmbH - All Rights Reserved
# SPDX-License-Identifier: APACHE-2.0

scriptPath="$(
  cd -- "$(dirname "$0")" >/dev/null 2>&1
  pwd -P
)"

mainWorkPath="${MAINPATH}"
sslConfigsPath="${mainWorkPath}/ssl/"
mkdir -p "${sslConfigsPath}"

APACHE_LOG_DIR="${mainWorkPath}/apache-logs"
mkdir -p "${APACHE_LOG_DIR}"

echo "Setting the env"
JPRO_SERVER_PORT="${JPRO_SERVER_PORT:-8080}"
echo "JPRO_SERVER_PORT=${JPRO_SERVER_PORT}"
JPRO_LOADBALANCER_START_PORT="${JPRO_LOADBALANCER_START_PORT:-8100}"
echo "JPRO_LOADBALANCER_START_PORT=${JPRO_LOADBALANCER_START_PORT}"

RUN_APACHE_HTTPS="${RUN_APACHE_HTTPS:-false}"
echo "RUN_APACHE_HTTPS=${RUN_APACHE_HTTPS}"

if [ "$RUN_APACHE_HTTPS" = true ]; then
  echo "===== RUN APACHE HTTPS REDIRECT ====="
  APACHE_HTTPS_COMMON_CONFIG="${APACHE_HTTPS_COMMON_CONFIG:-options-ssl-apache.conf}"
  APACHE_HTTPS_COMMON_CONFIG="${sslConfigsPath}${APACHE_HTTPS_COMMON_CONFIG}"
  echo "APACHE_HTTPS_COMMON_CONFIG=${APACHE_HTTPS_COMMON_CONFIG}"
  APACHE_HTTPS_HOST="${APACHE_HTTPS_HOST:-localhost}"
  echo "APACHE_HTTPS_HOST=${APACHE_HTTPS_HOST}"
  APACHE_HTTPS_PORT="${APACHE_HTTPS_PORT:-9090}"
  echo "APACHE_HTTPS_PORT=${APACHE_HTTPS_PORT}"
  APACHE_SSL_CERTIFICATE_FILE="${APACHE_SSL_CERTIFICATE_FILE:-fullchain.pem}"
  APACHE_SSL_CERTIFICATE_FILE="${sslConfigsPath}${APACHE_SSL_CERTIFICATE_FILE}"
  echo "APACHE_SSL_CERTIFICATE_FILE=${APACHE_SSL_CERTIFICATE_FILE}"
  APACHE_SSL_CERTIFICATE_KEY_FILE="${APACHE_SSL_CERTIFICATE_KEY_FILE:-privkey.pem}"
  APACHE_SSL_CERTIFICATE_KEY_FILE="${sslConfigsPath}${APACHE_SSL_CERTIFICATE_KEY_FILE}"
  echo "APACHE_SSL_CERTIFICATE_KEY_FILE=${APACHE_SSL_CERTIFICATE_KEY_FILE}"

  . "${mainWorkPath}/ssl-redirect.conf.template" > "/etc/apache2/sites-enabled/001-ssl-redirect.conf"
  . "${mainWorkPath}/ports.conf.template" > "/etc/apache2/ports.conf"
  apache2ctl start
fi

loadbalancerAppConfigFile="${mainWorkPath}/application.properties"

if [ -f "${loadbalancerAppConfigFile}" ]; then
  echo "Patching the ${loadbalancerAppConfigFile}"
  cp $loadbalancerAppConfigFile /application.properties
  sed -i "/^server\.port.*/s//server\.port = ${JPRO_SERVER_PORT}/" /application.properties
  sed -i "/^one\.jpro\.loadbalancer\.startPort.*/s//one\.jpro\.loadbalancer\.startPort = ${JPRO_LOADBALANCER_START_PORT}/" /application.properties
  cp /application.properties $loadbalancerAppConfigFile
fi

java -jar jpro-loadbalancer.jar
