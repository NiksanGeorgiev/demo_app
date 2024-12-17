#!/bin/sh

# Fail this script if any subcommand fails.
set -e

# Function that shows usage information
usage()
{
    echo ""
    echo "Usage: $0 -l 20"
    echo "  -l | --last-version             A number representing the version code of the last release on a given track."
    echo "  -h | --help                     Shows this help text."
}

# Parse arguments
while [ "$1" != "" ]; do
    case $1 in
        -l | --last-version )           shift
                                        last_version_code=$1
                                        ;;
        -h | --help )                   usage
                                        exit
                                        ;;
        * )                             usage
                                        exit 1
    esac
    shift
done

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
    # Increment the version code of the last released bundle
    new_version_code=$((last_version_code + 1))

    # Extract the version name (the part before the '+')
    current_version_name=$(echo $current_version | awk -F'+' '{print $1}')

    # Create the new version string
    new_version="$current_version_name+$new_version_code"

    # Update the pubspec.yaml file with the new version
    sed -i "s/^version: .*/version: $new_version/" pubspec.yaml
fi

# Build the Flutter application.
flutter build appbundle --release