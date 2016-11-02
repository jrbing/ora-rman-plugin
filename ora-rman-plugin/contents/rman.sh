#!/usr/bin/env bash
#===============================================================================
# vim: softtabstop=2 shiftwidth=2 expandtab fenc=utf-8 spelllang=en
#===============================================================================
#
#          FILE: rman.sh
#
#   DESCRIPTION: Executes the specified rman script on a remote node
#
#===============================================================================

set -e                          # Exit immediately on error

# Required arguments
oracle_sid=$1
rman_cmdfile=$2

function echoinfo() {
  local GC="\033[1;32m"
  local EC="\033[0m"
  printf "${GC} ☆  INFO${EC}: %s\n" "$@";
}

function echoerror() {
  local RC="\033[1;31m"
  local EC="\033[0m"
  printf "${RC} ✖  ERROR${EC}: %s\n" "$@" 1>&2;
  exit 1
}

function validate_oracle_sid() {
  echoinfo "Validating ORACLE_SID"
  if [[ $oracle_sid ]]; then
    export ORACLE_SID=$oracle_sid
    export ORAENV_ASK=NO
    . oraenv
  else
    echoerror "ORACLE_SID must be specified"
  fi
}

function validate_rman_cmdfile() {
  if [[ -f $rman_cmdfile ]]; then
    echoinfo "Found $rman_cmdfile"
  else
    echoerror "Could not find $rman_cmdfile"
  fi
}

function run_rman_script() {
  echoinfo "Executing $rman_cmdfile"
  rman cmdfile="$rman_cmdfile"
}

validate_oracle_sid
validate_rman_cmdfile
run_rman_script
