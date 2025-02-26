# Checks the specified directory for .rar files. If uncompressed .mkv files already
# exist in the directory or subdirectories, the file is skipped. If there is no .mkv,
# unar uncompresses the .rar.

# Dry run
find /path/to/directory -type f -name "*.rar" -exec sh -c
'
  for rar_file; do
    dir=$(dirname "$rar_file")
    if ! ls "$dir"/*.mkv >/dev/null 2>&1; then
      echo "Would extract: $rar_file"
    else
      echo "Skipping $rar_file (MKV already exists)"
    fi
  done
' sh {} +

# Send it
find /path/to/directory -type f -name "*.rar" -exec sh -c '
  for rar_file; do
    dir=$(dirname "$rar_file")
    if ! ls "$dir"/*.mkv >/dev/null 2>&1; then
      unar -o "$dir" "$rar_file"
    else
      echo "Skipping $rar_file (MKV already exists)"
    fi
  done
' sh {} +
