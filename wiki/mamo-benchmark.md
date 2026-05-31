---
title: MAMO 基准(过程导向 + 求解器验证)
type: note
tags: [benchmark, mamo, process-evaluation, copt, ode]
updated: 2026-05-30
sources: [sources/mamo-2024.md]
---

# MAMO 基准(过程导向 + 求解器验证)

> 一个以「建模过程」而非仅「最终数值答案」来评测 LLM 数学建模能力的基准,覆盖 ODE 与优化两大类问题,并借助求解器自动验证模型是否正确。

## 核心要点

- 评测范式:MAMO 主张数学建模的**过程**(modeling process)才是核心能力,反对只看最终数值答案是否正确;尤其当问题复杂、答案不唯一或需要可执行模型时更需如此(据 [[../sources/mamo-2024]])。
- 数据规模:全集共 **1209** 题;其中优化部分为 **Easy LP 652** 题、**Complex LP 211** 题(优化合计 863),ODE 部分 **346** 题(据 [[../sources/mamo-2024]])。
- 优化验证流程:把模型表达为 **.lp 文件**,交由 **COPT** 求解器求最优值,与参考最优值在数值容差内比对判定正误(据 [[../sources/mamo-2024]])。
- ODE 验证流程:把建模得到的方程用 **Python 代码**(数值求解)执行,再与参考解比对(据 [[../sources/mamo-2024]])。
- 主要结果(节选,GPT-4o 为最强模型,均为带 .lp/语法纠错的「††」设定口径):**Easy LP 约 87.42%**,但 **Complex LP 仅约 29.38%**;ODE 一阶约 **68.37%**、二阶约 **37.27%**。可见难度随 LP 复杂度与 ODE 阶数显著上升(据 [[../sources/mamo-2024]])。
- 影响:被后续 OR×LLM 工作(如 ORLM、LLMOPT、OptMATH)作为标准评测之一复用(据 [[../sources/mamo-2024]])。

## 与其它概念的关系

- 上游方法论:体现并实例化了 [[process-evaluation-or]] 的「评建模过程而非最终答案」思想,MAMO 是其代表性落地基准。
- 对比基准:与 [[nlp4lp-benchmark]]、[[industryor-benchmark]] 同属 OR×LLM 评测集,但 MAMO 的特点是「.lp + COPT 求解器验证」并额外覆盖 ODE;对比 [[nl4opt-benchmark]] 偏抽取式标注、[[complexor-benchmark]] 偏复杂业务建模。
- 评测对象:为 [[nl-to-optimization]] 流水线(含 [[constraint-extraction]]、[[objective-inference]]、[[solver-code-generation]])提供过程级正确性度量。
- 下游复用:被 [[open-source-or-models]](如 ORLM 等)与相关训练/评测工作作为标准 benchmark 引用。

## 开放问题 / 矛盾

- 「过程正确」的可操作定义:MAMO 用求解器比对最优值来近似判定建模正确性,但最优值相同不必然意味着模型表述(变量/约束)在过程上完全正确,仍可能存在偶合正确的情况。
- ODE 二阶任务得分偏低(约 37.27%),提示当前 LLM 在高阶/复杂建模上的能力瓶颈,亦关联 [[failure-modes-hallucination]]。

## 来源

- [[../sources/mamo-2024]]
