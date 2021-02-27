#!/bin/bash

set -euo pipefail

SECRETMAN_ROOT=$(realpath "$(dirname "$0")/..")
source "$SECRETMAN_ROOT/lib/load-env.sh"

if [ -z "${BACKUPS_GPG_KEY:-}" ]
then
  echo "BACKUPS_GPG_KEY is not defined in $SECRETMAN_CONFIG."
  exit
fi

cd "$1"

# Add pending changes to git repository.
git add .
git commit                               \
  --no-edit                              \
  --quiet                                \
  --allow-empty-message                  \
  --author="secretman <$USER@$HOSTNAME>" \
  || exit

# Create a bundle and encrypt it with the GPG from config.
mkdir -p "$SECRETMAN_BACKUPS"
git bundle create - --all        \
  | gpg -r "$BACKUPS_GPG_KEY" -e \
  > "$SECRETMAN_BACKUPS/backup-$(date +%s).gitbundle.gpg"

# Delete old backups.
find "$SECRETMAN_BACKUPS"                   \
  -name 'backup-*.gitbundle.gpg'            \
  -exec ls -1 --sort=time --time=ctime {} + \
  | tail -n +$((BACKUPS_COUNT+1))           \
  | xargs -rd \\n rm -v
