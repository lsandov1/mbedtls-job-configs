#!/usr/bin/env bash

set -xe

yamls=( \
	lsandov1-mbed-tls-pr-head.yaml \
        lsandov1-mbed-tls-nightly-tests.yaml \
        lsandov1-mbed-tls-pr-ci-testing.yaml \
	lsandov1-mbedtls-pr-multibranch.yaml \
	lsandov1-mbed-tls-pr-test-parametrized.yaml \
    )

# migrate jobs
for yaml in ${yamls[*]}; do
    # test
    jenkins-jobs test $yaml -o mbed-tls-output

    # deploy
    jenkins-jobs --conf=$PWD/lsandov1-jenkins-jobs.ini update $yaml $(basename -s .yaml $yaml)
done
