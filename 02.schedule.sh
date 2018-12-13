#!/bin/bash
#
# (C) Copyright 2017 Hojin Choi <hojin.choi@gmail.com>
#
# vim: ts=4 noexpandtab sw=4 sts=4

. sejongrc

URL="https://ithub.korean.go.kr/user/total/database/corpusView.do"
TOTAL=$(wc -l logs/list.idx | awk '{print $1}')
CONCURRENT=20
STEP=$(( ($TOTAL-1)/$CONCURRENT + 1))
PROCNUM=0
while test $PROCNUM -lt $CONCURRENT
do
	./03.getcontent.sh $(($STEP * $PROCNUM + 1)) $STEP &
	PROCNUM=$(($PROCNUM+1))
done
trap 'kill 0; sleep 1; exit' SIGINT
wait
