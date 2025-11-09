#!/usr/bin/env bash
# resume-ltf.sh - Bash wrapper for Resume-LTF.ps1
# Usage: bash resume-ltf.sh -project <project> -type <type> [-label <label>] [-latest]

# Parse arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    -project)
      PROJECT="$2"
      shift 2
      ;;
    -type)
      TYPE="$2"
      shift 2
      ;;
    -label)
      LABEL="$2"
      shift 2
      ;;
    -latest)
      LATEST=1
      shift 1
      ;;
    *)
      echo "Unknown option: $1"; exit 1
      ;;
  esac
done

if [[ -z "$PROJECT" || -z "$TYPE" ]]; then
  echo "Usage: bash resume-ltf.sh -project <project> -type <type> [-label <label>] [-latest]"
  exit 1
fi

# Build command
CMD=(pwsh tools/context/Resume-LTF.ps1 -Project "$PROJECT" -Type "$TYPE")
if [[ -n "$LABEL" ]]; then
  CMD+=( -Label "$LABEL" )
fi
if [[ -n "$LATEST" ]]; then
  CMD+=( -Latest )
fi

# Call PowerShell script
"${CMD[@]}"
