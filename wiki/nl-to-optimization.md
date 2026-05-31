---
title: 自然语言到优化建模(NL → 优化)
type: note
tags: [llm, or, modeling]
updated: 2026-05-31
sources: [sources/optimus-2024.md]
---

# 自然语言到优化建模(NL → 优化)

把一段**自然语言描述的优化问题**,自动形式化成可被求解器处理的数学模型(尤其 LP / MILP),
再求解、解释。这是 LLM × 运筹学交叉里最核心的一条路线——目标是降低"会用求解器"的专家门槛。

## 核心要点
- **问题**:形式化(定义决策变量、约束、目标)+ 选求解器 + 写代码,传统上需 OR 专家;门槛高导致大量问题被手工启发式解决而非求最优(据 [[../sources/optimus-2024]])。
- **范式:LLM 智能体闭环**。以 OptiMUS 为代表:建数学模型 → 写并调试 [[solver-code-generation]] 求解器代码 → 评估解 → 据评估**迭代改进**。比"一次性 prompt 直接出答案"稳健得多。
- **可扩展性**:用**模块化**拆解长描述/复杂数据,避免超长 prompt,才能 scale 到真实规模问题。
- **评测**:需要专门基准,如 OptiMUS 提出的 **NLP4LP**(LP/MILP 题集);相对朴素 prompting,智能体式方法多解出约 67% 的题。

## 与其它概念的关系

本页是 LLM×OR 的主线枢纽,按管线阶段链向各子主题:

- **上游子步骤**:[[constraint-extraction]] 约束抽取、[[objective-inference]] 目标推断、[[data-grounding-parameterization]] 数据落参、[[structured-intermediate-representation]] 结构化中间表示。
- **求解与执行**:依赖 [[solver-code-generation]] 生成求解器代码,辅以 [[self-debugging]] 自调试、[[solver-feedback-rl]] 求解器反馈强化学习。
- **智能体编排**:[[llm-or-agents]] 总览、[[multi-agent-or]] 多智能体协作(Chain-of-Experts)、[[retrieval-augmented-or]] RAG 增强。
- **下游解释**:[[what-if-explanation]] what-if 与灵敏度解释、[[human-in-the-loop-or]] 人在回路校验、[[supply-chain-llm]] 供应链应用。
- **更难问题类**:[[nonlinear-optimization-llm]] 非线性/整数、[[combinatorial-opt-llm]] 组合优化。
- **评测**:[[nl4opt-benchmark]]、[[nlp4lp-benchmark]]、[[complexor-benchmark]]、[[mamo-benchmark]]、[[industryor-benchmark]]、[[optibench-benchmark]]、[[optmath-benchmark]]、[[orqa-benchmark]];指标见 [[or-evaluation-metrics]] / [[process-evaluation-or]],风险见 [[failure-modes-hallucination]]。
- **训练与开源**:[[open-source-or-models]] 开源模型、[[or-data-synthesis]] 数据合成、[[instruction-tuning-or]] 指令微调。
- **对比视角**:[[llm-as-optimizer]] / [[heuristic-evolution]] / [[prompt-optimization-evo]]——这类是「LLM 直接当优化器」,与本页「LLM 建模再交求解器」是两条不同路线。
- **综述**:[[or-llm-survey]]。

## 开放问题 / 矛盾
- 形式化的**正确性**如何保证?LLM 可能产出"看似合理但约束错"的模型,需 [[human-in-the-loop-or]] 校验、并以 [[process-evaluation-or]] 过程级评测捕捉"答案对但建模错"的情况(详见 [[failure-modes-hallucination]])。
- **评测口径不统一**:不同基准对"做对了"定义不同(声明级 vs 端到端求解),跨论文数字不可直接比较(见 [[or-evaluation-metrics]])。

## 来源
- [[../sources/optimus-2024]]
