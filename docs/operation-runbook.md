# 运行手册

## 1. 安装

```powershell
Set-ExecutionPolicy -Scope Process Bypass -Force
.\scripts\setup-agency-stack.ps1
```

## 2. 配置本地密钥

复制 `.env.example`，在本机私有位置填写真实配置。

```powershell
Copy-Item .env.example .env
notepad .env
```

不要提交 `.env`。

## 3. 验证 CLI

```powershell
ao --version
ao roles --agents-dir ".\agency-stack\agency-agents-zh"
ao validate ".\workflows\local-smoke-test.yaml"
ao plan ".\workflows\project-expert-review.yaml"
```

## 4. 跑最小工作流

```powershell
ao run ".\workflows\local-smoke-test.yaml" -i topic="deployment smoke test"
```

输出中应包含：

```text
AO_SMOKE_OK
```

## 5. 跑专家评审

```powershell
ao run ".\workflows\project-expert-review.yaml" -i project_brief=@brief.md
```

## 6. MCP 使用

当 MCP server 已配置后，可用工具包括：

```text
list_roles
list_workflows
validate_workflow
plan_workflow
compose_workflow
run_workflow
```

如果 MCP 报缺少 API key，通常是已运行的 MCP 进程还没读取新 `.env`。重启 Codex 会话或 MCP server 后再试。

