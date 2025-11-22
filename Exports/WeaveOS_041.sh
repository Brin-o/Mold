#!/bin/sh
printf '\033c\033]0;%s\a' WeaveOS
base_path="$(dirname "$(realpath "$0")")"
"$base_path/WeaveOS_041.arm64" "$@"
