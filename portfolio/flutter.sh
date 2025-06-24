#!/bin/bash
# Install Flutter
git clone https://github.com/flutter/flutter.git --depth 1 -b stable
export PATH="$PATH:`pwd`/flutter/bin"

# Build the web app
flutter build web --release
