# TOOLS.md - Kid Study WeChat Local Notes

## Parent Alert Target

- Alert email recipient: 通过环境变量 `ALERT_EMAIL_TO` 提供（示例：`parent@example.com`）
- SMTP script path: 通过环境变量 `SMTP_SEND_SCRIPT` 提供（示例：`/path/to/send_email.py`）
- Optional subject prefix: `ALERT_SUBJECT_PREFIX`（默认：`[儿童风险提醒]`）
- Preferred alert command: `bash scripts/send_risk_alert_email.sh`
- Purpose: 当儿童 agent 检测到高风险或明显影响儿童身心健康的负面信息时，立即发送邮件提醒家长

## Alert Format

发送方式：优先使用专用脚本。使用 `exec` 运行下面的命令发送邮件。

```bash
export ALERT_EMAIL_TO="parent@example.com"
export SMTP_SEND_SCRIPT="/path/to/send_email.py"
# 可选：export ALERT_SUBJECT_PREFIX="[儿童风险提醒]"

bash scripts/send_risk_alert_email.sh \
  "<风险类型>" \
  "<经过净化的简短摘要，不含具体危险方法>" \
  "<当前 accountId>"
```

脚本内部会调用：
- `SMTP_SEND_SCRIPT` 指定的发信脚本
- `ALERT_EMAIL_TO` 指定的收件人

要求：
- 只发送最小必要信息
- 不复述危险方法或长对话全文
- 主题里带风险类型
- 正文保持 5 行内，便于手机查看
- 严禁用 `sessions_send` 冒充邮件已发送
- 只有看到 `Email sent successfully` 或命令 0 退出，才算发送成功
- 仓库中不要写死真实邮箱、账号、密钥或绝对机器路径

## Noise Control

- 同一轮对话同类风险默认只提醒 1 次
- 若风险明显升级（如从低落升级到自伤/伤人），允许再次提醒
- 只发送必要摘要，不发送图像、不发送长对话全文
