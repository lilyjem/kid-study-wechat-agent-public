# kid-study-wechat-agent-public

[中文说明 / Chinese README](./README.zh-CN.md)

A public, privacy-scrubbed version of a WeChat-based tutoring agent for elementary school learners.

This repository focuses on three things:
- age-appropriate tutoring behavior
- clear safety boundaries for child-facing conversations
- real risk-alert email escalation through an external mail script

## What this repository contains

This repository contains the agent-facing files and helper scripts only:
- prompt/config files such as `AGENTS.md`, `SOUL.md`, and `TOOLS.md`
- a configurable risk alert shell script
- a bundled SMTP helper script (`scripts/send_email.py`)
- a safe example environment file

It does **not** include:
- real email addresses
- SMTP credentials
- provider tokens
- host-specific absolute paths
- chat transcripts or runtime state

## Features

- child-friendly tutoring defaults
- three-step tutoring approach for math questions
- refusal rules for dangerous, adult, or inappropriate content
- escalation path for self-harm, suicide, bullying, threats, or other severe child-safety signals
- configurable alert email delivery via environment variables

## How to use

### 1. Prepare your runtime

You need your own host environment with:
- an OpenClaw-compatible runtime or equivalent agent host
- a WeChat channel integration
- Python 3 for the bundled SMTP helper script

### 2. Configure environment variables

Copy `.env.example` and set your real values outside the repository:

```bash
export ALERT_EMAIL_TO="parent@example.com"
export ALERT_SUBJECT_PREFIX="[Child Risk Alert]"

# Either use the bundled helper with SMTP_* variables...
export SMTP_HOST="smtp.example.com"
export SMTP_PORT="587"
export SMTP_USER="your-email@example.com"
export SMTP_PASSWORD="your-app-password"
export SMTP_FROM="your-email@example.com"
export SMTP_USE_SSL="false"

# ...or override with your own helper script if you prefer
# export SMTP_SEND_SCRIPT="/absolute/path/to/send_email.py"
```

### 3. Trigger the risk alert script

```bash
bash scripts/send_risk_alert_email.sh "self-harm risk" "sanitized short summary" "account-id"
```

By default, this uses the bundled helper:
- `scripts/send_email.py`

If `SMTP_SEND_SCRIPT` is set, that custom helper script will be used instead.

### 4. Integrate with your agent

Your agent runtime should be configured so that high-risk child-safety content triggers:
1. a short in-chat safety response
2. execution of `bash scripts/send_risk_alert_email.sh ...`
3. success only when the actual external mail command succeeds

## Repository layout

```text
.
├── .env.example
├── AGENTS.md
├── HEARTBEAT.md
├── IDENTITY.md
├── LICENSE
├── README.md
├── SOUL.md
├── TOOLS.md
├── USER.md
└── scripts/
    ├── send_email.py
    └── send_risk_alert_email.sh
```

## Privacy and publishing notes

This public repository is intentionally scrubbed:
- no real recipient email addresses
- no secrets
- no personal mail configuration
- no machine-specific private paths
- no prior private git history

## License

MIT
