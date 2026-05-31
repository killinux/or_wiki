---
title: "OptiBench Meets ReSocratic：度量与改进 LLM 的优化建模能力"
type: source
authors: "Zhicheng Yang, Yiwei Wang, Yinya Huang, Zhijiang Guo, Wei Shi, Xiongwei Han, Liang Feng, Linqi Song, Xiaodan Liang, Jing Tang"
year: 2025
url: "https://arxiv.org/abs/2407.09887"
added: 2026-05-30
tags: [source]
---

# OptiBench Meets ReSocratic：度量与改进 LLM 的优化建模能力

> 一句话：这篇论文同时给出了一个端到端的优化建模基准 OptiBench（覆盖非线性问题与表格数据），以及一种"反向"数据合成方法 ReSocratic（先逐步构造带形式化的优化演示，再回译成自然语言问题），值得收是因为它把"如何度量"和"如何用合成数据改进开源模型"两件事一起解决了。

## 关键内容

- **OptiBench 基准**：包含 605 个经人工校验（human-verified）的优化问题，覆盖线性/非线性、含/不含表格数据（tabular data）四类组合；采用端到端评测——要求 LLM 调用代码求解器（code solver）并给出可读的数值答案，而非只评中间形式化。
- **ReSocratic 反向合成法**：不同于"先出问题再出解"的正向（forward）方式，ReSocratic 先一步步增量地合成带形式化标注的优化演示（demonstration），再把演示回译（back-translate）为自然语言问题，从而提高合成数据的质量与多样性。
- **ReSocratic-29k 数据集**：用上述方法合成约 29k（29,000）条样本，用于开源模型的监督微调（SFT）。
- **微调显著提升开源模型**：在 ReSocratic-29k 上 SFT 后，Llama-2-7B-Chat 从 0.0% 提升到 30.6%；Llama-3-8B-Instruct 从 13.6% 提升到 51.7%。
- **闭源基线与开源代码**：GPT-4 在 OptiBench 上以 few-shot 约达 65.5%（最强闭源基线）；代码与数据开源于 github.com/yangzhch6/ReSocratic。

## LLM 提炼出的去向（摘入了哪些 wiki 词条）

- [[optibench-benchmark]]
- [[or-data-synthesis]]
- [[open-source-or-models]]
- [[nonlinear-optimization-llm]]
- [[nl-to-optimization]]
