#!/usr/bin/env bash
# or-wiki 健康检查(M5 复利维护)
#
# 检查项:
#   1. wiki/ 每页 frontmatter 含 title/type/tags/updated/sources,且 sources 指向的文件存在
#   2. wiki/ 每页含标准小节:核心要点 / 与其它概念的关系 / 开放问题 / 来源
#   3. sources/ 每页 frontmatter 含 title/type/url/added,且含 关键内容 + 去向 小节
#   4. 所有 [[wikilink]] 可解析(wiki 词条 / ../sources/x / README / CONVENTIONS / _home)
#   5. 无孤立页:每个 wiki 词条都出现在 maps/_home.md 的 MOC 里
#   6. 无残留「待写」占位标记
#
# 用法:  bash scripts/lint.sh        (在仓库任意位置运行均可)
# 退出码:全绿 0,有问题 1。

set -u

# 定位仓库根(脚本在 scripts/ 下)
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT" || exit 2

errors=0
warns=0
err()  { echo "  ✗ $1"; errors=$((errors+1)); }
warn() { echo "  ⚠ $1"; warns=$((warns+1)); }

is_tmpl() { [ "$(basename "$1")" = "_TEMPLATE.md" ]; }

# 取某文件的 frontmatter 正文(第一个 --- 之后到第二个 --- 之前)
frontmatter() { awk 'NR==1 && $0!="---"{exit} NR==1{next} /^---[[:space:]]*$/{exit} {print}' "$1"; }
has_key() { frontmatter "$1" | grep -q "^$2:"; }
has_sec() { grep -qF "$2" "$1"; }

# 把一个 [[link]] 目标解析成期望的文件路径;不存在则返回非零
resolve_link() {
  local link="$1" base target
  base="$(basename "$link")"
  case "$link" in
    */sources/*|sources/*) target="sources/${base}.md" ;;
    *)
      case "$base" in
        README)      target="README.md" ;;
        CONVENTIONS) target="CONVENTIONS.md" ;;
        _home)       target="maps/_home.md" ;;
        *)           target="wiki/${base}.md" ;;
      esac ;;
  esac
  [ -f "$target" ] && return 0
  echo "$target"; return 1
}

echo "or-wiki lint @ $ROOT"
echo

# ── 1+2. wiki 词条:frontmatter + 小节 ────────────────────────────────
echo "[wiki] frontmatter + 标准小节"
wiki_n=0
for f in wiki/*.md; do
  is_tmpl "$f" && continue
  wiki_n=$((wiki_n+1)); b=$(basename "$f")
  [ "$(head -1 "$f")" = "---" ] || err "$b: 缺 frontmatter(首行不是 ---)"
  for k in title type tags updated sources; do
    has_key "$f" "$k" || err "$b: frontmatter 缺 $k"
  done
  for s in "## 核心要点" "## 与其它概念的关系" "## 开放问题" "## 来源"; do
    has_sec "$f" "$s" || err "$b: 缺小节 $s"
  done
  # sources: frontmatter 列出的源文件须存在
  src_line=$(frontmatter "$f" | grep '^sources:')
  for sid in $(echo "$src_line" | grep -oE 'sources/[a-z0-9._-]+\.md'); do
    [ -f "$sid" ] || err "$b: frontmatter sources 指向不存在的文件 $sid"
  done
done
echo "  → $wiki_n 个词条"

# ── 3. 源笔记:frontmatter + 小节 ────────────────────────────────────
echo "[sources] frontmatter + 小节"
src_n=0
for f in sources/*.md; do
  is_tmpl "$f" && continue
  src_n=$((src_n+1)); b=$(basename "$f")
  [ "$(head -1 "$f")" = "---" ] || err "$b: 缺 frontmatter"
  for k in title type url added; do
    has_key "$f" "$k" || err "$b: frontmatter 缺 $k"
  done
  # 源要点小节:workflow 生成用「关键内容」,手写模板用「要点摘录」,任一即可
  if ! grep -qE '^## (关键内容|要点摘录)' "$f"; then err "$b: 缺「关键内容 / 要点摘录」小节"; fi
  # 去向小节(摘入哪些 wiki 词条):非强制,缺了只告警
  grep -qE '^## .*去向' "$f" || warn "$b: 无「去向(摘入哪些 wiki 词条)」小节"
done
echo "  → $src_n 篇源"

# ── 4. wikilink 可解析 ──────────────────────────────────────────────
echo "[links] wikilink 解析"
dangling=0
for f in wiki/*.md maps/*.md sources/*.md; do
  is_tmpl "$f" && continue
  b=$(basename "$f")
  while IFS= read -r link; do
    [ -z "$link" ] && continue
    if miss=$(resolve_link "$link"); then :; else
      err "$b: 断链 [[$link]] → 期望 $miss"; dangling=$((dangling+1))
    fi
  done < <(grep -oE '\[\[[^]]+\]\]' "$f" | sed -E 's/^\[\[//; s/\]\]$//')
done
[ "$dangling" -eq 0 ] && echo "  → 0 断链"

# ── 5. 孤立页:每个 wiki 词条都在 MOC 里 ─────────────────────────────
echo "[orphans] 词条须出现在 maps/_home.md"
orph=0
for f in wiki/*.md; do
  is_tmpl "$f" && continue
  s=$(basename "$f" .md)
  grep -qF "[[$s]]" maps/_home.md || { err "孤立页(不在 MOC): $s"; orph=$((orph+1)); }
done
[ "$orph" -eq 0 ] && echo "  → 0 孤立页"

# ── 6. 残留「待写」标记 ─────────────────────────────────────────────
echo "[todo] 残留「待写」占位"
todo=$(grep -rl "待写" wiki/ maps/ sources/ 2>/dev/null | grep -v _TEMPLATE)
if [ -n "$todo" ]; then
  while IFS= read -r t; do err "残留「待写」: $t"; done <<< "$todo"
else
  echo "  → 无"
fi

echo
if [ "$errors" -eq 0 ]; then
  echo "✅ 全绿:$wiki_n 词条 + $src_n 源,0 错误${warns:+,（$warns 警告)}"
  exit 0
else
  echo "❌ $errors 个问题${warns:+(另有 $warns 警告)}"
  exit 1
fi
