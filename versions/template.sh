#!/bin/bash

function update_packages() {
  apt update;
  apt upgrade -y;
}

function install_packages() {
  apt install $@ -y;
}


function tidy() {
  apt-get clean;
  apt-get clean;
  apt-get autoremove -y;
  apt-get autoclean;
  rm -rf ~/immudex-sdk;
  rm /var/cache/apt/*.bin;
  echo > ~/.bash_history;
  history -c   
}
