---
title: OR 数据合成(OR-Instruct·ReSocratic·OptMATH)
type: note
tags: [data-synthesis, or-instruct, resocratic, back-translation]
updated: 2026-05-30
sources: [sources/orlm-2024.md, sources/resocratic-optibench-2025.md, sources/optmath-2025.md, sources/opt-modeling-meets-llms-survey-2025.md]
---

# OR 数据合成(OR-Instruct·ReSocratic·OptMATH)

> 为「自然语言优化建模」训练数据稀缺的问题,用半自动 / 反向 / 双向方式批量合成「问题描述 ↔ 数学模型 ↔ 求解代码」三元组,作为开源 OR 模型的指令微调语料。

## 核心要点

- 动机:真实世界里高质量、可验证的「NL 优化问题 + 形式化模型 + 求解代码」对极少,人工标注昂贵,因此训练开源 OR 模型普遍依赖**合成数据**;[[../sources/opt-modeling-meets-llms-survey-2025]] 把「数据合成 / 微调」列为该方向三大板块之一(另两块为推理框架、基准与评测)。就生成方向而言,各家方法可粗分为正向生成、反向(回译)与双向三类——这一区分由下文各论文自身的做法体现(ReSocratic 自述为正向的反向,OptMATH 自述为「双向」),并非综述给出的分类法。
- OR-Instruct(ORLM):以一批种子 OR 问题为起点,通过**改写 / 变体扩增**(rewriting、变换场景与约束)放大数据规模,产出用于指令微调的语料,训练出 ORLM 系列开源建模模型(据 [[../sources/orlm-2024]])。
- ReSocratic(逆向苏格拉底式):**先构造结构化的优化演示(demonstration),再「回译」成自然语言问题**——与「先有问题再生成解」的正向方向相反,从而保证生成样本的数学结构先天正确(据 [[../sources/resocratic-optibench-2025]])。
- ReSocratic-29k 数据集:用该方法合成约 29k 条样本做微调,把 **Llama-2-7B-Chat 在 OptiBench 上的准确率从 0.0% 提升到 30.6%**(据 [[../sources/resocratic-optibench-2025]])。
- OptMATH:采用**正向生成 + 回译 + 拒绝采样(rejection sampling)**的双向流水线;OptMATH-Train 以 **53 个种子生成器**程序化产出 **20 万+ 优化问题**,并通过求解与一致性校验过滤低质样本(据 [[../sources/optmath-2025]])。
- 共性套路:种子 → 程序化 / LLM 扩增 →(回译方向天然带「标准答案」)做一致性 / 可验证性过滤,以此控制合成语料的正确率。其中 OptMATH 明确用「正向建模 + 拒绝采样」校验 NL 与形式化的对应一致(据 [[../sources/optmath-2025]]);ReSocratic 的可验证性则来自「先构造带形式化标注的演示再回译」这一方向(据 [[../sources/resocratic-optibench-2025]],其求解器主要用于 OptiBench 的端到端评测而非已确证的训练数据过滤)。

## 与其它概念的关系

- 下游用途:合成语料直接喂给 [[instruction-tuning-or]] 做指令微调,产出 [[open-source-or-models]]。
- 服务任务:这些数据面向 [[nl-to-optimization]] 与 [[solver-code-generation]],也覆盖子步骤 [[constraint-extraction]]、[[objective-inference]]。
- 配套评测:ReSocratic 配 [[optibench-benchmark]];OptMATH 配 [[optmath-benchmark]];可与 [[mamo-benchmark]]、[[industryor-benchmark]] 等一并衡量泛化。
- 对比:与「不靠微调、靠检索补语境」的 [[retrieval-augmented-or]] 是互补路线;与 [[llm-as-optimizer]](让 LLM 直接当优化器)关注点不同——本词条关注的是造训练数据。
- 综述定位:[[or-llm-survey]] 把数据合成列为开源 OR 模型能力的关键瓶颈与抓手。

## 开放问题 / 矛盾

- 合成数据的**多样性 vs 同质化**:种子驱动的扩增易在分布上聚集,真实工业问题(多目标、隐式约束)覆盖度仍存疑,可能放大 [[failure-modes-hallucination]]。
- **可验证性边界**:回译 + 拒绝采样能保证「可求解」,但不保证「与原始业务意图一致」,正确性最终仍需 [[human-in-the-loop-or]] 抽检。
- 规模与质量权衡:OptMATH 强调 20 万+ 规模,ReSocratic 走小而精(~29k)路线,两者孰优取决于目标基座与评测口径,目前无统一定论。

## 来源

- [[../sources/orlm-2024]]
- [[../sources/resocratic-optibench-2025]]
- [[../sources/optmath-2025]]
- [[../sources/opt-modeling-meets-llms-survey-2025]]
