# or-wiki

> LLM 维护的「LLM × 运筹学(Operations Research)」互链知识库。

遵循 Andrej Karpathy 的 **LLM-wiki** 理念:**"Obsidian 是 IDE,LLM 是程序员,wiki 是代码库。"**
你只负责**喂源、提问、思考**;LLM 负责**阅读、摘要、建词条、交叉链接、标注矛盾**,把知识增量沉淀成
一套随每次新增源而**复利增长**的持久 markdown 知识库——而不是查询时临时 RAG。

## 结构
```
or_wiki/
├── sources/   # 人放入的原始源/笔记(LLM 读,不改写其事实)
├── wiki/      # LLM 生成维护的概念/实体/对比页(知识沉淀层)
├── maps/      # MOC 导航:_home.md 是首页
├── CONVENTIONS.md  # 命名 / wikilink / frontmatter / 摄入规则
├── PLAN.md    # 目标 + 里程碑(memory-keeper)
└── PROGRESS.md# 当前进度(memory-keeper)
```

## 用法
1. 把一篇源(论文摘录、链接、笔记)放进 `sources/`,或直接提一个问题。
2. 让 Claude 按 `CONVENTIONS.md` 的**摄入规则**把它消化进 `wiki/`:新建/更新词条、补交叉链接、标矛盾。
3. 知识在 `wiki/` 里逐页复利增长;`maps/_home.md` 给你导航。

跨会话续接用 memory-keeper:`/catchup` 看进度,`/checkpoint` 存档。
