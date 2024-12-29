#!/usr/bin/env bash
# Copyright (c) IntechCore GmbH - All Rights Reserved
# SPDX-License-Identifier: APACHE-2.0

scriptPath="$(
  cd -- "$(dirname "$0")" >/dev/null 2>&1
  pwd -P
)"

distrFolder="${scriptPath}/Polarion"

requiredConfigsFolder="${distrFolder}/required_configs" # For success start if container was recreated

function add_required_configs {
  cp -r "${requiredConfigsFolder}"/* /
  a2enconf polarion polarionSVN
  apache2ctl restart
}

function stop_polarion {
  echo "Stopping Polarion..."
  /opt/polarion/bin/polarion.init stop
  exit 0
}

function run_polarion {
  echo "Running Polarion..."
  add_required_configs
  mkdir -p /var/log/polarion
  chown -R polarion:polarion /var/log/polarion
  /opt/polarion/bin/polarion.init start
  trap 'stop_polarion' SIGTERM
  sleep 3
  tail -100f /var/log/polarion/polarion.log
  #tail -f /dev/null
}

installFlag="/opt/polarion/bin/polarion.init"

if [ -f "${installFlag}" ]; then
  run_polarion
fi

echo "========================== BEGIN INSTALL OF POLARION =========================="

POLARION_LINUX_DISTR_ZIP_NAME="${POLARION_LINUX_DISTR_ZIP_NAME:-polarionALM_linux.zip}"

if [ ! -f "${distrFolder}/${POLARION_LINUX_DISTR_ZIP_NAME}" ]; then
  echo "Polarion distributive do not found. Exit, leaving the container running"
  tail -f /dev/null
fi

cd "${distrFolder}"

rm -rf ./Polarion
#rm -rf /opt/polarion/*

unzip -qq ./${POLARION_LINUX_DISTR_ZIP_NAME}

cd "./Polarion"

mkdir -p "${requiredConfigsFolder}"
cp -r ./libinstall/predefined/debian/* "${requiredConfigsFolder}/"

cp "${scriptPath}/manual_install-runner.exp" ./

export polarion_ignore_sql=yes
./manual_install-runner.exp

DB_PORT="${DB_PORT:-5432}"
DB_HOST="${DB_HOST:-localhost}"
DB_USER_NAME="${DB_NAME:-polarion}"
DB_PASS="${DB_PASS:-polarion}"

WWW_DATA_USER="${WWW_DATA_USER:-'www-data'}"
WWW_DATA_GROUP="${WWW_DATA_GROUP:-'www-data'}"

sed -i "s/internalPG=polarion/internalPG=${DB_USER_NAME}/g; s/@@PG_PSWD@@/${DB_PASS}/g; s/@@PG_PORT@@/${DB_PORT}/g; s/@localhost/@${DB_HOST}/g" /opt/polarion/etc/polarion.properties
sed -i "s/v_web_user=/v_web_user=${WWW_DATA_USER}/g; s/v_web_group=/v_web_group=${WWW_DATA_GROUP}/g" /opt/polarion/etc/config.sh

chown -R polarion:www-data /opt/polarion

cd "${distrFolder}"
rm -rf ./Polarion

add_required_configs

/opt/polarion/bin/polarion.init demo

run_polarion
