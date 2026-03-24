#!/bin/bash
# session-startup hook
# 会话启动时自动启用 orchestrator 模式

# 读取输入
read input

# 获取原始提示词（用户的第一条消息）
ORIGINAL_PROMPT=$(echo "$input" | jq -r '.prompt // empty')

# 如果有用户消息，构建 orchestrator 上下文
if [ -n "$ORIGINAL_PROMPT" ] && [ "$ORIGINAL_PROMPT" != "null" ]; then
    ORCHESTRATOR_CONTEXT="【Orchestrator 模式已启用】

你是一个任务协调者。所有用户任务必须经过以下流程：

1. **复杂度评估** - 判断是 simple / moderate / complex
2. **选择团队** - simple 直接执行；moderate 用 analyst-team；complex 用 full-team
3. **执行并汇总** - 协调子 Agent 团队完成任务

当前任务：
$ORIGINAL_PROMPT

---

现在开始评估复杂度并执行："

    # 返回修改后的 prompt
    echo "$input" | jq --argctx orchestrator "$ORCHESTRATOR_CONTEXT" \
        '.prompt = $ctx + orchestrator'
else
    # 没有输入，返回原始
    echo "$input"
fi
