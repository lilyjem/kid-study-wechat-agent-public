# Changelog

All notable changes to this project will be documented in this file.

## [Unreleased]

### Added
- bundled `scripts/send_email.py` SMTP helper for easier standalone use
- `README.zh-CN.md` for Chinese documentation

### Changed
- `scripts/send_risk_alert_email.sh` now defaults to the bundled mail helper when `SMTP_SEND_SCRIPT` is not set
- expanded environment example with SMTP variables

## [0.1.0] - 2026-04-02

### Added
- initial public-safe release of the kid-study-wechat agent repository
- child tutoring configuration files
- configurable risk alert shell script
- environment variable example file
- public usage documentation

### Changed
- removed private email addresses, host-specific paths, and personal identifiers from the published repository
