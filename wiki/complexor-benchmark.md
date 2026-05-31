---
title: ComplexOR 基准
type: note
tags: [benchmark, complexor, complex-or, execution-accuracy]
updated: 2026-05-30
sources: [sources/complexor-2024.md, sources/chain-of-experts-2024.md]
---

# ComplexOR 基准

> 一个面向复杂运筹学(OR)问题的数据集,由 OR 专家从论文、教材与工业场景中挑选,以最终最优值的正确性来评测 LLM 建模与求解能力。

## 核心要点

- 规模与难度:ComplexOR 含 **37 个复杂 OR 问题**,定位为面向"复杂"OR 问题的评测集(与 NL4Opt/LPWP 这类较初级的 NL→LP 题集相对),每题通常需多步推理来建模 [[../sources/complexor-2024]]。注:原论文未给出"刻意设计为比 NL4Opt 更难"或"规模小于 NL4Opt"的明确量化对比,此类强表述应回到原文核实后再引用。
- 数据来源:问题由 **OR 专家**从学术论文、教材以及工业场景中挑选,覆盖供应链、调度、物流等多个领域 [[../sources/complexor-2024]]。
- 评测口径:以**最终最优值(final optimal value)的正确性**作为评测标准,属于结果(execution / answer)层面的准确率,而非建模过程的逐步评分 [[../sources/complexor-2024]]。
- 配套方法:与 Chain-of-Experts(ICLR 2024)一同提出,后者是由 conductor 协调多个 LLM expert 智能体的 multi-agent 框架,并带 backward reflection 做迭代纠错 [[../sources/chain-of-experts-2024]]。
- 当前天花板:在 ComplexOR 上,Chain-of-Experts 最好也**仅解出 37 题中的 10 题**,直观暴露了现有方法在复杂建模上的上限 [[../sources/chain-of-experts-2024]];使用 GPT-4 时,CoE 相比此前最佳基线提升 **+5.5%** [[../sources/chain-of-experts-2024]]。

## 与其它概念的关系

- 评测对象(上游能力):[[nl-to-optimization]] —— ComplexOR 衡量的正是 NL → 优化建模与求解的端到端能力。
- 配套方法(下游):[[multi-agent-or]] / [[llm-or-agents]] —— Chain-of-Experts 的多智能体框架在此基准上提出与评测。
- 对比基准:[[nl4opt-benchmark]](其 LPWP 题集为约千道初级 LP 题,规模更大、单题更简单;CoE 同时在 LPWP 与 ComplexOR 上报告结果)、[[nlp4lp-benchmark]]、[[mamo-benchmark]]、[[industryor-benchmark]]、[[optibench-benchmark]] 等同属 OR-LLM 评测家族。
- 评测范式对比:[[process-evaluation-or]] —— ComplexOR 用最终最优值的结果正确性评测,与按建模过程逐步评分的范式形成对照。
- 暴露问题(下游分析):[[failure-modes-hallucination]] —— 低通过率反映复杂建模中的失败模式。

## 开放问题 / 矛盾

- 仅以"最终最优值正确"评判,难以区分"建模正确但求解出错"与"建模本身错误";过程级评测([[process-evaluation-or]])可能给出更细粒度的诊断。
- 37 题规模偏小,统计噪声大,+5.5% 这类增量是否稳健、能否推广到更广的工业场景仍待更大样本验证。
- 通过率天花板(最好 10/37)说明当前 LLM 方法在复杂 OR 建模上远未饱和,瓶颈在建模、求解代码还是推理协同尚需拆解。

## 来源

- [[../sources/complexor-2024]]
- [[../sources/chain-of-experts-2024]]
