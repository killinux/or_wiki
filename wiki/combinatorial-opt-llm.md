---
title: LLM 与组合优化(TSP·装箱·路由)
type: note
tags: [combinatorial-optimization, tsp, bin-packing, routing]
updated: 2026-05-30
sources: [sources/funsearch-2024.md, sources/eoh-2024.md, sources/reevo-2024.md, sources/opro-2024.md]
---

# LLM 与组合优化(TSP·装箱·路由)

> 用 LLM 来求解或设计求解经典组合优化问题(TSP、bin packing、VRP/routing 等)的方法:既可让 LLM 直接搜索解,也可让它演化出可执行的「启发式程序」,再由确定性 evaluator 打分迭代。

## 核心要点

- 经典组合问题(TSP、online bin packing、routing)是 LLM 优化/启发式能力的「试金石」:目标可执行、可客观打分,适合作为闭环搜索的评测信号。OPRO 即先用小规模 TSP 与线性回归做 warm-up,验证 LLM 能在历史(解, 分数)轨迹引导下逐步逼近更优解 [[../sources/opro-2024]]。
- FunSearch 在 online bin packing 上自动发现了优于经典 first-fit 与 best-fit 的装箱启发式,在 OR-Library 基准与模拟数据(Weibull 分布等)上均取得更好表现 [[../sources/funsearch-2024]]。
- EoH 在常用组合优化基准上优于手工设计的 best-known 启发式以及近期 AHD 方法(含 FunSearch);在 online bin packing 的 Weibull instances 上,平均使用箱子数显著少于人工最优启发式与 FunSearch,且所需 LLM 查询次数远更少 [[../sources/eoh-2024]]。
- ReEvo 把 LLM 启发式生成框为 Language Hyper-Heuristics(在启发式空间而非解空间搜索),评测覆盖 5 类算法、6 个组合优化问题,并同时考虑白箱(white-box)/黑箱(black-box)两种设置 [[../sources/reevo-2024]]。
- 可解释程序 vs 不透明解:FunSearch 等范式产出的是可运行、可验证、且人类可读的启发式程序,而非黑箱的单一解——可读性使其更易复用与解释,同时由 evaluator 把关缓解了 LLM 幻觉 [[../sources/funsearch-2024]]。
- 与经典求解器的差距与互补:OPRO 路线在小规模/黑箱场景可用,但当搜索空间显著增大时性能退化,LLM 难以稳定逼近最优 [[../sources/opro-2024]];而 FunSearch/EoH/ReEvo 路线不直接出解,而是产出启发式供大规模实例使用,与传统 metaheuristics、neural solvers 形成互补 [[../sources/reevo-2024]]。

## 与其它概念的关系

- 上游/总范式:[[llm-as-optimizer]](把 LLM 当优化器,本词条是其在组合问题上的落点)。
- 平行/方法支柱:[[heuristic-evolution]](FunSearch/EoH/ReEvo 的「演化式启发式设计」机制详见此处)。
- 对比:[[prompt-optimization-evo]](OPRO 把同一「LLM 搜索 + 打分迭代」思路用于提示词优化,目标空间不同)。
- 对比/正交路线:[[nl-to-optimization]](将自然语言问题形式化后交给精确求解器,与本词条「演化启发式」是两条互补技术路线)。
- 下游能力:[[solver-code-generation]](产出可执行启发式代码与「写求解器代码」共享代码生成与评测闭环)。

## 开放问题 / 矛盾

- 在线装箱上谁更强、代价如何?

  > ⚠️ 矛盾:FunSearch 报告其发现的装箱启发式优于经典基线(来源 [[../sources/funsearch-2024]]) vs EoH 报告在 Weibull 在线装箱上用更少箱子、且 LLM 查询次数远少于 FunSearch(来源 [[../sources/eoh-2024]])——即「解质量」与「查询/算力预算」是两个需同时权衡的维度。

- 规模化边界:OPRO 直接搜解在大空间退化 [[../sources/opro-2024]];而演化启发式路线虽能扩展到大实例,但与最优/SOTA 精确求解器的差距、以及在 routing/VRP 等更复杂问题上的稳健性,仍待系统评测 [[../sources/reevo-2024]]。

## 来源

- [[../sources/funsearch-2024]]
- [[../sources/eoh-2024]]
- [[../sources/reevo-2024]]
- [[../sources/opro-2024]]
