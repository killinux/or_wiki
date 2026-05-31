# CONVENTIONS — or-wiki

这套约定让 LLM 与人对同一套 markdown 有一致预期。**`wiki/` 由 LLM 维护**,人主要动 `sources/`。

## 目录
- `sources/` — 人放入的原始材料/笔记(论文摘录、链接、想法)。LLM 读它,不改写它的事实。
- `wiki/` — LLM 生成与维护的**概念页/实体页/对比页**。这是知识的沉淀层。
- `maps/` — MOC(map of content):首页与主题导航,把零散词条串成结构。

## 命名
- 文件名用**短横线小写**:`nl-to-optimization.md`、`solver-tool-use.md`。
- 一个概念一页;对比类单独成页:`rag-vs-llm-wiki.md`。
- 模板文件以 `_` 开头(`_TEMPLATE.md`),首页用 `maps/_home.md`。

## 链接
- 词条之间一律用 **`[[文件名不带扩展名]]`** 互链(Obsidian 风格),例如 `[[solver-tool-use]]`。
- 鼓励**密集互链**:提到的每个已有/应有概念都加链接;指向尚不存在的页也可以,代表"待写"。

## Frontmatter(每个 `wiki/` 页顶部)
```yaml
---
title: 自然语言到优化建模
tags: [llm, or, modeling]
updated: 2026-05-30
sources: [sources/nl4opt-notes.md]   # 这页依据哪些源
---
```

## 摄入规则(核心 —— Karpathy 理念)
**人**:把源丢进 `sources/`,或提一个问题。
**LLM**:读源 → 提炼 → **新建或更新** `wiki/` 词条 → 补**交叉链接** → 若与既有内容冲突,**就地标注矛盾**
(`> ⚠️ 矛盾:X 处说……,而 [[Y]] 说……`),并刷新受影响页的 `updated`。
不堆原文,只沉淀**摘要+结构+链接**;git 是历史档案。
