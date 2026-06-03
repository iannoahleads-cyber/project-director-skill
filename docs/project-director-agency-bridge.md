# Project Director 与 Agency 专家系统桥接说明

## 设计原则

`project-director` 必须始终是最终负责人。专家系统负责提供视角、报告和分工建议，但不能替代总控判断。

桥接后的核心流程：

```text
Intake -> Expert Fit -> Plan -> Dispatch/Workflow -> Review -> Integrate -> Verify -> Done
```

其中 `Expert Fit` 是新增判断门：

- 这个任务是否需要专家视角？
- 需要一个专家，还是多个专家？
- 适合总控直接套视角，还是开子智能体？
- 适合调用 `agency-orchestrator` 跑工作流吗？
- 结果如何验证？

## 三种专家路径

### 1. Expert Lens

适合小任务或紧耦合任务。总控不启动工作流，而是直接带着专家视角处理。

例子：

- 用代码审查员视角看一段代码
- 用安全工程师视角检查配置
- 用技术文档工程师视角改 README

### 2. Specialist Subagent

适合有清晰边界的探索、实现或审查。

子智能体提示词应包含：

- 专家身份
- 任务范围
- 禁止范围
- 验收标准
- 返回格式

示例身份：

```text
engineering/engineering-security-engineer
engineering/engineering-code-reviewer
testing/testing-performance-benchmarker
product/product-manager
design/design-ux-researcher
marketing/marketing-xiaohongshu-operator
```

### 3. Agency Workflow

适合复杂任务、多视角评审、商业分析、内容矩阵、需求评审、PR 审查。

推荐顺序：

1. `list_workflows` 查看现成 workflow。
2. `plan_workflow` 查看 DAG。
3. `validate_workflow` 校验配置。
4. `run_workflow` 执行。
5. 总控整合结果，过滤弱结论，做最终判断。

## 关键约束

- 不要为了“显得高级”而开大型专家团。
- 不要把专家报告原样交付给用户。
- 不要让多个 worker 写同一组文件。
- 不要把真实 API key 或私有 API URL 写入仓库。
- 专家输出中的事实、代码建议、法律/财务结论都必须二次核查。

## 推荐触发语

用户可以这样说：

```text
罗总，按总控模式处理。
```

```text
罗总，开专家视角分析。
```

```text
罗总，用 agency 自动选专家跑一下。
```

```text
罗总，让产品、技术、安全、体验一起会诊。
```

