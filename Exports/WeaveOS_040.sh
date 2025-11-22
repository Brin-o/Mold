#!/bin/sh
printf '\033c\033]0;%s\a' WeaveOS
base_path="$(dirname "$(realpath "$0")")"
"$base_path/WeaveOS_040.arm64" "$@"
