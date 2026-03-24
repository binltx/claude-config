#!/bin/bash
# complexity-scan hook
# 复杂度扫描 - 在工具使用前评估任务复杂度

TASK_CONTEXT="$1"
TOOL_NAME="$2"

# 简单任务指标
SIMPLE_KEYWORDS="修改|bug|fix|typo|doc|readme|config"
# 复杂任务指标  
COMPLEX_KEYWORDS="新功能|重构|架构|多文件|前端|后端|数据库|认证|支付|复杂"

# 评估复杂度
calculate_complexity() {
    local task="$TASK_CONTEXT"
    
    # 检查复杂度关键词
    if echo "$task" | grep -qE "$COMPLEX_KEYWORDS"; then
        echo "complex"
    elif echo "$task" | grep -qE "$SIMPLE_KEYWORDS"; then
        echo "simple"
    else
        echo "moderate"
    fi
}

# 主逻辑
COMPLEXITY=$(calculate_complexity)

# 根据复杂度输出建议
case "$COMPLEXITY" in
    simple)
        echo "SIMPLE: 直接执行，无需组建团队"
        exit 0
        ;;
    moderate)
        echo "MODERATE: 建议组建 analyst-team 进行分析"
        exit 0
        ;;
    complex)
        echo "COMPLEX: 建议组建 analyst-team + java-pair + web-pair"
        exit 0
        ;;
esac

exit 0
