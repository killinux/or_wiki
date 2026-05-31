---
title: LLM 作为优化器(LLM-as-Optimizer)
type: note
tags: [llm-as-optimizer, opro, black-box, metaheuristics]
updated: 2026-05-30
sources: [sources/opro-2024.md, sources/funsearch-2024.md, sources/eoh-2024.md, sources/reevo-2024.md, sources/ec-era-llm-survey-2024.md]
---

# LLM 作为优化器(LLM-as-Optimizer)

> 把 LLM 当作无梯度 / 黑箱优化器:不算梯度,而是把「历史(解,分数)」喂给模型,让它在 in-context 里迭代提出更优的候选解。

## 核心要点
- 范式:OPRO(Optimization by PROmpting)在每一步给 LLM 一个 **meta-prompt**(问题描述 + 历史候选解及其分数),让它产生新的候选解;新解被评估后写回历史,循环往复,**全程不使用梯度**(据 [[../sources/opro-2024]])。
- meta-prompt 的核心结构是「**问题描述 + 按分数排序的(解,分数)轨迹**」,模型被要求给出比历史更高分的新解(据 [[../sources/opro-2024]])。
- 热身演示:OPRO 先在 **小规模 toy 问题**——线性回归与旅行商问题(TSP)——上验证 LLM 能做迭代式的数值 / 组合改进;其主战场则是 **prompt 优化**(在 GSM8K、Big-Bench Hard 上搜索胜过人工 prompt 的提示)(据 [[../sources/opro-2024]])。
- 退化边界:随着问题规模 / 搜索空间增大,LLM-as-optimizer 会 **退化**;它最适合 **小规模或黑箱(无梯度可用)** 的场景(据 [[../sources/opro-2024]])。
- 与演化计算结合的路线一(搜程序):FunSearch 把 LLM 配上自动 **evaluator** 在演化循环里搜索 **程序 / 函数**(而非直接搜原始解),发现了 cap set 问题的新构造,并改进了 online bin packing 的启发式;前提是要有 **快速可靠的 evaluator**(据 [[../sources/funsearch-2024]])。
- 与演化计算结合的路线二(搜启发式 + 反思):EoH 共同演化「自然语言 thought + 代码」对,在若干组合基准上比 FunSearch 更 **sample-efficient**(据 [[../sources/eoh-2024]]);ReEvo 进一步加入 **reflection** 步骤——把 LLM 的短期/长期「reflections」当作 **verbal gradients(语言形式的『梯度』)** 来引导演化搜索方向,在覆盖多类算法的若干组合优化问题上(同时考虑白箱/黑箱设置)取得比 EoH 更高的样本效率(据 [[../sources/reevo-2024]])。

## 与其它概念的关系
- 下游 / 应用方向:[[heuristic-evolution]](FunSearch → EoH → ReEvo 这条「自动启发式设计」主线,把 LLM-as-optimizer 用于演化代码/启发式);[[combinatorial-opt-llm]](TSP、bin packing、CVRP 等组合优化问题是其主要试验场)。
- 平行 / 对比方向:[[prompt-optimization-evo]](OPRO 的主战果就是用同一个 (解,分数) 循环去搜 prompt——这里「解」即提示文本;在 EC×LLM 综述的双向框架里,这类「用演化/搜索来优化 LLM 的输入与配置」属于 **EA-enhanced LLM** 方向,据 [[../sources/ec-era-llm-survey-2024]])。
- 对比:[[nl-to-optimization]](后者把自然语言 *形式化*为数学模型并调求解器,LLM 作「建模/写码」角色;本词条则把 LLM 直接当作 *求解器/优化器*,二者在 OR×LLM 中是互补而非替代的角色)。

## 开放问题 / 矛盾
- 可扩展性:OPRO 自承在搜索空间增大时退化(据 [[../sources/opro-2024]]);EC×LLM 综述也系统梳理了该方向的挑战与未来研究方向(据 [[../sources/ec-era-llm-survey-2024]])——结合各源可见,目前的成功多集中在小规模或可廉价评估(快速评测器)的设定。
- 对 evaluator 的依赖:FunSearch 强调需要 **快速可靠的 evaluator** 才能廉价地给大量候选程序打分(据 [[../sources/funsearch-2024]]);当评估昂贵或不可靠时,这类方法的实用性存疑。
- 「真改进 vs. 记忆」:FunSearch 在 cap set 上给出了被认为是 **真正新颖** 的数学构造(据 [[../sources/funsearch-2024]]),但 LLM 提出的解多大程度上是搜索/创造而非训练数据记忆,仍是开放争议。

## 来源
- [[../sources/opro-2024]]
- [[../sources/funsearch-2024]]
- [[../sources/eoh-2024]]
- [[../sources/reevo-2024]]
- [[../sources/ec-era-llm-survey-2024]]
