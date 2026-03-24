#!/bin/bash
# session-end hook
# 会话结束 - 汇总任务结果

TASK_ID="$1"
DURATION="$2"
AGENTS_USED="$3"
OUTPUT_PATH="$4"

# 生成会话摘要
generate_summary() {
    local task_id="$1"
    local duration="$2"
    local agents="$3"
    
    echo "=== 任务会话摘要 ==="
    echo "任务ID: $task_id"
    echo "耗时: ${duration}秒"
    echo "使用Agent: $agents"
    echo "===================="
}

# 主逻辑
echo "$(generate_summary $TASK_ID $DURATION "$AGENTS_USED")"

# 通知 OpenClaw
# 这里可以添加通知逻辑

exit 0
