---
title: 求解结果评测指标体系(Execution Rate / Solving Accuracy / Optimality Gap / pass@k)
type: note
tags: [llm, or]
updated: 2026-05-30
sources: [sources/nl4opt-2022.md, sources/nlp4lp-2024.md, sources/mamo-2024.md, sources/resocratic-optibench-2025.md, sources/orlm-2024.md, sources/optmath-2025.md]
---

# 求解结果评测指标体系(Execution Rate / Solving Accuracy / Optimality Gap / pass@k)

> OR×LLM 任务怎样判定"做对了":从声明级映射准确率,到 execution rate / solving accuracy / optimality gap 的端到端指标,再到 pass@k 采样口径与求解器校验,构成一套需统一口径才能跨基准比较的评测体系。

## 核心要点

- **声明级指标**:NL4Opt Sub-task 2 用 **declaration-level mapping accuracy** 衡量——把模型输出的每条声明(目标、约束)与 gold 逐条匹配、按未匹配声明计错(即统计 false positive / false negative),NER 子任务则用 micro-averaged F1;NER 误差会向下游声明生成传播(据 [[../sources/nl4opt-2022]])。
- **端到端双指标**:NL→OR 端到端工作普遍同时报告 **execution rate**(生成代码能否被求解器无错运行)与 **solving / solution accuracy**(求得的最优目标值是否在数值容差内与 gold 一致),而不只看代码是否生成出来(据 [[../sources/nlp4lp-2024]];OptMATH 则主要以 solving accuracy 报告各基准结果,据 [[../sources/optmath-2025]])。
- **求解器校验优于字符串比对**:用求解器实际求解模型、比对最优目标值,比字符串/公式比对更能反映真实正确性,是 MAMO 的 **solver-based evaluation** 核心做法;OptiBench 亦通过求解器得到最优目标值并按数值容差比对(据 [[../sources/mamo-2024]];据 [[../sources/resocratic-optibench-2025]])。
- **采样指标 pass@1 / pass@k**:报告时常用 **pass@1**(单次采样正确率)等指标;pass@k 反映 k 次采样中至少一次正确的概率,可叠加 self-consistency 多数投票来稳健化输出(pass@1 用法据 [[../sources/resocratic-optibench-2025]])。
- **过程正确性 vs 答案正确性**:MAMO 强调即使最终答案恰好正确,中间建模错误也应被识别,并明确指出"答案对但模型错"是常见且危险的失败模式——这是"答案巧合正确而模型错误"这一系统性偏差的直接证据(据 [[../sources/mamo-2024]])。
- **可验证标签是前提**:OptMATH 通过双向(问题↔模型)合成保证每个样本都能被求解器求解校验,确保标签正确,这是 solving accuracy 这类指标有意义的基础(据 [[../sources/optmath-2025]]);ORLM 在 NL4Opt、MAMO、IndustryOR 等多基准上以 solving accuracy 报告结果(据 [[../sources/orlm-2024]])。

## 与其它概念的关系

- 评测对象(上游):[[nl-to-optimization]]、[[solver-code-generation]] 的输出由本指标体系判定;[[constraint-extraction]]、[[objective-inference]] 对应声明级准确率这一更细粒度口径。
- 对应基准(并列):[[nl4opt-benchmark]](声明级)、[[nlp4lp-benchmark]](execution rate + solving accuracy)、[[mamo-benchmark]] 与 [[optibench-benchmark]](求解器校验)、[[optmath-benchmark]](可验证合成 + 端到端指标)。
- 对比/延伸:[[process-evaluation-or]] 关注过程而非仅答案,是对"答案匹配"口径的补充与对照;[[failure-modes-hallucination]] 描述本指标试图捕获的错误来源(如可行但非最优、答案巧合正确而模型错误)。
- 下游应用:指标差异直接影响 [[open-source-or-models]]、[[or-data-synthesis]] 的优劣排序与训练信号设计。

## 开放问题 / 矛盾

- **数值容差与多最优解**:solving accuracy 依赖"最优目标值在容差内匹配",但容差阈值各论文不一;且多最优解情形下,目标值匹配无法区分解的差异,容易掩盖建模缺陷。
- **可行但非最优 / 答案巧合正确**:仅比对目标值的端到端指标可能给"可行但非最优"或"答案碰巧对而建模错误"打高分;MAMO 主张用 solver-based evaluation 与过程评测来识别(据 [[../sources/mamo-2024]]),但纯目标值匹配口径仍广泛使用。
- **跨基准数字不可直接比较**:NL4Opt 报声明级 accuracy / F1(据 [[../sources/nl4opt-2022]]),NLP4LP 报 execution rate + solving accuracy(据 [[../sources/nlp4lp-2024]]),OptiBench 常报 pass@1(据 [[../sources/resocratic-optibench-2025]]);指标定义、容差、采样次数、求解器各异,跨论文百分数不应直接对齐,需统一口径方可比较。

## 来源

- [[../sources/nl4opt-2022]]
- [[../sources/nlp4lp-2024]]
- [[../sources/mamo-2024]]
- [[../sources/resocratic-optibench-2025]]
- [[../sources/orlm-2024]]
- [[../sources/optmath-2025]]
