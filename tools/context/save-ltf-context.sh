#!/usr/bin/env bash
# save-ltf-context.sh - Bash wrapper for Save-LTFContext-v2.ps1
# Usage: bash save-ltf-context.sh -type <type> -label <label> [other options]

# Parse arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    -type)
      TYPE="$2"
      shift 2
      ;;
    -label)
      LABEL="$2"
      shift 2
      ;;
    -notes)
      NOTES="$2"
      shift 2
      ;;
    *)
      echo "Unknown option: $1"; exit 1
      ;;
  esac
done

if [[ -z "$TYPE" || -z "$LABEL" ]]; then
  echo "Usage: bash save-ltf-context.sh -type <type> -label <label> [-notes <notes>]"
  exit 1
fi

# Call PowerShell script
pwsh tools/context/Save-LTFContext-v2.ps1 -Type "$TYPE" -Label "$LABEL" ${NOTES:+-Notes "$NOTES"}
