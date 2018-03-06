for target in $(rustup target list | grep -o -E '.*-apple-ios'); do
    rustup target add "$target"
done

gem   install xcpretty --no-rdoc --no-ri --no-document
cargo install --force cargo-lipo
