---
title: OptMATH 基准与双向合成
type: note
tags: [benchmark, optmath, bidirectional-synthesis, rejection-sampling]
updated: 2026-05-30
sources: [sources/optmath-2025.md]
---

# OptMATH 基准与双向合成

> OptMATH 是一套面向优化建模的可扩展双向数据合成框架,既产出大规模训练集 OptMATH-Train,也给出高难度、长上下文的 held-out 基准 OptMATH-Bench。

## 核心要点

- **双向合成(bidirectional synthesis)**:从数学形式化(种子)正向生成实例数据(forward generation),再回译(back-translation)为自然语言描述,最后用「正向重新建模 + 拒绝采样(rejection sampling)」验证 NL 与形式化是否对应一致,以此保证合成数据质量 [[../sources/optmath-2025]]。
- **OptMATH-Train**:含 20 万+ 高质量问题,由 53 个种子生成器(seed generators)驱动,覆盖 10+ 个应用领域 [[../sources/optmath-2025]]。
- **OptMATH-Bench**:由被拒样本筛选而成的高难度评测集,含 166 道题,题目自然语言长度显著长于 NL4OPT 与 MAMO(论文原文为「约为 MAMO EasyLP 的 2.9 倍」),覆盖 LP / MILP / IP / NLP / SOCP 多种问题类型 [[../sources/optmath-2025]]。
- **模型效果**:训练 0.5B–32B 多档模型;论文 Table 1(pass@1)中最佳的 OptMATH-Qwen2.5-32B 在 NL4OPT 95.9%、MAMO ComplexLP 54.1%、IndustryOR 31.0%、OptMATH-Bench 34.7%,在这几项上达到表内最优,超过 GPT-3.5-Turbo / GPT-4 / DeepSeek-V3 等参数量大得多的专有模型 [[../sources/optmath-2025]]。
- **开源与发表**:代码与数据见 github.com/optsuite/OptMATH;发表于 ICML 2025(poster),arXiv:2502.11102 [[../sources/optmath-2025]]。

## 与其它概念的关系

- 上游(方法论):本词条所述合成管线是 [[or-data-synthesis]] 的一个具体实例化;其训练成果用于训练 [[open-source-or-models]]。
- 任务背景:所评测的能力即 [[nl-to-optimization]](自然语言 → 优化建模),OptMATH-Bench 是该任务的下游评测集。
- 对比(同类基准):与 [[mamo-benchmark]]、[[nl4opt-benchmark]]、[[industryor-benchmark]]、[[complexor-benchmark]] 同属优化建模评测;相对而言 OptMATH-Bench 自然语言上下文更长、难度更高,并被同时用作上述若干基准的横向对照。
- 相关评测:亦可与 [[optibench-benchmark]] 并列参考。

## 开放问题 / 矛盾

- 拒绝采样验证的是「NL ↔ 形式化」的一致性,但「回译后的 NL 是否真实、自然、贴近工业语境」难以自动度量,合成数据可能存在分布偏移。
- OptMATH-Bench 上 SOTA 仅 34.7%,显示高难度长上下文优化建模仍远未解决;NL4OPT 高达 95.9% 与该 34.7% 的巨大落差,提示较老基准可能已饱和、区分度不足。

## 来源

- [[../sources/optmath-2025]]
