#!/bin/bash

scriptDir=$(dirname -- "$(readlink -f -- "$BASH_SOURCE")")

curl -L -o $scriptDir/cis-audit.sh https://raw.githubusercontent.com/finalduty/cis_benchmarks_audit/master/cis-audit.sh
chmod 755 $scriptDir/cis-audit.sh
