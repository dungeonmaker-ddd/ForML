#!/bin/bash
# gen-chat-manifest.sh — 生成 chat-manifest.json
# 用法: 在项目根目录运行  bash gen-chat-manifest.sh
# 产出: chat-manifest.json (供 chat-viewer.html 自动装载文件列表)

cd "$(dirname "$0")"

files=()
while IFS= read -r -d '' f; do
  files+=("$(echo "$f" | sed 's|^./||')")
done < <(find . -name "*.txt" -not -path "./.git/*" -print0)

# Sort
IFS=$'\n' sorted=($(sort <<<"${files[*]}")); unset IFS

# Write JSON
{
  echo '{'
  echo '  "generated": "'"$(date -u +%Y-%m-%dT%H:%M:%SZ 2>/dev/null || date +%Y-%m-%dT%H:%M:%SZ)"'",'
  echo '  "files": ['
  last=${#sorted[@]}
  for i in "${!sorted[@]}"; do
    comma=","
    if [ $((i+1)) -eq "$last" ]; then comma=""; fi
    echo "    \"${sorted[$i]}\"$comma"
  done
  echo '  ]'
  echo '}'
} > chat-manifest.json

echo "Generated chat-manifest.json with ${#sorted[@]} files"
