---
title: "OptMATH：面向优化建模的可扩展双向数据合成框架（A Scalable Bidirectional Data Synthesis Framework for Optimization Modeling）"
type: source
authors: "Hongliang Lu, Zhonglin Xie, Yaoyu Wu, Can Ren, Yuxuan Chen, Zaiwen Wen"
year: 2025
url: https://arxiv.org/abs/2502.11102
added: 2026-05-30
tags: [source]
---

# OptMATH：面向优化建模的可扩展双向数据合成框架

> 一句话：提出双向数据合成框架——从种子形式化正向生成实例、回译为自然语言、再用拒绝采样验证一致性——同时产出大规模训练集 OptMATH-Train 与高难度 held-out 基准 OptMATH-Bench。

## 关键内容

- **双向合成（bidirectional synthesis）**：正向从数学形式化生成实例数据（forward generation），回译为自然语言描述（back-translation），再用正向建模 + 拒绝采样（rejection sampling）验证 NL 与形式化的对应一致，保证数据质量。
- **OptMATH-Train**：20 万+ 高质量问题，由 53 个种子生成器（seed generators）驱动，覆盖 10+ 应用领域。
- **OptMATH-Bench**：166 个问题的高难度评测集，自然语言上下文比同类基准长约 2.9 倍，覆盖 LP / MILP / IP / NLP / SOCP 多种问题类型。
- **模型效果**：训练 0.5B–32B 多档模型；最佳 OptMATH-Qwen2.5-32B 在 NL4OPT 95.9%、MAMO ComplexLP 54.1%、IndustryOR 31.0%、OptMATH-Bench 34.7%，整体超过 GPT-3.5 / GPT-4 / DeepSeek-V3。
- **开源**：代码与数据见 github.com/optsuite/OptMATH；发表于 ICML 2025（poster），arXiv:2502.11102。

## LLM 提炼出的去向

- [[optmath-benchmark]]
- [[or-data-synthesis]]
- [[open-source-or-models]]
- [[nl-to-optimization]]
