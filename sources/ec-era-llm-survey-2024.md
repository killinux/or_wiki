---
title: "演化计算在大语言模型时代:综述与路线图(Evolutionary Computation in the Era of Large Language Model: Survey and Roadmap)"
type: source
authors: Xingyu Wu, Sheng-hao Wu, Jibin Wu, Liang Feng, Kay Chen Tan
year: 2024
url: https://arxiv.org/abs/2401.10034
added: 2026-05-30
tags: [source]
---

# 演化计算在大语言模型时代:综述与路线图

> 一句话:系统梳理 LLM 与演化计算(EC/EA)的双向关系并给出路线图,为 LLM-as-optimizer 与启发式自动发现提供定位框架,值得收作"为什么这条研究线成立"的综述锚点。

## 关键内容

- **双向分类框架**:把交叉工作分为 LLM-enhanced EA(用 LLM 增强演化算法)与 EA-enhanced LLM(用演化算法增强 LLM)两大方向,并讨论二者的融合/协同方法。
- **EC 作为黑箱优化器增强 LLM**:演化计算可作为 black-box optimizer 优化 LLM 的输入与配置,典型场景是 prompt engineering / prompt optimization(无需梯度,直接在文本空间搜索)。
- **覆盖应用场景**:综述涵盖代码生成(code generation)、软件工程(software engineering)、神经架构搜索(NAS)等复杂优化任务,说明 LLM+EC 已落到实际下游问题。
- **互补性论点**:LLM 提供领域知识与推理/生成能力,EA 提供鲁棒的黑箱优化能力,二者结合是该领域的核心动机。
- **自我定位与路线图**:自述为 LLM 时代演化计算研究方向的首个综合综述,并系统列出挑战与未来研究方向。
- **出处**:arXiv:2401.10034(首次提交 2024-01-18),后发表于 IEEE Transactions on Evolutionary Computation(IEEE TEVC)。

## LLM 提炼出的去向(摘入了哪些 wiki 词条)

- [[llm-as-optimizer]]
- [[heuristic-evolution]]
- [[prompt-optimization-evo]]
