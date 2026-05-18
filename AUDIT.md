# Audit

Automated checks for HermitDoc repository integrity.

---

## Skill Validation

Run before every release:

```bash
#!/bin/bash
# hermitdoc-audit.sh

ERRORS=0

# Check all SKILL.md files
for skill in skills/*/SKILL.md; do
  content=$(cat "$skill")
  
  # Must start with ---
  if ! [[ "$content" =~ ^--- ]]; then
    echo "❌ $skill: Must start with ---"
    ERRORS=$((ERRORS+1))
  fi
  
  # Must have name and description
  if ! [[ "$content" =~ name: ]]; then
    echo "❌ $skill: Missing 'name' field"
    ERRORS=$((ERRORS+1))
  fi
  if ! [[ "$content" =~ description: ]]; then
    echo "❌ $skill: Missing 'description' field"
    ERRORS=$((ERRORS+1))
  fi
  
  # Description length ≤ 1024
  desc_len=$(echo "$content" | grep -A1 "^description:" | tail -1 | wc -c)
  if [ "$desc_len" -gt 1024 ]; then
    echo "❌ $skill: description > 1024 chars"
    ERRORS=$((ERRORS+1))
  fi
  
  # File size ≤ 100000
  size=$(wc -c < "$skill")
  if [ "$size" -gt 100000 ]; then
    echo "❌ $skill: file > 100KB"
    ERRORS=$((ERRORS+1))
  fi
  
  echo "✅ $skill"
done

# Check for forbidden files
forbidden="MEMORY.md HEARTBEAT.md USER.md IDENTITY.md TOOLS.md AGENTS.md"
for f in $forbidden; do
  if [ -f "$f" ]; then
    echo "❌ $f: forbidden root-level file found"
    ERRORS=$((ERRORS+1))
  fi
done

# Check skill count
expected=23
actual=$(ls -d skills/*/ | wc -l)
if [ "$actual" -ne "$expected" ]; then
  echo "❌ Expected $expected skills, found $actual"
  ERRORS=$((ERRORS+1))
fi

if [ $ERRORS -eq 0 ]; then
  echo "✅ All checks passed"
  exit 0
else
  echo "❌ $ERRORS error(s) found"
  exit 1
fi
```

---

## Pre-Release Checklist

- [ ] All skills pass validation
- [ ] README.md skill count matches actual (23 skills)
- [ ] No forbidden files in repo root
- [ ] `git log --oneline` shows meaningful commits
- [ ] Version tagged: `git tag v1.x.x && git push --tags`
- [ ] HermitDoc MANIFEST.json version updated
- [ ] Examples tested locally
- [ ] Smoke test with `hermes skills check`

---

## Manifest Validation

```bash
# Validate HERMITDOC_MANIFEST.json
python3 -c "import json; json.load(open('HERMITDOC_MANIFEST.json')); print('Valid JSON')"
```

Check skill list in manifest matches actual:
```bash
python3 -c "
import json, os
manifest = json.load(open('HERMITDOC_MANIFEST.json'))
expected = set(manifest['skills']['public_list'])
actual = set([d for d in os.listdir('skills') if os.path.isdir(f'skills/{d}')])
if expected != actual:
    print('Mismatch!')
    print('In manifest not in dir:', expected - actual)
    print('In dir not in manifest:', actual - expected)
else:
    print('✅ All skills match')
"
```