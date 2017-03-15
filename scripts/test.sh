#!/usr/bin/env bash

if [ "$TRAVIS_BRANCH" == "master" ] || [ "$TRAVIS_BRANCH" == "develop" ]; then
    sh <(curl -s https://codecov.io/bash)
fi
