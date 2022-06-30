#!/usr/bin/env bash

# Requires https://github.com/manolo/shell2junit in shel2junit folder
. shell2junit/sh2ju.sh

juLogClean

check_output () { # $1-string
  #check if $1 is found in app.out
  if grep -q "${1}" app.out; then
    return 0
  else
    return 1
  fi
}

juLog -name="military uniform" check_output "0.919721: 653:military uniform"
juLog -name="windsor tie" check_output "0.017762: 907:Windsor tie"
juLog -name="mortarboard" check_output "0.007507: 668:mortarboard"
juLog -name="bulletproof vest" check_output "0.005419: 466:bulletproof vest"
juLog -name="bow tie" check_output "0.003828: 458:bow tie, bow-tie, bowtie"

