#!/usr/bin/env bash

set -e -o pipefail

function build() {
    xcodebuild \
        -project $FRAMEWORK_NAME.xcodeproj \
        -scheme "$FRAMEWORK_NAME $1" \
        -destination "$2" \
        test | xcpretty
}

# ----- OS: --- Destination: ----------------------
build   macOS   "arch=x86_64"
build   iOS     "OS=9.0,name=iPhone 6S"
