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

## 摄入流程(可重复执行的步骤)
> 一句话:**源进 `sources/`,知识进 `wiki/`,导航进 `maps/`。**

**输入**:`sources/` 里一篇新源笔记(用 `sources/_TEMPLATE.md` 建),或用户的一个问题。

**步骤**:
1. **读 + 定位**:读这篇源;判断它涉及哪些概念,各自该落到哪个 `wiki/` 页(已有则更新,没有则新建,用 `wiki/_TEMPLATE.md`)。
2. **提炼**:把源里的**主张/方法/结论**写成词条正文(中文为主、术语留英文),**不抄原文**;每条主张能溯源回 `sources/` 那篇。
3. **交叉链接**:正文里凡提到别的概念就加 `[[...]]`;反向去被提到的页补一条链接回来。链向尚不存在的页 = 标记"待写"。
4. **标矛盾**:若与既有词条冲突,在两边各加 `> ⚠️ 矛盾:…(来源 A)… vs …(来源 B)…`,不直接删旧说法。
5. **登记 + 刷新**:被改/新建页的 frontmatter 写上 `sources:` 与 `updated:`;到 `maps/_home.md` 把"待写"项换成真链接。

**产出**:1 篇源笔记 + N 个新建/更新的 `wiki/` 词条 + `maps/` 导航更新。每次摄入是一个小 commit。

**不变式**:`wiki/` 每条主张都能在某篇 `sources/` 里找到出处;孤立(无任何入链)的词条要么补链接、要么并入别页。

## 自检(每次摄入后)
跑 `bash scripts/lint.sh`(退出码 0 = 全绿)。它机械检查:
- wiki 词条 frontmatter 五字段(title/type/tags/updated/sources)+ 四小节(核心要点 / 与其它概念的关系 / 开放问题 / 来源);
- 源笔记 frontmatter(title/type/url/added)+ 要点小节(「关键内容」或「要点摘录」皆可);
- 所有 `[[wikilink]]` 可解析、无断链;
- 无孤立页(每个 wiki slug 都出现在 `maps/_home.md`);
- 无残留「待写」占位。

语义类检查(矛盾标注是否到位、摘要是否需复审)脚本不管,仍靠人工。
