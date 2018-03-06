#!/usr/bin/env bash

CARGO="$HOME/.cargo/bin/cargo"

if [[ "$CONFIGURATION" == "Release" ]]; then
    config="--release"
fi

if [[ "$PLATFORM_NAME" =~ .*macos.* ]]; then
    # macOS
    TARGETS="x86_64-apple-darwin,i686-apple-darwin"
else
    # iOS
    TARGETS="aarch64-apple-ios,armv7-apple-ios,armv7s-apple-ios,i386-apple-ios,x86_64-apple-ios"
fi

$CARGO lipo $config --targets $TARGETS
