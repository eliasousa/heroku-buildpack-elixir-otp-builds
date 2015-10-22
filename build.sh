#!/usr/bin/env bash

function run_build {
  local heroku_stack=$1
  local otp_version=$2

  echo "HEROKU STACK: $heroku_stack"
  echo "OTP VERSION: $otp_version"

  sudo docker build -t otp-build -f ${heroku_stack}.dockerfile .
  sudo docker run -t -e OTP_VERSION=$otp_version --name=otp-build-${otp_version}-${heroku_stack} otp-build

  sudo docker cp otp-build-${otp_version}-${heroku_stack}:/home/build/out/OTP-${otp_version}.tar.gz otp-builds/OTP-${otp_version}-${heroku_stack}.tar.gz
  ls builds/otp
}

mkdir -p builds/otp
head -n1 otp-versions

run_build $HEROKU_STACK $(head -n1 otp-versions)