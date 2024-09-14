# File Locator Script Manual

## Overview

The File Locator script is a bash script designed to help macOS users identify large files on their system. It scans the entire file system and lists the largest files found, helping users to manage disk space more effectively.

## Usage
sudo ./fileLocator.sh [-s size] [-o output_file] [-n max_results] [-e exclude_dirs]


## Options

- `-s size`: Minimum file size to consider (default: 100M)
- `-o output_file`: File to save results (default: large_files.txt)
- `-n max_results`: Maximum number of results to display (default: 20)
- `-e exclude_dirs`: Comma-separated list of directories to exclude (default: /System,/private/var/vm)

## Examples

1. Run with default settings:
   ```bash
   sudo ./fileLocator.sh
   ```

2. Find files larger than 1GB:
   ```bash
   sudo ./fileLocator.sh -s 1G
   ```

3. Save results to a custom file:
   ```bash
   sudo ./fileLocator.sh -o my_large_files.txt
   ```

4. Display top 50 results:
   ```bash
   sudo ./fileLocator.sh -n 50
   ```

5. Exclude additional directories:
   ```bash
   sudo ./fileLocator.sh -e "/System,/private/var/vm,/Users/username/Downloads"
   ```

## Output

The script generates a Markdown-formatted table with two columns:
1. File Path
2. Size

The results are sorted by size in descending order.

## Warnings

- The script requires root permissions to access all directories.
- Do not delete any files unless you are absolutely certain it's safe to do so.
- Always review the list carefully and research any unfamiliar files before taking action.

## Limitations

- The script does not automatically delete files.
- It may take some time to run on systems with many files or slow disks.
- Some system files may still be included in the results, so exercise caution.

## Troubleshooting

If you encounter permission errors, ensure you're running the script with `sudo`.

For any other issues, check that the script has execute permissions: