# kid-study-wechat-agent-public

一个适合公开发布、已完成隐私清理的微信学习辅导 Agent 仓库，面向小学生学习场景。

这个仓库重点关注三件事：
- 适龄、清楚、分步骤的学习辅导行为
- 面向儿童对话场景的安全边界
- 在出现高风险表达时，能够通过外部邮件脚本发送真实风险预警

> English README: [README.md](./README.md)

## 仓库包含什么

这个仓库主要包含 Agent 规则文件和辅助脚本：
- `AGENTS.md`、`SOUL.md`、`TOOLS.md` 等提示词/配置文件
- 一个风险预警 shell 脚本
- 一个内置 SMTP 发信脚本 `scripts/send_email.py`
- 一个安全的环境变量示例文件 `.env.example`

这个仓库**不包含**：
- 真实邮箱地址
- SMTP 密钥或密码
- 平台 token
- 宿主机私有绝对路径
- 聊天记录或运行时状态

## 功能特点

- 默认儿童友好的学习辅导风格
- 数学题采用“三步辅导”思路
- 拒绝危险、成人、不适龄或越权内容
- 对自伤、自杀、霸凌、威胁等高风险表达进行升级处理
- 通过环境变量配置风险预警邮件能力

## 如何使用

### 1. 准备运行环境

你需要自备运行环境，例如：
- OpenClaw 或兼容的 Agent Runtime
- 微信通道接入
- Python 3（用于运行仓库自带的 SMTP 脚本）

### 2. 配置环境变量

复制 `.env.example`，或者在你的运行环境中注入这些变量：

```bash
export ALERT_EMAIL_TO="parent@example.com"
export ALERT_SUBJECT_PREFIX="[Child Risk Alert]"

# 方式一：直接使用仓库自带的 send_email.py，配置 SMTP_* 变量
export SMTP_HOST="smtp.example.com"
export SMTP_PORT="587"
export SMTP_USER="your-email@example.com"
export SMTP_PASSWORD="your-app-password"
export SMTP_FROM="your-email@example.com"
export SMTP_USE_SSL="false"

# 方式二：如果你已有自己的发信脚本，可覆盖默认实现
# export SMTP_SEND_SCRIPT="/absolute/path/to/send_email.py"
```

### 3. 触发风险预警脚本

```bash
bash scripts/send_risk_alert_email.sh "self-harm risk" "sanitized short summary" "account-id"
```

默认情况下，这个脚本会调用仓库内置的：
- `scripts/send_email.py`

如果你设置了 `SMTP_SEND_SCRIPT`，则会优先使用你自己的脚本。

### 4. 接入 Agent 逻辑

建议你的 Agent Runtime 在识别到儿童高风险表达时执行以下流程：
1. 先在当前聊天里做简短、安全的劝阻与安抚
2. 再调用 `bash scripts/send_risk_alert_email.sh ...`
3. 只有当真实邮件发送成功时，才算完成风险提醒

## 仓库结构

```text
.
├── .env.example
├── AGENTS.md
├── HEARTBEAT.md
├── IDENTITY.md
├── LICENSE
├── README.md
├── README.zh-CN.md
├── SOUL.md
├── TOOLS.md
├── USER.md
└── scripts/
    ├── send_email.py
    └── send_risk_alert_email.sh
```

## 发布与隐私说明

这个公开仓库已经做过隐私清理：
- 不包含真实收件人邮箱
- 不包含 secrets
- 不包含个人 SMTP 配置
- 不包含宿主机私有路径
- 不包含旧的私有 git 历史

## 许可证

MIT
