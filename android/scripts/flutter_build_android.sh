#!/bin/sh

# Fail this script if any subcommand fails.
set -e

# Change working directory to the project root 
cd ../../

# Make sure we work in a clean environment.
flutter clean

# Get the current version from pubspec.yaml
current_version=$(grep '^version:' pubspec.yaml | awk '{print $2}')

# Get the previous version from the last commit
previous_version=$(git show HEAD~1:pubspec.yaml | grep '^version:' | awk '{print $2}')

# Automatic version incrementation when version isn't changed manualy in pubspec.yaml
if [ "$current_version" == "$previous_version" ]; then
    # Extract the version code (the part after the '+')
    current_version_code=$(echo $current_version | awk -F'+' '{print $2}')

    new_version_code=$((current_version_code + 1))

    # Extract the version name (the part before the '+')
    current_version_name=$(echo $current_version | awk -F'+' '{print $1}')

    # Create the new version string
    new_version="$current_version_name+$new_version_code"

    # Update the pubspec.yaml file with the new version
    sed -i "s/^version: .*/version: $new_version/" pubspec.yaml
fi

# # Build the Flutter application.
# flutter build appbundle --release