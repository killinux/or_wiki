---
title: LLM 驱动的启发式演化(FunSearch·EoH·ReEvo·AEL)
type: note
tags: [heuristic-evolution, funsearch, eoh, reevo, ahd]
updated: 2026-05-30
sources: [sources/funsearch-2024.md, sources/eoh-2024.md, sources/reevo-2024.md, sources/ael-2023.md, sources/ec-era-llm-survey-2024.md]
---

# LLM 驱动的启发式演化(FunSearch·EoH·ReEvo·AEL)

> 把 LLM 当作"变异/交叉算子"放进演化循环里,搜索的不是某个具体解、而是生成解的程序或启发式(heuristic)本身;每个候选由可执行评估器自动打分,迭代演化出更优的算法。

## 核心要点

- 范式转变:搜索对象从"解空间"转为"程序/启发式空间"——演化的是一段可执行代码(或一个 priority/构造函数),而非单一的可行解。这类工作统称自动启发式设计(automatic heuristic design, AHD),并被综述归为"LLM 进入进化计算时代"的代表方向(据 [[../sources/ec-era-llm-survey-2024]])。
- FunSearch = LLM 生成 + 自动评估器组成的演化闭环:LLM 只负责提出对一个函数的改写,可验证的评估器(evaluator)对其打分,从而在保证"发现可被验证"的前提下规避幻觉,把改进固化进 programs database(据 [[../sources/funsearch-2024]])。
- 可验证发现的实证:FunSearch 在 cap set 问题上发现了新的构造,带来约 20 年来 cap set 规模的最大增长(largest increase in the size of cap sets in the past 20 years),这是一个数学层面、可独立验证的新结果(据 [[../sources/funsearch-2024]])。
- 在组合优化上,FunSearch 在 online bin packing 问题上演化出优于经典 first-fit / best-fit 的启发式构造规则(据 [[../sources/funsearch-2024]])。
- EoH 把启发式表示为 thought + code 的协同进化:LLM 先产出自然语言"思路"(thought),再据此生成对应代码(code),二者一同被演化;在 online bin packing 等任务上,EoH 以更少的 LLM 查询/计算量达到甚至超过 FunSearch 的效果(据 [[../sources/eoh-2024]])。
- ReEvo 引入"verbal gradients"(语言化梯度):用 LLM 对比较优/较劣的候选给出自然语言形式的"改进方向反思",作为反射式(reflective)信号驱动进化搜索(据 [[../sources/reevo-2024]])。
- AEL(Algorithm Evolution using LLM)是上述思路的前身:它在"算法级"用 LLM 充当进化算子来演化算法本体,为后续 thought+code、verbal-gradient 等更精细的表示打下基础(据 [[../sources/ael-2023]])。

## 与其它概念的关系

- 上游 / 母题:[[llm-as-optimizer]](把 LLM 当优化器的总范式;启发式演化是其"演化程序"的分支)。
- 对比 / 姊妹:[[combinatorial-opt-llm]](同样面向 NP-hard 组合问题,但侧重直接求解/构造解,而非演化出启发式程序)。
- 对比 / 方法相邻:[[prompt-optimization-evo]](也用演化思路,但被演化的对象是 prompt 文本而非可执行启发式代码)。
- 工程下游:演化出的候选需可执行评估,涉及 [[solver-code-generation]] 与 [[self-debugging]](生成的程序要能跑通、能被自动修复)。
- 综述定位:[[or-llm-survey]] 与 EC×LLM 综述把 AHD 列为 LLM 辅助 OR/优化的关键方向。

## 开放问题 / 矛盾

- 评估器依赖:FunSearch 类方法的"可验证"优势高度依赖一个廉价且正确的自动评估器;当目标缺乏快速可验证的评估(如真实业务约束、需 [[human-in-the-loop-or]] 判定的目标)时,该范式的保证会减弱。
- 查询效率之争:
  > ⚠️ 矛盾:EoH 报告其 thought+code 协同进化在 online bin packing 上"以更少 LLM 查询"超过 FunSearch(来源:[[../sources/eoh-2024]]) vs FunSearch 强调以大规模采样/演化换取可验证的渐近改进(来源:[[../sources/funsearch-2024]])——二者在"查询预算 vs 发现强度"上的取舍尚无统一结论。
- 泛化与可迁移:演化得到的启发式往往针对特定分布/规模调优,跨分布、跨规模的鲁棒性以及对结果的可解释性仍是开放问题。

## 来源

- [[../sources/funsearch-2024]]
- [[../sources/eoh-2024]]
- [[../sources/reevo-2024]]
- [[../sources/ael-2023]]
- [[../sources/ec-era-llm-survey-2024]]
