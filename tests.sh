#!/usr/bin/env bash

# Test for repeatable outcomes.
# Would have preferred to do this in python, but
# with the current style of scripts it becomes much harder to read.

FILE="testfiles/quoted-printable.eml"
PASS=0
FAIL=0

# Run test 1

python anti-non-ubc.py <$FILE | diff -a -w -B $FILE -
ERRCODE=$?

if [ $ERRCODE -eq 0 ]
then
    ((PASS++))
else
    echo "FAIL: quoted-printable must be idempotent"
    ((FAIL++))
fi

echo "---------"
echo "Tests Passed: $PASS.  Tests Failed: $FAIL"

