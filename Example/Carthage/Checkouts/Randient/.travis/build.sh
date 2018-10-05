#!/bin/bash

if [ -n "$TRAVIS_TAG" ]; then
    bundle exec fastlane publish
else
    bundle exec fastlane test
fi
exit