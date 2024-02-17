HELPERS_PATH=$(realpath "$(dirname "${BASH_SOURCE[0]}")")

# Imports
. "$HELPERS_PATH"/text-util.sh

log() {
  echo -e "$ICyan $1 $Color_Off"
}

success() {
  echo -e "$IGreen $1 $Color_Off"
}

warn() {
  echo -e "$BIYellow $1 $Color_Off"
}

error() {
  echo -e "$IRed $1 $Color_Off"
}
