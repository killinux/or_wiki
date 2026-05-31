---
title: "ReEvo：作为 Hyper-Heuristics 的大语言模型与反思式演化（Reflective Evolution）"
type: source
authors: "Haoran Ye, Jiarui Wang, Zhiguang Cao, Federico Berto, Chuanbo Hua, Haeyeon Kim, Jinkyoo Park, Guojie Song"
year: 2024
url: https://arxiv.org/abs/2402.01145
added: 2026-05-30
tags: [source]
---

# ReEvo：作为 Hyper-Heuristics 的大语言模型与反思式演化（Reflective Evolution）

> 一句话：提出 Language Hyper-Heuristics（LHH），把 LLM 启发式生成框为"在启发式空间而非解空间搜索"的 hyper-heuristics，并用 LLM 的 "reflections" 作为 verbal gradients 引导演化搜索，样本效率优于此前 LHH。

## 关键内容

- 提出 **Language Hyper-Heuristics (LHHs)**：作为 hyper-heuristics 的一个变体，借助 LLM 以最小人工干预、在开放式（open-ended）启发式空间中生成启发式——即在启发式空间而非解空间中搜索。
- 核心方法 **Reflective Evolution (ReEvo)**：将演化搜索与 LLM 的短期/长期 **reflections** 结合，在开放式启发式空间内提供 **verbal gradients**（语言形式的"梯度"）来引导搜索方向。
- 评测覆盖 **5 类算法**、**6 个组合优化（combinatorial optimization）问题**，并同时考虑 **白箱（white-box）/ 黑箱（black-box）** 两种设置。
- 报告达到或接近 SOTA 的元启发式（metaheuristics）与神经求解器（neural solvers）表现，并且比 **EoH** 等此前 LHH 方法更省样本（更高的样本效率）。
- 发表于 **NeurIPS 2024**（arXiv:2402.01145）；开源代码由 AI4CO 维护：github.com/ai4co/LLM-as-HH 。

## LLM 提炼出的去向（摘入了哪些 wiki 词条）

- [[heuristic-evolution]]
- [[llm-as-optimizer]]
- [[combinatorial-opt-llm]]
