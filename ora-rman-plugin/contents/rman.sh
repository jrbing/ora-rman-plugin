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

#export NLS_LANG=AMERICAN_AMERICA.WE8ISO8859P15
#export PATH=$PATH:/usr/local/bin:/usr/ccs/bin:/usr/sbin:/usr/ucb:/usr/openwin/bin:/etc:.

# Required arguments
oracle_sid=$1
rman_cmdfile=$2

# Check for Oracle SID
if [[ $oracle_sid ]]; then
  export ORACLE_SID=$oracle_sid
  export ORAENV_ASK=NO
  . oraenv
else
  printf "ORACLE_SID must be specified \n"
  exit 1
fi

rman cmdfile="$rman_cmdfile"
