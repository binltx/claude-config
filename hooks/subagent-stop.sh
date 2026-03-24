#!/bin/bash
# state-transition hook
# 状态转换 - 子 Agent 停止时的状态管理

AGENT_ID="$1"
AGENT_TYPE="$2"
EXIT_CODE="$3"
OUTPUT_PATH="$4"

# 状态记录
STATE_FILE="/tmp/claude-agent-state.json"

# 读取当前状态
read_state() {
    if [ -f "$STATE_FILE" ]; then
        cat "$STATE_FILE"
    else
        echo '{"agents": {}}'
    fi
}

# 更新状态
update_state() {
    local agent_id="$1"
    local status="$2"
    local exit_code="$3"
    
    echo "Agent $agent_id ($status) exited with code $exit_code"
    
    # 检查是否所有子 agent 都完成
    # 如果是，触发协调者汇总
}

# 主逻辑
case "$AGENT_TYPE" in
    "analyst")
        echo "Analyst $AGENT_ID completed analysis"
        ;;
    "driver"|"navigator")
        echo "Pair agent $AGENT_ID completed"
        ;;
    "orchestrator")
        echo "Orchestrator $AGENT_ID completed - task finished"
        ;;
esac

exit 0
