#!/bin/bash

# Ansi colors
RESET=$(echo -en "\033[0m")
BOLD=$(echo -en "\033[1m")
RED=$(echo -en "\033[1;31m")
YELLOW=$(echo -en "\033[1;33m")
PURPLE=$(echo -en "\033[1;35m")
CYAN=$(echo -en "\033[1;36m")
GREEN=$(echo -en "\033[1;32m")
BLUE=$(echo -en "\033[1;34m")

function addRegexp() {
  if [ "$REGEXP" != "" ]; then
    REGEXP="$REGEXP;"
  fi
  REGEXP="${REGEXP}s/$1/$2&$RESET/g"
}

# Cyan info
addRegexp "INFO" "$CYAN"

# Red errors
addRegexp "ERROR" "$RED"
addRegexp "FATAL" "$RED"
addRegexp "SEVERE" "$RED"

# Yellow warnings
addRegexp "WARNING" "$YELLOW"

# Green build success
addRegexp "BUILD SUCCESS\(FUL\)\{0,1\}" "$GREEN"

# Red build failures
addRegexp "BUILD FAILURE\{0,1\}" "$RED"

# Bold hosts
addRegexp "https\{0,1\}:\/" "$BOLD"

# Bold paths
addRegexp "\(\/[[:alnum:]._-]\{1,\}\)\{2,\}" "$BOLD"

# Bold builds
addRegexp "Building .*" "$BOLD"

# Red exceptions
addRegexp "\([[:lower:]][[:alnum:]]*\.\)*[[:alpha:]]*[[:alnum:]]*Exception" "$RED"

# Red errors
addRegexp "[Ee]rrors\{0,1\}" "$RED"

# Red failed
addRegexp "[Ff]ailed" "$RED"

# Red fail, failure, failures
addRegexp "[Ff]ail\(ures\{0,1\}\)\{0,1\} " "$RED"

# Yellow warn, warning, warnings
addRegexp "[Ww]arn\(ings\{0,1\}\)\{0,1\}" "$YELLOW"

mvn "$@" | sed -e "$REGEXP"

exit ${PIPESTATUS[0]}
