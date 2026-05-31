---
title: 开源 OR 模型(ORLM·LLMOPT)
type: note
tags: [open-source, orlm, llmopt, fine-tuned, 7b]
updated: 2026-05-30
sources: [sources/orlm-2024.md, sources/llmopt-2025.md, sources/resocratic-optibench-2025.md, sources/optmath-2025.md]
---

# 开源 OR 模型(ORLM·LLMOPT)

> 通过在合成的优化建模数据上微调开源中小模型(7B/8B/32B 量级),让其在自然语言到优化建模任务上追平甚至超过闭源大模型(GPT-4 等),同时规避把专有问题发往闭源 API 的数据隐私风险。

## 核心要点
- 动机:依赖闭源 LLM 通过 prompting 求解会带来 **数据隐私** 隐患,并限制组织对模型的定制能力——这正是训练开源 OR 模型的主要出发点(据 [[../sources/orlm-2024]])。
- ORLM 用半自动数据合成方法 **OR-Instruct** 生成面向优化建模的训练数据,微调出基于 LLaMA-3-8B、Mistral-7B 的开源模型(据 [[../sources/orlm-2024]])。
- 最佳 ORLM(基于 LLaMA-3-8B)在 NL4Opt、MAMO、IndustryOR 上 **同时达到 SOTA**;其中 IndustryOR 是该工作引入的首个工业级 OR 基准(据 [[../sources/orlm-2024]])。
- 相对 GPT-4 标准 prompting,ORLM 的 micro 平均高出约 **42.2%**、macro 平均高出约 **55.4%**,显示 7B/8B 量级开源模型在 OR 任务上可超越体量大得多的闭源模型(据 [[../sources/orlm-2024]])。
- LLMOPT 引入 **five-element formulation**(五要素结构化中间表示)统一描述优化问题,配合 multi-instruction 微调与 self-correction / 对齐回路来减少错误形式化;在覆盖约 20 个领域的 6 个真实数据集上提升平均求解准确率(据 [[../sources/llmopt-2025]])。
- OptMATH 采用 **bidirectional**(正向 problem→model、反向 model→problem)可控难度数据合成,微调后的 **OptMATH-Qwen2.5-32B 在多个基准上超过 GPT-3.5、GPT-4 与 DeepSeek-V3**,更小的微调模型也能与体量大得多的闭源模型竞争(据 [[../sources/optmath-2025]])。
- ReSocratic 走 **反向(back-translation)** 合成路线:从已格式化的求解演示倒推出问题,用 ReSocratic-29k 微调 LLaMA-3 / Mistral,在含非线性与表格数据的 OptiBench 上大幅提升、缩小乃至超过闭源基线的差距(据 [[../sources/resocratic-optibench-2025]])。

## 与其它概念的关系
- 上游能力:本质上服务于 [[nl-to-optimization]](把自然语言问题自动形式化并求解),开源模型是其闭源 prompting 路线的替代方案。
- 依赖:训练数据来自 [[or-data-synthesis]](OR-Instruct / ReSocratic / OptMATH 双向合成);训练方法属于 [[instruction-tuning-or]]。
- 评测(下游对比):在 [[nl4opt-benchmark]]、[[mamo-benchmark]]、[[industryor-benchmark]]、[[optibench-benchmark]]、[[optmath-benchmark]] 上与闭源模型对比。
- 对比:与 [[llm-or-agents]] / [[multi-agent-or]] 这类「闭源大模型 + 多智能体编排」的路线互为对照——前者偏开源单模型微调,后者偏推理时编排。
- 相关组件:LLMOPT 的 self-correction 回路与 [[self-debugging]] 思路相通;OptiBench 涉及 [[nonlinear-optimization-llm]]。

## 开放问题 / 矛盾
- 合成数据的正确性与覆盖度如何保证?OR-Instruct、ReSocratic、OptMATH 用了不同合成策略(正向 / 反向 / 双向),哪种在分布外问题上更稳健尚无统一结论。
- 「超过 GPT-4」的口径依赖具体基准、解析与判分方式(如 OptiBench 用 solver 可执行答案打分),跨论文的横向可比性有限,需谨慎解读。
- 模型规模与开源可用性的权衡:ORLM 用 7B/8B 即称 SOTA,而 OptMATH 的最强结果来自 32B,二者对「中小模型即可替代闭源」的强度主张不完全一致。

## 来源
- [[../sources/orlm-2024]]
- [[../sources/llmopt-2025]]
- [[../sources/resocratic-optibench-2025]]
- [[../sources/optmath-2025]]
