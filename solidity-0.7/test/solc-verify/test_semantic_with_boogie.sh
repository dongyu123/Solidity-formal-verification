#!/usr/bin/env bash

#------------------------------------------------------------------------------
# Bash script to run solc-verify tests.
#
# The documentation for solidity is hosted at:
#
#     https://solidity.readthedocs.org
#
# ------------------------------------------------------------------------------
# This file is part of solidity.
#
# solidity is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# solidity is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with solidity.  If not, see <http://www.gnu.org/licenses/>
#
# (c) 2016 solidity contributors.
#------------------------------------------------------------------------------

## GLOBAL VARIABLES

REPO_ROOT=$(cd $(dirname "$0")/../.. && pwd)
SOLCVERIFY_TESTS="test/solc-verify"
SOLCSEMANTIC_TESTS="test/libsolidity/semanticTests"
SOLCVERIFY="$REPO_ROOT/build/solc/solc-verify.py"

## COLORS
RED=
GREEN=
BLACK=
YELLOW=
if test -t 1 ; then
  RED=$(tput setaf 1)
  GREEN=$(tput setaf 2)
  BLACK=$(tput sgr0)
  YELLOW=$(tput setaf 3)
fi

# Time format
TIMEFORMAT="%U"

## Keep track of failed tests
UNKNOWN_TESTS=0
FAILED_TESTS=()
TOTAL_TESTS=0

## Printout
function report() {
    test_name="$1"
    elapsed="$2"
    message="$3"
    TOTAL_TESTS=$((TOTAL_TESTS+1))
    echo -n "$TOTAL_TESTS. $test_name "
    if [ ! -z "$message" ]
    then
        echo -n $YELLOW
        echo ?? [$elapsed s]
        FAILED_TESTS+=("$YELLOW$test_name$BLACK"$'\n'"$message")
    else
        echo -n $GREEN
        echo OK [$elapsed s]
        UNKNOWN_TESTS=$((UNKNOWN_TESTS+1))
    fi
    echo -n $BLACK
}

# Temp files
OUT_PATH=`mktemp`
TIME_PATH=`mktemp`

# Run SOLC-VERIFY and check result based on file, arguments and expected output
function solcverify_check()
{
    filename="${1}"
    shift
    solcverify_args="$@ --verbose"

    # Test id
    test_string="$filename"
    [[ !  -z  $solcverify_args  ]] && test_string="$test_string [ $solcverify_args ]"

    # Run it
    (time "$SOLCVERIFY" "${filename}" ${solcverify_args} >& $OUT_PATH) >& $TIME_PATH
    exitcode=$?
    elapsed=$(cat $TIME_PATH)

    # Check exit code
    if [ $exitcode -ne 0 ]
    then
        message=`cat $OUT_PATH`
        report "$test_string" "$elapsed" "$message"
    else
        report "$test_string" "$elapsed" ""
    fi
}

# Get the test list
cd $REPO_ROOT
TESTS=""
for filename in `find $SOLCSEMANTIC_TESTS -name "*.sol"`;
do
    solcverify_check "$filename" "$@"
done

# Remove temps
rm -f $OUT_PATH $TIME_PATH

echo "---------- Details ----------"
# Print the details of the failed tests
for i in "${!FAILED_TESTS[@]}";
do
    echo "$((i+1)). ${FAILED_TESTS[$i]}";
done

echo "---------- Summary ----------"
echo "total: $TOTAL_TESTS"
echo "failed: ${#FAILED_TESTS[@]}"
echo
echo "failures:"
printf -- '%s\n' "${FAILED_TESTS[@]}" | grep -e "solc-verify error:.*" -o | sort | uniq -c
printf -- '%s\n' "${FAILED_TESTS[@]}" | grep -e "solc-verify.*exception:.*" -o | sort | uniq -c
printf -- '%s\n' "${FAILED_TESTS[@]}" | grep -e ".bpl\(.*\): Error" | grep -e ": Error:.*" -o | sort | uniq -c
printf -- '%s\n' "${FAILED_TESTS[@]}" | grep -e "Segmentation fault (core dumped)" -o | sort | uniq -c
echo
echo "warnings:"
printf -- '%s\n' "${FAILED_TESTS[@]}" | grep -e "solc-verify warning: .*" -o | sort | uniq -c
