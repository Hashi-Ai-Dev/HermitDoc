#!/bin/bash
# HermitDoc Audit Script
# Run before every release

set -e

ERRORS=0

echo "🔍 HermitDoc Repository Audit"
echo "=============================="

# Check all SKILL.md files
echo ""
echo "Checking skills..."
for skill in skills/*/SKILL.md; do
  if [ ! -f "$skill" ]; then
    echo "❌ Missing: $skill"
    ERRORS=$((ERRORS+1))
    continue
  fi
  
  content=$(cat "$skill")
  
  # Must start with ---
  if ! [[ "$content" =~ ^--- ]]; then
    echo "❌ $skill: Must start with ---"
    ERRORS=$((ERRORS+1))
  fi
  
  # Must have name
  if ! [[ "$content" =~ name: ]]; then
    echo "❌ $skill: Missing 'name' field"
    ERRORS=$((ERRORS+1))
  fi
  
  # Must have description
  if ! [[ "$content" =~ description: ]]; then
    echo "❌ $skill: Missing 'description' field"
    ERRORS=$((ERRORS+1))
  fi
  
  # Description length ≤ 1024
  desc_line=$(echo "$content" | grep -A1 "^description:" | tail -1)
  desc_len=${#desc_line}
  if [ "$desc_len" -gt 1024 ]; then
    echo "❌ $skill: description > 1024 chars ($desc_len)"
    ERRORS=$((ERRORS+1))
  fi
  
  # File size ≤ 100000
  size=$(wc -c < "$skill")
  if [ "$size" -gt 100000 ]; then
    echo "❌ $skill: file > 100KB ($size bytes)"
    ERRORS=$((ERRORS+1))
  fi
  
  echo "✅ $(basename $(dirname $skill))"
done

# Check for forbidden files
echo ""
echo "Checking for forbidden files..."
forbidden="MEMORY.md HEARTBEAT.md USER.md IDENTITY.md TOOLS.md AGENTS.md"
for f in $forbidden; do
  if [ -f "$f" ]; then
    echo "❌ $f: forbidden root-level file found"
    ERRORS=$((ERRORS+1))
  fi
done

# Check skill count
echo ""
echo "Checking skill count..."
expected=23
actual=$(ls -d skills/*/ 2>/dev/null | wc -l)
if [ "$actual" -ne "$expected" ]; then
  echo "❌ Expected $expected skills, found $actual"
  ERRORS=$((ERRORS+1))
else
  echo "✅ Skill count: $actual (expected $expected)"
fi

# Check required root files
echo ""
echo "Checking required files..."
required_files=(
  "README.md"
  "QUICKSTART.md"
  "AGENT_INSTALL.md"
  "SKILLS_INSTALL.md"
  "CONTRIBUTING.md"
  "CODE_OF_CONDUCT.md"
  "SECURITY.md"
  "LICENSE"
  "HERMITDOC_MANIFEST.json"
)
for f in "${required_files[@]}"; do
  if [ ! -f "$f" ]; then
    echo "❌ Missing required file: $f"
    ERRORS=$((ERRORS+1))
  else
    echo "✅ $f"
  fi
done

# Validate JSON
echo ""
echo "Validating JSON files..."
if command -v python3 &> /dev/null; then
  if python3 -c "import json; json.load(open('HERMITDOC_MANIFEST.json'))" 2>/dev/null; then
    echo "✅ HERMITDOC_MANIFEST.json is valid JSON"
  else
    echo "❌ HERMITDOC_MANIFEST.json is invalid JSON"
    ERRORS=$((ERRORS+1))
  fi
fi

# Summary
echo ""
echo "=============================="
if [ $ERRORS -eq 0 ]; then
  echo "✅ All checks passed!"
  exit 0
else
  echo "❌ $ERRORS error(s) found"
  exit 1
fi