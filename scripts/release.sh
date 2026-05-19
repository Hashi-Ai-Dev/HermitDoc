#!/bin/bash
# HermitDoc Quick Release Script
# Usage: ./scripts/release.sh [patch|minor|major] [hermes-version]
# Example: ./scripts/release.sh minor 2026.x
# Pre-req: git config user.name "LucielAI" && git config user.email "dejesus.danny12@gmail.com"

set -e

BUMP_TYPE="${1:-patch}"
HERMES_VERSION="${2:-2026.x}"

echo "🚀 HermitDoc Release"
echo "   Bump: $BUMP_TYPE"
echo "   Hermes tracked: $HERMES_VERSION"
echo ""

# ─── Pre-flight checks ───────────────────────────────────────────────────
if [ ! -f "HERMITDOC_MANIFEST.json" ]; then
    echo "❌ Must run from repo root"
    exit 1
fi

# ─── Bump version in manifest ───────────────────────────────────────────
python3 << 'PYEOF'
import json, sys

with open("HERMITDOC_MANIFEST.json") as f:
    m = json.load(f)

old = m["hermitdoc_version"]
# Parse semver
v = old.lstrip("v")
parts = v.split(".")
major, minor, patch = int(parts[0]), int(parts[1]), int(parts[2])

bump = sys.argv[1] if len(sys.argv) > 1 else "patch"
hm_ver = sys.argv[2] if len(sys.argv) > 2 else "2026.x"

if bump == "major":
    major += 1; minor = 0; patch = 0
elif bump == "minor":
    minor += 1; patch = 0
else:
    patch += 1

new = f"v{major}.{minor}.{patch}"
m["hermitdoc_version"] = new
m["tracked_hermes_version"] = hm_ver

with open("HERMITDOC_MANIFEST.json", "w") as f:
    json.dump(m, f, indent=2)

print(f"Manifest updated: {old} → {new}")
print(f"Hermes tracked: {hm_ver}")
PYEOF

BUMP_TYPE="$BUMP_TYPE" HERMES_VERSION="$HERMES_VERSION" python3 -c "
import json
with open('HERMITDOC_MANIFEST.json') as f:
    m = json.load(f)
print(f'Next version: {m[\"hermitdoc_version\"]}')
"

# ─── Update README version badges ───────────────────────────────────────
NEW_VER=$(python3 -c "import json; m=json.load(open('HERMITDOC_MANIFEST.json')); print(m['hermitdoc_version'])")
HERMES_VER=$(python3 -c "import json; m=json.load(open('HERMITDOC_MANIFEST.json')); print(m['tracked_hermes_version'])")

# Update README note line
sed -i "s/> Tracks Hermes Agent .*>/> Tracks Hermes Agent \`$HERMES_VER\` · HermitDoc \`$NEW_VER\` · 23 skills/" README.md
sed -i "s/| \*\*HermitDoc version\*\* | .*|/| **HermitDoc version** | \`$NEW_VER\` |/" README.md
sed -i "s/| \*\*Hermes Agent tracked\*\* | .*|/| **Hermes Agent tracked** | \`$HERMES_VER\` |/" README.md
sed -i "s/| \*\*Last synced\*\* | .*|/| **Last synced** | $(date +%Y-%m-%d) |/" README.md

# Update QUICKSTART header
sed -i "s/> \*\*Version:.*/ > **Version:** \`$NEW_VER\` · **Tracks Hermes:** \`$HERMES_VER\` · **Skills:** 23/" QUICKSTART.md

echo "✅ Version badges updated"

# ─── Run audit ───────────────────────────────────────────────────────────
echo ""
echo "🔍 Running audit..."
if bash scripts/audit.sh; then
    echo "✅ Audit passed"
else
    echo "❌ Audit failed — fix issues before releasing"
    exit 1
fi

# ─── Stage and commit ────────────────────────────────────────────────────
echo ""
echo "📦 Committing..."
git add -A
git commit -m "chore: release v$NEW_VER (Hermes $HERMES_VER)"

# ─── Tag and push ─────────────────────────────────────────────────────────
echo ""
echo "🏷️  Tagging..."
git tag "v$NEW_VER"
git push origin main
git push origin "v$NEW_VER"

echo ""
echo "✅ Release v$NEW_VER pushed!"
echo "   Hermes: $HERMES_VER"
echo "   https://github.com/Hashi-Ai-Dev/HermitDoc/releases/tag/v$NEW_VER"