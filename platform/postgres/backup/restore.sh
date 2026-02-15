#!/usr/bin/env bash
set -euo pipefail

: "${POSTGRES_HOST:?required}"
: "${POSTGRES_DB:?required}"
: "${POSTGRES_USER:?required}"
: "${PGPASSWORD:?required}"
: "${OCI_BUCKET:?required}"
: "${OCI_PREFIX:?required}"

echo "📦 Select backup tier:"
select TIER in daily weekly monthly; do
  if [[ -n "${TIER:-}" ]]; then
    break
  fi
done

REMOTE_PATH="oci:${OCI_BUCKET}/${OCI_PREFIX}/${TIER}/"

echo
echo "📂 Listing available ${TIER} backups..."
mapfile -t FILES < <(
  rclone lsf "${REMOTE_PATH}" | grep '\.sql\.gz$' | sort -r
)

if [[ "${#FILES[@]}" -eq 0 ]]; then
  echo "❌ No backups found in tier '${TIER}'"
  exit 1
fi

echo
echo "Available backups (${TIER}):"
select FILE in "${FILES[@]}"; do
  if [[ -n "${FILE:-}" ]]; then
    SELECTED="${FILE}"
    break
  fi
done

TMPFILE="/tmp/${SELECTED}"

echo
echo "⬇️ Downloading ${SELECTED}..."
rclone copy "${REMOTE_PATH}${SELECTED}" /tmp

echo
echo "⚠️ RESTORING INTO DATABASE '${POSTGRES_DB}'"
echo "   Source: ${TIER}/${SELECTED}"
read -rp "Type YES to continue: " CONFIRM
[[ "${CONFIRM}" == "YES" ]] || exit 1

gunzip -c "${TMPFILE}" | psql \
  -h "${POSTGRES_HOST}" \
  -U "${POSTGRES_USER}" \
  "${POSTGRES_DB}"

rm -f "${TMPFILE}"
echo "✅ Restore completed successfully"
