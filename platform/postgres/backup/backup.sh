#!/usr/bin/env bash
set -euo pipefail

: "${POSTGRES_HOST:?required}"
: "${POSTGRES_DB:?required}"
: "${POSTGRES_USER:?required}"
: "${PGPASSWORD:?required}"
: "${OCI_BUCKET:?required}"
: "${OCI_PREFIX:?required}"

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
FILENAME="postgres-${POSTGRES_DB}-${TIMESTAMP}.sql.gz"
TMPFILE="/tmp/${FILENAME}"

DAY_OF_WEEK=$(date +%u)   # 1-7 (Mon-Sun)
DAY_OF_MONTH=$(date +%d) # 01-31

echo "🔄 Starting backup: $FILENAME"

pg_dump \
  -h "${POSTGRES_HOST}" \
  -U "${POSTGRES_USER}" \
  "${POSTGRES_DB}" \
  | gzip > "${TMPFILE}"

upload() {
  local tier="$1"
  local dest="oci:${OCI_BUCKET}/${OCI_PREFIX}/${tier}/"

  echo "☁️ Uploading to ${tier}..."
  rclone copy "${TMPFILE}" "${dest}"
}

# Daily (always)
upload "daily"

# Weekly (Sunday)
if [[ "${DAY_OF_WEEK}" == "7" ]]; then
  upload "weekly"
fi

# Monthly (day 01)
if [[ "${DAY_OF_MONTH}" == "01" ]]; then
  upload "monthly"
fi

rm -f "${TMPFILE}"
echo "✅ Backup completed successfully"
