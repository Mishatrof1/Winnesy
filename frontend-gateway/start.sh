#!/bin/bash

set -exo pipefail


function check_env() {
  if [[ -z "${REQUIREMENTS}" ]]; then
    readonly PACKAGES=$(cat /var/www/requirements.txt || true)
  else
    readonly PACKAGES=${REQUIREMENTS}
  fi

}

function err() {
  echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $*" >&2
  exit 1
}

function run_with_retry() {
  local -r cmd=("$@")
  for ((i = 0; i < 10; i++)); do
    if "${cmd[@]}"; then
      return 0
    fi
    sleep 5
  done
  err "Failed to run command: ${cmd[*]}"
}

function main() {
  check_env

  if [[ -z "${PACKAGES}" ]]; then
    echo "ERROR: Must specify PACKAGES metadata key"
    exit 1
  fi

  run_with_retry pip install --no-cache-dir ${PACKAGES}

}

function start_app() {

  RUN=${RUN:-"python app.py"}

  CMD_START="$RUN"

  eval $CMD_START

}

function run() {
  if [[ -z "${PACKAGES}" ]]; then
    echo "INSTAL: pip packages"
    main
    echo "RUN: app.py"
    start_app
  else
    echo "RUN: app.py"
    start_app
  fi

}

main && start_app
