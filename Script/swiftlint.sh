if which swiftlint >/dev/null; then
  swiftlint
  echo "swiftlint installed."
else
  echo "warning: SwiftLint not installed, install it running make install"
fi