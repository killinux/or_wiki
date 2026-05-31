# PLAN — or-wiki(运筹学 × LLM 知识库)

## Goal
建一套 **LLM 维护的互链 markdown wiki**,主题是「LLM × 运筹学(Operations Research)」交叉领域,
遵循 Karpathy 的 LLM-wiki 理念:**人只负责喂源、提问、思考;LLM 负责阅读、摘要、建词条、交叉链接、
标注矛盾**,把知识沉淀成一套随每次新增源而**复利增长**的持久知识库(而非查询时临时 RAG)。
"做完一版" = 骨架+约定就绪、有一套核心种子词条且彼此交叉链接、有一个可导航的首页(MOC)。

## Approach / constraints
- **纯 markdown + `[[wikilink]]`**,Obsidian 兼容,全程 git 跟踪。LLM 拥有 `wiki/` 这一生成层。
- **三层目录**:`sources/`(人放入的原始源/笔记) → `wiki/`(LLM 生成维护的概念/实体页) → `maps/`(MOC 导航)。
- **摘要而非堆叠**:每加一篇源,LLM 读它 → 新建/更新相关词条 → 加交叉链接 → 标注与既有内容的矛盾。
- 内容**中文为主**,术语保留英文原名;每页带 frontmatter(title / tags / updated / sources)。
- **非目标(暂)**:不做 Web 应用、不做向量库/在线问答;静态预览(MkDocs)留到后期可选。

## Milestones
- [x] M1: 仓库骨架 — 目录结构 + `CONVENTIONS.md`(命名/wikilink/frontmatter/摄入规则)+ 首页 MOC + README
- [x] M2: 摄入工作流 — 写清"加一篇源 → LLM 阅读 → 建/改词条 + 交叉链接 + 标矛盾"的可重复流程(含模板)
- [x] M3: 种子词条 — 34 个 LLM×OR 核心概念页 + 21 篇源笔记,六大分组互链骨架(2026-05-31,多智能体 workflow 批量摄入)
- [x] M4: 导航与索引 — `maps/_home.md` 按六分组重建、覆盖全部 34 词条且无孤立页/断链;MkDocs 静态站仍为可选(未做)
- [ ] M5: 复利维护 — 健康检查:孤立页、断链、矛盾标注、摘要复审(已手动跑通一次 lint;待固化为 `scripts/` 脚本)

## Key decisions
- 2026-05-30 — 采用 Karpathy LLM-wiki 模式而非查询时 RAG —— 知识要可沉淀、可复利、人可读可改
- 2026-05-30 — 纯 markdown + git,不引入向量库/Web 后端 —— 零依赖、可托管、与本工具链一致
- 2026-05-30 — 内容中文为主、术语留英文 —— 匹配使用者,且便于对接英文文献
- 2026-05-31 — M3 用多智能体 workflow 批量摄入(发现→蓝图→源笔记→词条作者+对抗式核查→完备性→整合)—— 一次性把领域种子词条铺满,每条事实经联网对抗核查;后续单篇摄入仍走 CONVENTIONS 的 5 步流程
- 2026-05-31 — 区分两条主线:「LLM 建模再交求解器」(主线)vs「LLM 直接当优化器」(OPRO/FunSearch/EoH)—— 二者在 OR×LLM 中互补,分属不同 MOC 分组

## Out of scope / deferred
- 在线问答 / 向量检索 — 与 Karpathy 理念相反,且非当前目标
- Web 前端 — 先用 Obsidian/编辑器直接看;静态站(MkDocs)留到 M4 视需要再说

## 候选种子词条(M3 用,非承诺清单)
- NL→优化建模(自然语言到 LP/MILP 形式化)、LLM 作为建模助手、求解器工具调用(tool-use)
- LLM 智能体做 OR 流程编排、约束抽取、目标函数推断、可行性/灵敏度的自然语言解释
- 评测:数据集与基准(如 NL4Opt 类)、常见失败模式与幻觉、人在回路校验
