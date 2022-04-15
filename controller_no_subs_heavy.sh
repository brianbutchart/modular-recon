#!/bin/bash

if [[ ! -d one_time ]]; then mkdir one_time; fi
if [[ ! -d one_time/$2 ]]; then mkdir one_time/$2; fi

DIR=one_time/$2

echo "VALIDATING DOMAIN(S)"
./validate.sh $1 | tee $DIR/val.txt

echo "VULNERABILITY SCANNING"
./vuln_scan_2.sh $DIR/val.txt | tee $DIR/vulns.txt
grep -E "\[unknown\]|\[low\]|\[medium\]|\[high\]|\[critical\]" vulns.txt > vulns_important.txt

echo "ENUMERATING FILES"
./enum_files_3.sh $DIR/val.txt | tee $DIR/files.txt

