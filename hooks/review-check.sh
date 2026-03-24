#!/bin/bash
# review-check hook
# 代码审查检查 - 提交前自动检查

read input

# 检查是否有未解决的TODO或FIXME
FILES=$(echo "$input" | jq -r '.files // [] | .[]' 2>/dev/null)

HAS_ISSUES=false
ISSUES=()

for file in $FILES; do
    if [ -f "$file" ]; then
        # 检查TODO/FIXME
        if grep -qE "TODO|FIXME|XXX|HACK" "$file" 2>/dev/null; then
            HAS_ISSUES=true
            ISSUES+=("发现未完成的标记: $file")
        fi
    fi
done

# 输出JSON格式的hook响应
if [ "$HAS_ISSUES" = true ]; then
    jq -n \
        --argjson issues "$(printf '%s\n' "${ISSUES[@]}" | jq -R . | jq -s .)" \
        '{
            "allow": true,
            "skip": false,
            "result": {
                "passed": false,
                "issues": $issues,
                "message": "检查完成，发现未完成的标记"
            }
        }'
else
    jq -n \
        '{
            "allow": true,
            "skip": false,
            "result": {
                "passed": true,
                "issues": [],
                "message": "检查通过"
            }
        }'
fi
