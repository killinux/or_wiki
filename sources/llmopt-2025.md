---
title: "LLMOPT: Learning to Define and Solve General Optimization Problems from Scratch"
type: source
authors: "Caigao Jiang, Xiang Shu, Hong Qian, Xingyu Lu, Jun Zhou, Aimin Zhou, Yang Yu"
year: 2025
url: https://arxiv.org/abs/2410.13213
added: 2026-05-30
tags: [source]
---

# LLMOPT：用通用 five-element formulation 学会定义并求解一般优化问题

> 一句话：LLMOPT 用通用的 five-element formulation 统一刻画多类优化问题，配合多指令微调与模型对齐 + 自纠错,系统性提升 LLM 在「定义」与「求解」优化问题上的泛化能力与精度。

## 关键内容

- 提出通用的 five-element formulation,把不同类型优化问题统一抽象为一种结构化定义,以提升 optimization generalization(优化泛化)。
- 用 multi-instruction tuning(多指令微调)同时改进问题 formalization 与 solver code generation 的准确性与通用性。
- 引入 model alignment + self-correction(自纠错)机制,抑制求解过程中的 hallucination(幻觉)。
- 覆盖 linear / nonlinear programming、mixed integer programming 与 combinatorial optimization 等多类问题。
- 在 6 个真实数据集(约 20 个领域/fields)上评测,报告相比 SOTA 平均求解准确率(solving accuracy)提升 11.08%。
- ICLR 2025(poster);arXiv:2410.13213。开源:github.com/caigaojiang/LLMOPT 与 github.com/antgroup/LLMOPT。

## LLM 提炼出的去向（摘入了哪些 wiki 词条）

- [[open-source-or-models]]
- [[instruction-tuning-or]]
- [[self-debugging]]
- [[failure-modes-hallucination]]
- [[nl-to-optimization]]
