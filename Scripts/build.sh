#!/usr/bin/env bash

CARGO="$HOME/.cargo/bin/cargo"

if [[ "$PLATFORM_NAME" =~ .*macos.* ]]; then
    # macOS
    $CARGO build --release --target "x86_64-apple-darwin"
else
    # iOS
    TARGETS="aarch64-apple-ios,armv7-apple-ios,armv7s-apple-ios,i386-apple-ios,x86_64-apple-ios"
    $CARGO lipo --release --targets $TARGETS
fi
