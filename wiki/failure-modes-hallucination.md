---
title: 失败模式与幻觉约束
type: note
tags: [failure-modes, hallucination, faithfulness, missing-constraints]
updated: 2026-05-30
sources: [sources/peering-black-box-2025.md, sources/orqa-2024.md, sources/llmopt-2025.md, sources/opt-modeling-meets-llms-survey-2025.md]
---

# 失败模式与幻觉约束

> LLM 把自然语言问题形式化为优化模型时反复出现的错误类型(漏约束、错约束、目标方向错、不可行形式化),以及如何诊断、度量与缓解这些错误。

## 核心要点

- 典型失败模式:漏约束(missing constraints)、错约束(系数错误)、目标方向错(max vs. min)、不可行形式化(infeasible model)。其中漏约束与错约束(幻觉约束)在组件级评测中被直接量化,且对求解正确性影响最大(据 [[../sources/peering-black-box-2025]]:漏约束由 constraint recall 暴露、错约束/幻觉约束由 precision 暴露)。综述则从基准质量审计角度指出形式化层面的常见问题(缺失数据、歧义/不完整形式化、错误 ground truth 标注)(据 [[../sources/opt-modeling-meets-llms-survey-2025]])。
- 求解正确性主要取决于**高约束 recall** 与**低约束 RMSE**——即要把所有约束都抽到、且数值系数正确;漏掉或系数算错的约束是失败的主导来源(据 [[../sources/peering-black-box-2025]])。
- 组件级诊断:不要只看端到端 / solver-level 正确率,而是把优化模型拆成 decision variables、constraints、objective function 三个组件分别度量(变量与约束用 precision/recall,目标函数用 normalized RMSE),因为聚合的 outcome-level 指标会掩盖模型究竟在哪个组件失败(据 [[../sources/peering-black-box-2025]];该源由此提炼三条实践原则:完整约束覆盖、最小化约束 RMSE、简洁输出)。综述亦把基准与评测作为独立一块系统梳理(据 [[../sources/opt-modeling-meets-llms-survey-2025]])。
- 反直觉结果:在 ORQA 中 chain-of-thought(CoT)提示并不可靠地有帮助,某些设定下反而**降低**表现,并会诱发幻觉的推理步骤(hallucinated reasoning steps)——说明在 OR 上堆叠提示技巧不是稳赢(据 [[../sources/orqa-2024]])。
- 缓解手段:LLMOPT 用 **model alignment** 加 **self-correction**(自纠错)循环,以抑制求解过程中的幻觉(hallucination);并以通用的 **five-element formulation**(sets / parameters / variables / objective / constraints)作为中间表示统一刻画多类优化问题、标准化问题定义(据 [[../sources/llmopt-2025]])。综述则把多智能体 / 推理框架与数据合成、微调一并梳理为该方向的推进路线(据 [[../sources/opt-modeling-meets-llms-survey-2025]])。

## 与其它概念的关系

- 上游(产生这些失败的子步骤):[[constraint-extraction]]、[[objective-inference]]——约束 recall/RMSE 与目标方向正是在这两步出错。
- 上游(发生的总流程):[[nl-to-optimization]]——失败模式描述的是该形式化管线的故障。
- 缓解(下游对策):[[self-debugging]] 的自纠错循环、[[solver-code-generation]] 的可执行性反馈,可拦截不可行形式化。
- 评测(配套度量):[[process-evaluation-or]] 的组件级/过程级指标、[[orqa-benchmark]] 的推理探针,用于定位这些失败。
- 对比:[[orqa-benchmark]] 给出"CoT 反而变差"的反例,与默认"CoT 提升推理"的直觉相对立。

## 开放问题 / 矛盾

- 为什么 CoT 在通用推理上常有帮助,却在 OR 上失效甚至加剧幻觉?这一反直觉现象的边界条件尚不清楚(据 [[../sources/orqa-2024]])。

> ⚠️ 矛盾:评测口径之争——聚合的 outcome-level / solver-level 准确率会掩盖模型在具体组件上的失败,应改用组件级度量(来源:[[../sources/peering-black-box-2025]]);综述则从另一面指出现有基准本身存在意外偏高的错误率(缺失数据、歧义形式化、错误标注),并发布清洗数据与公平排行榜(来源:[[../sources/opt-modeling-meets-llms-survey-2025]])。而方法类工作仍多以端到端 / 整体求解准确率为主报告提升(来源:[[../sources/llmopt-2025]] 报告相比 SOTA 平均求解准确率提升约 11%)。

- model alignment + self-correction 能在多大程度上消除不可行形式化,而不只是把错误后移到求解阶段?目前仍是开放问题(据 [[../sources/llmopt-2025]])。

## 来源

- [[../sources/peering-black-box-2025]]
- [[../sources/orqa-2024]]
- [[../sources/llmopt-2025]]
- [[../sources/opt-modeling-meets-llms-survey-2025]]
