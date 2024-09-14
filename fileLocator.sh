#!/bin/bash

#!/bin/bash

# Set default values
MIN_SIZE="100M"
OUTPUT_FILE="large_files.txt"
MAX_RESULTS=20
EXCLUDE_DIRS=("/System" "/private/var/vm")

# Parse command-line arguments
while getopts "s:o:n:e:" opt; do
    case $opt in
        s) MIN_SIZE="$OPTARG" ;;
        o) OUTPUT_FILE="$OPTARG" ;;
        n) MAX_RESULTS="$OPTARG" ;;
        e) IFS=',' read -ra EXCLUDE_DIRS <<< "$OPTARG" ;;
        *) echo "Usage: $0 [-s size] [-o output_file] [-n max_results] [-e exclude_dirs]" >&2
           exit 1 ;;
    esac
done

# Function to convert human-readable size to bytes
to_bytes() {
    local size=$1
    case ${size: -1} in
        K|k) echo $((${size%[Kk]} * 1024)) ;;
        M|m) echo $((${size%[Mm]} * 1024 * 1024)) ;;
        G|g) echo $((${size%[Gg]} * 1024 * 1024 * 1024)) ;;
        T|t) echo $((${size%[Tt]} * 1024 * 1024 * 1024 * 1024)) ;;
        *) echo $size ;;
    esac
}

# Build the exclude directory arguments
EXCLUDE_ARGS=""
for dir in "${EXCLUDE_DIRS[@]}"; do
    EXCLUDE_ARGS="$EXCLUDE_ARGS -not -path \"$dir/*\""
done

# Scan the system for large files
echo "Scanning for files larger than $MIN_SIZE..."
eval sudo find / -type f -size +$(to_bytes $MIN_SIZE) $EXCLUDE_ARGS \
    -exec du -sh {} + 2>/dev/null | sort -rh | head -n $MAX_RESULTS | \
    awk 'BEGIN {print "| File Path | Size |"
               print "|-----------|------|"}
         {print "| " $2 " | " $1 " |"}' > "$OUTPUT_FILE"

echo "Scan complete. Results have been saved to $OUTPUT_FILE"
echo "
WARNING: Do not delete any files unless you are absolutely certain it's safe to do so.
Review the list in $OUTPUT_FILE carefully and research any files you don't recognize before taking action."

# Display results in the terminal
cat "$OUTPUT_FILE"
