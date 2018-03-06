#!/usr/bin/env bash

CARGO="$HOME/.cargo/bin/cargo"

if [[ "$CONFIGURATION" == "Release" ]]; then
    config="--release"
fi

if [[ "$PLATFORM_NAME" =~ .*macos.* ]]; then
    TARGET_SUFFIX="darwin"
else
    TARGET_SUFFIX="ios"
fi

TARGETS=""
for arch in $ARCHS; do
    if [[ -n "$TARGETS" ]]; then
        TARGETS+=","
    fi
    if [[ "$arch" == "arm64" ]]; then
        arch="aarch64"
    fi
    TARGETS+="$arch-apple-$TARGET_SUFFIX"
done

echo "Compiling hexec for $ARCHS with TARGETS=$TARGETS"

$CARGO lipo $config --targets $TARGETS
