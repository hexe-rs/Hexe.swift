for target in $(rustup target list | grep -o -E '.*-apple-ios'); do
    rustup target add "$target"
done

cargo install --force cargo-lipo
