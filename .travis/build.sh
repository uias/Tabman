#!/bin/bash

fastlane test
if [ "${TRAVIS_BRANCH}" = "master" ] && [ -n "${TRAVIS_TAG}" ]; then
    fastlane deploy
fi