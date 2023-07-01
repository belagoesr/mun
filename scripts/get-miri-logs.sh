#!/bin/bash

# This script collect logs for running Miri in each crate
# Note: Needs Miri installed to run

mkdir ../.logs
cd ../crates
cargo clean

for directory in * ; do
    echo "$directory"
    OUTPUT_FILE=../.logs/log_$directory
    MIRIFLAGS="\
    -Zmiri-disable-stacked-borrows \
    -Zmiri-backtrace=full \
    -Zmiri-disable-isolation" \
    RUST_BACKTRACE=full \
    cargo +nightly miri test --package $directory --no-fail-fast >> $OUTPUT_FILE 2>&1
done
