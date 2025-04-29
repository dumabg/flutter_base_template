#!/bin/bash

# Source and destination directories
src_dir=../app_svg
dst_dir=assets

# Check if directories exist
if [ -d "$src_dir" ] && [ -d "$dst_dir" ]
then
  # Use find to get all .svg files
  find "$src_dir" -name "*.svg" -type f | while read -r src_file
  do
    # Construct the destination file path
    rel_path="${src_file#$src_dir}"
    dst_file="$dst_dir$rel_path"

    # Create the destination directory if it doesn't exist
    mkdir -p "$(dirname "$dst_file")"

    # Execute dart command on each file
    dart run vector_graphics_compiler -i "$src_file" -o "$dst_file".vec
  done
else
  echo "Source or destination directory does not exist"
fi
