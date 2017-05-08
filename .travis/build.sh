#!/bin/bash

fastlane test
if [ "${TRAVIS_BRANCH}" = "master" ]; then
    fastlane deploy
fi