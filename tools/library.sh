#!/bin/bash

function get_debian_branch() {
  if grep -q 'trixie' /etc/os-release; then
    echo "testing";
  elif grep -q 'bookworm' /etc/os-release; then
    echo "stable";
  else
    echo "oldstable";
  fi
}

function get_machine_arch() {
  arch=$(uname -m);
  if [ "$arch" = "i686" ]; then
    echo "32";
  else
    echo "64";
  fi
}

function check_distro_commit() {
  versionFile="/run/live/medium/live/version";
  if [ -f $versionFile ]; then
    localVersion=$(cat $versionFile);
    if [ -d /tmp/immudex ]; then
      $(cd /tmp/immudex && git pull -q);
    else
      git clone -q https://github.com/xf0r3m/immudex /tmp/immudex;
    fi
    latestVersion=$(cd /tmp/immudex && git log --pretty=oneline | head -1 | cut -d " " -f 1);
    if [ "$1" ] && [ "$1" == "--print" ]; then
      echo "$(cd /tmp/immudex && git log ${localVersion}..${latestVersion})";
    fi
    if [ "$localVersion" = "$latestVersion" ]; then
      return 0;
    else
      return 1;
    fi
  else
    return 255;
  fi
}

function ascii_colors() {

  BLUE="\e[1;94m";
  RED="\e[1;91m";
  CYAN="\e[1;96m";
  ENDCOLOR="\e[0m";

  echo -e "${BLUE} _                           ${RED}    _      ${CYAN}      ${ENDCOLOR}";
  echo -e "${BLUE}(_)_ __ ___  _ __ ___  _   _ ${RED} __| | ___${CYAN}__  __${ENDCOLOR}";
  echo -e "${BLUE}| | '_ \` _ \| '_ \` _ \| | | |${RED}/ _\` |/ _ \\\\${CYAN} \/ /${ENDCOLOR}";
  echo -e "${BLUE}| | | | | | | | | | | | |_| |${RED} (_| |  __/${CYAN}>  < ${ENDCOLOR}";
  echo -e "${BLUE}|_|_| |_| |_|_| |_| |_|\__,_|${RED}\__,_|\___/${CYAN}_/\_\\";
  echo -e "${ENDCOLOR}";

}
