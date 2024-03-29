# Delete docs folder.
rm -rf docs

# Generate documentation.
jazzy \
  --author "Martin Essuman" \
  --author_url http://github.com/martin-e91.com \
  --github_url https://github.com/martin-e91/MGELogger/docs \
  --module MGELogger \
  --swift-build-tool spm \
  --theme fullwidth \
  --output docs
