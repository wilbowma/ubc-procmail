#!/usr/bin/env bash

# Test for repeatable outcomes.
# Would have preferred to do this in python, but
# with the current style of scripts it becomes much harder to read.

PASS=0
FAIL=0
check_errcode() {
    ERRCODE=$?

    if [ $ERRCODE -eq $1 ]
    then
        ((PASS++))
    else
        echo "$2"
        ((FAIL++))
    fi
}
    


FILE="testfiles/quoted-printable.eml"

# Test 1 : anti-non-ubc idempotent for quoted-printable

python anti-non-ubc.py <$FILE | diff -a -w -B $FILE -
check_errcode 0 "FAIL: quoted-printable must be idempotent in anti-non-ubc"

# Test 2 : un_hxxps idempotent for quoted-printable
python un-hxxps.py <$FILE | diff -a -w -B $FILE -
check_errcode 0 "FAIL: quoted-printable must be idempotent in un_hxxps"



echo "---------"
echo "Tests Passed: $PASS.  Tests Failed: $FAIL"

