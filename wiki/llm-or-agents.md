---
title: LLM OR Agent 流水线总览
type: note
tags: [llm-agents, pipeline, reasoning-llm, autoformulation]
updated: 2026-05-30
sources: [sources/optimus-2024.md, sources/optimus-03-2024.md, sources/chain-of-experts-2024.md, sources/llmopt-2025.md]
---

# LLM OR Agent 流水线总览

> 用一个(或多个)LLM 智能体把自然语言描述的运筹优化(OR)问题端到端地转成可验证的最优解:形式化建模 → 生成求解器代码 → 自动调试 → 验证迭代。

## 核心要点
- 通用 agent 流水线遵循统一闭环:**形式化(定义决策变量/约束/目标)→ 编程(生成求解器代码)→ 调试 → 验证**,把一段 NL 问题端到端转为可验证的最优解 [[../sources/optimus-2024]]。
- **模块化处理长描述**:OptiMUS 用 connection graph 把每条约束/目标当作一个节点单独建模与编码,从而避免把整段超长问题描述塞进单个 prompt,提升对复杂长问题的可扩展性 [[../sources/optimus-03-2024]]。
- 可扩展版 OptiMUS(OptiMUS-0.3)报告超过当时 SOTA:在 easy 数据集上超出 **22% 以上**、在 hard 数据集上超出 **24% 以上**(原文 "more than 22% ... more than 24%")[[../sources/optimus-03-2024]]。
- **多智能体分工**是该范式的另一条主线:Chain-of-Experts 把建模过程拆给多个"专家"角色协作(如术语解释、参数提取、建模、编程、评审),由一个指挥者协调多步推理 [[../sources/chain-of-experts-2024]]。
- **统一形式化 + 微调/对齐的转向**:LLMOPT 等 2025 年(ICLR 2025)工作强调通过通用的五元组(five-element)统一形式化表示 + 多指令微调与模型对齐 + 自纠错,来提升建模正确性与求解准确率;论文报告在 6 个真实数据集上相比 SOTA 平均求解准确率提升约 **11%**(原文 11.08%)[[../sources/llmopt-2025]]。

## 与其它概念的关系
- 上游核心任务:[[nl-to-optimization]](本词条是其智能体化的工程实现框架)。
- 下游子步骤:[[constraint-extraction]]、[[objective-inference]]、[[solver-code-generation]]、[[self-debugging]](流水线的"形式化/编程/调试"各阶段)。
- 对比 / 演进分支:[[multi-agent-or]](单 LLM vs 多智能体的协作范式);[[llm-as-optimizer]](LLM 直接当优化器,与"LLM 生成求解器代码"的路线相对)。
- 增强手段:[[retrieval-augmented-or]](检索增强为建模/编码提供范例与领域知识)。
- 评测:[[nl4opt-benchmark]]、[[complexor-benchmark]]、[[mamo-benchmark]] 等用于衡量端到端流水线的求解正确率。

## 开放问题 / 矛盾
- **正确性验证**仍是核心难题:即便代码可运行、有解,形式化是否忠实于原问题(约束遗漏、目标错配)难以自动保证,常需 [[human-in-the-loop-or]] 或 [[process-evaluation-or]] 介入。
- **单 LLM vs 多智能体 vs 统一形式化+微调的取舍**:多智能体协作(如 Chain-of-Experts)提升复杂问题表现,但带来 token/延迟成本;2025 年 LLMOPT 等路线则用统一五元组形式化 + 微调/对齐来强化单体建模与求解能力,各路线优劣尚无定论 [[../sources/llmopt-2025]]。
- 数字主张的可比性:不同工作所报"超 SOTA xx%"基于各自数据集与基线设定,跨论文直接比较需谨慎,详见 [[failure-modes-hallucination]] 与基准词条的口径差异。

## 来源
- [[../sources/optimus-2024]]
- [[../sources/optimus-03-2024]]
- [[../sources/chain-of-experts-2024]]
- [[../sources/llmopt-2025]]
