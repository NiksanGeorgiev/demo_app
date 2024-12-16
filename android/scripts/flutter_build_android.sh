#!/bin/sh

# Fail this script if any subcommand fails.
set -e

# # Function that shows usage information
# usage()
# {
#     echo ""
#     echo "Usage: $0 -c settings.prod"
#     echo "  -c | --config-file              File containing the Flutter compile time configuration settings."
#     echo "  -e | --environment              The environment for which the application should be build. Possible values are 'dev' or 'development', 'stg' or 'staging' and 'prod' or 'production'."   
#     echo "  --launcher-icon-config-file     The file containing the configuration needed to generate the launch icon. By default the 'flutter_launcher_icons.yaml' is used."
#     echo "  -h | --help                     Shows this help text."
# }

# LAUNCHER_ICON_CONFIG="flutter_launcher_icons.yaml"

# # Parse arguments
# while [ "$1" != "" ]; do
#     case $1 in
#         -c | --config-file)             shift
#                                         CONFIG_FILE=$1
#                                         ;;
#         -e | --environment)             shift
#                                         ENVIRONMENT=$1
#                                         ;;
#         --launcher-icon-config-file)    shift
#                                         LAUNCHER_ICON_CONFIG=$1
#                                         ;;
#         -h | --help )                   usage
#                                         exit
#                                         ;;
#         * )                             usage
#                                         exit 1
#     esac
#     shift
# done

# Change working directory to the project root 
cd ../../

# Make sure we work in a clean environment.
flutter clean

# Build the Flutter application.
flutter build appbundle --release