#!/usr/bin/env bash
set -euo pipefail

RISK_TYPE="${1:-}"
RISK_SUMMARY="${2:-}"
ACCOUNT_ID="${3:-unknown}"

if [[ -z "$RISK_TYPE" || -z "$RISK_SUMMARY" ]]; then
  echo "Usage: $0 <risk_type> <sanitized_summary> [account_id]" >&2
  exit 2
fi

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
DEFAULT_SMTP_SEND_SCRIPT="${SCRIPT_DIR}/send_email.py"
SMTP_SEND_SCRIPT="${SMTP_SEND_SCRIPT:-$DEFAULT_SMTP_SEND_SCRIPT}"
ALERT_EMAIL_TO="${ALERT_EMAIL_TO:-}"
ALERT_SUBJECT_PREFIX="${ALERT_SUBJECT_PREFIX:-[儿童风险提醒]}"

if [[ -z "$ALERT_EMAIL_TO" ]]; then
  echo "Missing ALERT_EMAIL_TO. Example: export ALERT_EMAIL_TO=parent@example.com" >&2
  exit 4
fi

if [[ ! -f "$SMTP_SEND_SCRIPT" ]]; then
  echo "SMTP helper script does not exist: $SMTP_SEND_SCRIPT" >&2
  exit 5
fi

SUBJECT="${ALERT_SUBJECT_PREFIX} ${RISK_TYPE}"
BODY=$(cat <<EOF
agent: kid-study-wechat
accountId: ${ACCOUNT_ID}
类型: ${RISK_TYPE}
摘要: ${RISK_SUMMARY}
建议: 请尽快查看该儿童微信对话并跟进
EOF
)

python3 "$SMTP_SEND_SCRIPT" \
  --to "$ALERT_EMAIL_TO" \
  --subject "$SUBJECT" \
  --body "$BODY"
