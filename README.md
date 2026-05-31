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

## 主题与范围
聚焦 **LLM × 运筹学(Operations Research)** 交叉领域:用自然语言驱动优化建模与求解。
- **范围内**:NL→优化建模、LLM 作为建模助手、约束抽取、求解器工具调用、LLM 智能体编排 OR 流程、评测基准与失败模式。
- **暂不做**(见 [PLAN.md](PLAN.md)):Web 前端、向量库/在线问答(与 LLM-wiki「知识沉淀」理念相反);静态站(MkDocs)留到后期可选。
- 内容**中文为主**,术语保留英文原名。

## 用法
1. 把一篇源(论文摘录、链接、笔记)放进 `sources/`,或直接提一个问题。
2. 让 Claude 按 `CONVENTIONS.md` 的**摄入规则**把它消化进 `wiki/`:新建/更新词条、补交叉链接、标矛盾。
3. 知识在 `wiki/` 里逐页复利增长;`maps/_home.md` 给你导航。

跨会话续接用 memory-keeper:`/catchup` 看进度,`/checkpoint` 存档。

## 摄入流程(加一篇源时 LLM 执行,详见 [CONVENTIONS.md](CONVENTIONS.md))
1. **放源** → `sources/<slug>-<year>.md`(用 `_TEMPLATE.md`),记出处/链接/日期。
2. **读+摘** → 提取关键概念、方法、结论及与既有词条的关系。
3. **建/改词条** → 在 `wiki/` 新建或更新页(摘要而非堆叠,改写而非追加重复)。
4. **交叉链接** → 补 `[[wikilink]]`,把新页接入相关页与 `maps/_home.md`。
5. **标矛盾** → 与既有内容冲突处用 `> ⚠️ 矛盾:…` 显式标注,注明两源。

> 每次摄入后自检不变式:无孤立页、无悬空「待写」链接、每页有 frontmatter 且 `updated` 为当天、关键结论可回溯到某个 `sources/`。

## 约定速览
- **命名**:文件 kebab-case + 英文,一页一概念;对比页 `x-vs-y.md`;源文件 `<slug>-<year>.md`。
- **链接**:`[[文件名不带扩展名]]`,宁可多链;指向未写页的链接是合法 TODO。
- **Frontmatter**(每页必带):
  ```yaml
  ---
  title: 人类可读标题
  tags: [llm, or, modeling]
  updated: 2026-05-30
  sources: [optimus-2024]
  ---
  ```

## 当前状态
| 里程碑 | 状态 |
|--------|------|
| M1 骨架 + 约定 + 首页 MOC | ✅ |
| M2 摄入工作流 + 模板 | ✅ |
| M3 种子词条(34 词条 + 21 源,六分组互链) | ✅ |
| M4 导航与索引(MOC 已重建;MkDocs 可选) | ✅ |
| M5 复利维护(孤立页/断链/矛盾健康检查) | 🔧 lint 已跑通,待固化为脚本 |

**内容规模**:**34 个词条、21 篇源笔记**,按六大分组组织(导航见 [maps/_home.md](maps/_home.md);lint 全绿:0 断链、0 孤立页):

- **建模(NL→数学规划)** — `nl-to-optimization`(主线枢纽)· `constraint-extraction` · `objective-inference` · `nonlinear-optimization-llm` · `structured-intermediate-representation` · `data-grounding-parameterization`
- **求解与工具调用** — `solver-code-generation` · `self-debugging` · `multi-agent-or` · `llm-or-agents` · `retrieval-augmented-or`
- **解释与人在回路** — `what-if-explanation` · `human-in-the-loop-or` · `supply-chain-llm`
- **评测与风险** — 8 个基准页(`nl4opt` / `nlp4lp` / `complexor` / `mamo` / `industryor` / `optibench` / `optmath` / `orqa`)· `or-evaluation-metrics` · `process-evaluation-or` · `failure-modes-hallucination` · `or-llm-survey`
- **LLM 作为优化器** — `llm-as-optimizer` · `heuristic-evolution` · `combinatorial-opt-llm` · `prompt-optimization-evo`(OPRO / FunSearch / EoH / ReEvo)
- **训练与开源模型** — `open-source-or-models` · `or-data-synthesis` · `instruction-tuning-or` · `solver-feedback-rl`(ORLM / LLMOPT / OptMATH / ReSocratic)

> 两条主线之分:**「LLM 建模再交求解器」**(主线,以 OptiMUS / Chain-of-Experts 为代表)vs **「LLM 直接当优化器」**(OPRO / FunSearch),在本 wiki 中互补而非替代。

详见 [PLAN.md](PLAN.md)(目标/里程碑)与 [PROGRESS.md](PROGRESS.md)(当前进度)。
