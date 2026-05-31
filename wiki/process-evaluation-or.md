---
title: 过程导向评测与基准质量审计
type: note
tags: [process-evaluation, benchmark-quality, leaderboard, execution-accuracy]
updated: 2026-05-30
sources: [sources/mamo-2024.md, sources/opt-modeling-meets-llms-survey-2025.md, sources/peering-black-box-2025.md]
---

# 过程导向评测与基准质量审计

> 不再只比对「最终答案」,而是用求解器执行、组件级核对建模过程本身,并审计基准数据质量、重建公平排行榜,以衡量 NL → 优化 系统的真实可靠性。

## 核心要点

- 从答案匹配转向过程/执行验证:MAMO 把评测焦点从 outcome-oriented 转为 **process-oriented**——要求 LLM 把优化问题表达为 **.lp 格式**,再交 **COPT** 求解器求最优值并与标准答案比对(求解器可替换);其核心论点是评测「建模过程」而非仅最终答案,因为正确答案不保证正确建模 [[../sources/mamo-2024]]。
- MAMO 规模与难度分层:共 **1209 题**,覆盖 ODE 与优化(LP/MILP);优化部分分 **Easy LP(652)** 与 **Complex LP(211)**。实验显示先进 LLM 在简单题尚可、复杂题显著下降——GPT-4o 在 Easy LP 达 **87.42%**,但 Complex LP 仅约 **29–34%**,印证简单与复杂建模的能力鸿沟 [[../sources/mamo-2024]]。
- 基准错误率审计与数据清洗:全栈综述《A Survey of Optimization Modeling Meets LLMs》(IJCAI 2025,arXiv:2508.10047)系统检查既有 benchmark,发现**意外偏高(surprisingly high)的错误率**——错误源包括 missing data、ambiguous formalization、错误 ground truth;原文称「除 MAMO 的 EasyLP 外,其余基准错误率均超过 15%,IndustryOR 甚至高达 54%」,并据此**人工筛除错误样本、发布清洗后的数据集**与配套在线门户(llm4or.github.io)[[../sources/opt-modeling-meets-llms-survey-2025]]。
- 公平比较需控制底座与数据集:同一综述基于清洗数据**重建 leaderboard**,在同时控制 base LLM 与数据集的条件下做公平比较,避免脏数据与不一致评测口径污染排名 [[../sources/opt-modeling-meets-llms-survey-2025]]。
- 组件级评测维度:Peering into the Black Box 把公式拆成 **decision variables / constraints / objective** 逐项打分——变量与约束用 **precision / recall**,目标函数与约束用 **(归一化)RMSE**,以及 token / 延迟等效率指标;指出只看 solver accuracy / execution success 这类聚合指标会掩盖结构与数值错误 [[../sources/peering-black-box-2025]]。
- 结构正确性驱动可靠性:上述组件级分析发现,solver 正确性最强地依赖于**高 constraint recall 与低 constraint RMSE**——即约束的结构完整性与准确性是可靠性的首要驱动因素;由此提出完整约束覆盖、最小化约束 RMSE、简洁输出三条实践原则 [[../sources/peering-black-box-2025]]。

## 与其它概念的关系

- 评测对象(上游):本词条评测的是 [[nl-to-optimization]] 全流程,以及其子步骤 [[constraint-extraction]]、[[objective-inference]]、[[solver-code-generation]] 的输出质量。
- 被评测/审计的基准(对比、具体实例):[[mamo-benchmark]](过程/执行验证范式代表)、[[nl4opt-benchmark]]、[[nlp4lp-benchmark]]、[[complexor-benchmark]]、[[industryor-benchmark]]、[[optibench-benchmark]]、[[optmath-benchmark]]、[[orqa-benchmark]] 都是质量审计与排行榜化的对象。
- 下游/互补:组件级错误归因直接服务于 [[self-debugging]] 与 [[failure-modes-hallucination]] 的诊断;高质量评测信号也指导 [[instruction-tuning-or]]、[[or-data-synthesis]] 与 [[open-source-or-models]] 的训练与选型。
- 全景:整体脉络见综述 [[or-llm-survey]]。
- 风险闭环:当组件级 recall 暴露漏约束时,常需 [[human-in-the-loop-or]] 介入校验。

## 开放问题 / 矛盾

- 「执行通过 + 最优值正确」是否等价于「建模正确」?组件级证据表明二者并不等价——聚合指标会掩盖约束/结构错误 [[../sources/peering-black-box-2025]],因此以单一聚合指标作排行榜主指标存在系统性偏差。
- 基准审计本身的可信度:综述报告的错误率(多数基准 >15%、IndustryOR ~54%)依赖其判定口径,清洗数据与新 leaderboard 仍需社区交叉复核 [[../sources/opt-modeling-meets-llms-survey-2025]]。

> ⚠️ 矛盾:以「solver 执行 + 最优值匹配」作为正确性判据([[../sources/mamo-2024]]) vs.「执行/最优值正确不足以证明建模正确,需组件级核对约束与结构」([[../sources/peering-black-box-2025]])——前者更易自动化、后者更细粒度且能定位错误来源。

## 来源

- [[../sources/mamo-2024]]
- [[../sources/opt-modeling-meets-llms-survey-2025]]
- [[../sources/peering-black-box-2025]]
