#!/bin/bash

if [ -n "$TRAVIS_TAG" ]; then
    fastlane deploy
else
    fastlane test
fi
exit