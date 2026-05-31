# PROGRESS — or-wiki
Updated: 2026-05-31

## Current task   (= first unchecked PLAN milestone)
M1–M5 全部完成。当前无进行中的必做项;剩下都是可选增量(见 Next steps)。

## Next steps(均为可选)
1. (可选)接 MkDocs/Obsidian 发布静态站。
2. 继续摄入:completeness 评审点名的 3 个 nice-to-have 缺口可按需补页 —— `modeling-error-taxonomy`、`stochastic-robust-optimization-llm`、`cost-latency-reproducibility-or`。
3. (可选)给 `scripts/lint.sh` 接 pre-commit hook 或 CI,做到每次提交自动自检。

## Done   (recent; git history holds the rest)
- 2026-05-31 — **M5 完成**:实现 `scripts/lint.sh`(替换 M1 占位)——检查 wiki/源 frontmatter、标准小节、`[[wikilink]]` 断链、孤立页(须在 MOC)、「待写」残留;`bash scripts/lint.sh` 全绿(34 词条 + 21 源,退出码 0)。源要点小节兼容「关键内容」(workflow)与「要点摘录」(手写模板)两种措辞。
- 2026-05-31 — **M3+M4 完成(多智能体 workflow 批量摄入)**:跑通「发现→蓝图→源笔记→词条(作者+对抗式核查)→完备性→整合」六阶段(95 个子智能体,~3.95M tokens)。产出 **34 个 `wiki/` 词条 + 21 篇源笔记**,六大分组互链;`maps/_home.md` 重建为完整 MOC。手动 lint 全绿:0 断链、0 孤立页、frontmatter 齐全、34/34 含开放问题+来源小节。
  - 六大分组:建模(NL→数学规划)/ 求解与工具调用 / 解释与人在回路 / 评测与风险 / LLM 作为优化器 / 训练与开源模型。
  - 覆盖论文:OptiMUS(3 版)、NL4Opt、Chain-of-Experts、ORLM、OptiGuide、OPRO、FunSearch、EoH、ReEvo、MAMO、OptMATH、LLMOPT、ReSocratic/OptiBench、ComplexOR、IndustryOR、ORQA 等。
  - 收尾修正:`nl-to-optimization.md` 补 `type: note` frontmatter 并扩为主线枢纽页;清理 `sources/optimus-2024.md`(整合阶段加「LLM 提炼去向」小节)。
- 2026-05-30 — M2 完成:`CONVENTIONS.md` 加「摄入流程」5 步;建 `sources/_TEMPLATE.md`、`wiki/_TEMPLATE.md`。
- 2026-05-30 — M3 起步:首篇摄入 `optimus-2024` → `nl-to-optimization`。
- 2026-05-30 — M1 完成:骨架 + memory-keeper 建档。

## Blockers
- none

## Gotchas / failed approaches  (DO NOT RETRY)
- 对抗核查阶段会弱化无源支撑的精确数字 —— 保留为约数表述;勿在无源时回填精确数字。
- lint 时「entry 内重复 [[../sources/x]]」是**误报**:正文行内引用 + 末尾「## 来源」列表本就会各出现一次,属约定,不是缺陷。
- workflow 蓝图常会超出预设规模(原定 12–16,实际产出 30+);属正常,完备性阶段会再补关键缺口。

## Files touched (本轮)
- wiki/ — 新增 33 个词条(constraint-extraction、objective-inference、solver-code-generation、self-debugging、llm-or-agents、multi-agent-or、retrieval-augmented-or、what-if-explanation、human-in-the-loop-or、supply-chain-llm、nonlinear-optimization-llm、combinatorial-opt-llm、structured-intermediate-representation、data-grounding-parameterization、solver-feedback-rl、or-evaluation-metrics、process-evaluation-or、failure-modes-hallucination、llm-as-optimizer、heuristic-evolution、prompt-optimization-evo、open-source-or-models、or-data-synthesis、instruction-tuning-or、or-llm-survey + 8 个基准页);更新 nl-to-optimization
- sources/ — 新增 20 篇源笔记;清理 optimus-2024
- maps/_home.md — 六分组完整 MOC 重建
- README.md / PLAN.md / PROGRESS.md — 据实更新到 34 词条 / M3+M4 完成
