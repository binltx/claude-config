#!/bin/bash
# complexity-check hook
# 任务复杂度检查 - 根据任务类型自动选择团队

# 读取输入（JSON格式的任务描述）
read input

# 从输入中提取任务信息
TASK=$(echo "$input" | jq -r '.task // empty')

if [ -z "$TASK" ]; then
    # 直接从命令行参数获取
    TASK="$1"
fi

# 复杂度关键词
COMPLEX_KEYWORDS="重构|架构|新功能|多文件|前端|后端|数据库|支付|复杂|设计"
MODERATE_KEYWORDS="修改|优化|bug|接口|配置|样式"

# 评估复杂度
if echo "$TASK" | grep -qE "$COMPLEX_KEYWORDS"; then
    RESULT="complex"
    TEAM="full-team"
elif echo "$TASK" | grep -qE "$MODERATE_KEYWORDS"; then
    RESULT="moderate"
    TEAM="analyst-team"
else
    RESULT="simple"
    TEAM=""
fi

# 输出JSON格式的hook响应
jq -n \
    --arg result "$RESULT" \
    --arg team "$TEAM" \
    '{
        "allow": true,
        "skip": false,
        "result": {
            "complexity": $result,
            "recommendedTeam": $team,
            "message": "复杂度评估完成"
        }
    }'
