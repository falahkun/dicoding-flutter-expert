#!/usr/bin/env bash

# https://medium.com/@nocnoc/combined-code-coverage-for-flutter-and-dart-237b9563ecf8

# remember some failed commands and report on exit
error=false

show_help() {
    printf "usage: $0 [--help]
Tool for running all unit and widget tests with code coverage and automatically generated if lcov is installed.
(run from root of repo)
where:
    --help
        print this message
"
    exit 1
}

# run unit and widget tests
runTests () {
  cd $1;
  if [ -f "pubspec.yaml" ] && [ -d "test" ]; then
    echo "running tests in $1"
    flutter pub get

    escapedPath="$(echo $1 | sed 's/\//\\\//g')"

    # run tests with coverage
    if grep flutter pubspec.yaml > /dev/null; then
      echo "run flutter tests"
      if [ -f "test/all_tests.dart" ]; then
        flutter test --coverage test/all_tests.dart || error=true
      else
        flutter test --coverage || error=true
      fi
      if [ -d "coverage" ]; then
        # combine line coverage info from package tests to a common file
        sed "s/^SF:lib/SF:$escapedPath\/lib/g" coverage/lcov.info >> $2/coverage/lcov.info
      fi
    else
      echo "not a flutter package, skipping"
    fi
  fi
  cd - > /dev/null
}

runReport() {
    if [ -f "coverage/lcov.info" ] && ! [ "$TRAVIS" ]; then
        MIN_COVERAGE_PERC=80
        cd $1
        PATH="${pwd}/coverage/lcov.info"

        percentageRate=$(lcov --list "$PATH" | sed -n "s/.*Total:|\(.*\)%.*/\1/p")
        
        echo percentageRate
        pwd

        RED='\033[0;31m'
        GREEN='\033[0;32m'

        if [ "$(echo "${percentageRate} < $MIN_COVERAGE_PERC" | bc)" -eq 1 ]; then
            printf "${RED}Error: Your coverage rate is to low, expected ${MIN_COVERAGE_PERC}% but have ${percentageRate}%.\n"
            printf "${RED}Please add more tests to cover your code.\n"
            printf "${RED}To see in local your coverage rate use:\n"
            printf "${RED}    sh scripts/create_clean_lcov_and_generate_html.sh true\n"
            exit 1
        else
            printf "${GREEN}Coverage rate is fine 👍. Build continue...\n"
        fi
    fi
}

if ! [ -d .git ]; then printf "\nError: not in root of repo"; show_help; fi

case $1 in
    --help)
        show_help
        ;;
    *)
        currentDir=`pwd`
        # if no parameter passed
        if [ -z $1 ]; then
            rm -f coverage/lcov.info
            dirs=(`find . -maxdepth 2 -type d`)
            for dir in "${dirs[@]}"; do
                runTests $dir $currentDir
            done
        else
            if [[ -d "$1" ]]; then
                runTests $1 $currentDir
            else
                printf "\nError: not a directory: $1"
                show_help
            fi
        fi
           exit 0
        ;;
esac

# Fail the build if there was an error
if [ "$error" = true ] ;
then
    exit -1
fi
