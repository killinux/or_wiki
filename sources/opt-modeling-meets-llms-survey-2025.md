---
title: "优化建模遇上 LLM:进展与未来方向(综述) (A Survey of Optimization Modeling Meets LLMs)"
type: source
authors: "Ziyang Xiao, Jingrong Xie, Lilin Xu, Shisi Guan, Jingyan Zhu, Xiongwei Han, Xiaojin Fu, WingYin Yu, Han Wu, Wei Shi, Qingcan Kang, Jiahui Duan, Tao Zhong, Mingxuan Yuan, Jia Zeng, Yuan Wang, Gang Chen, Dongxiang Zhang"
year: 2025
url: https://arxiv.org/abs/2508.10047
added: 2026-05-30
tags: [source]
---

# 优化建模遇上 LLM:进展与未来方向(综述) (A Survey of Optimization Modeling Meets LLMs)

> 一句话:这是一篇覆盖"LLM 做优化建模"全栈的综述(数据合成/微调、推理框架、基准与评测),不仅梳理分类法,还主动审计现有基准的质量问题并重建清洗后的公平排行榜,值得作为该方向的入口与质量参照。

## 关键内容

- **全栈分类法**:把"LLM × 优化建模"切成三大块——(1) 数据合成与微调(data synthesis / fine-tuning),(2) 推理框架(inference frameworks),区分单 LLM 与多智能体(single-LLM vs multi-agent)两条路线,(3) 基准与评测(benchmarks & evaluation)。
- **基准质量审计**:系统检查现有 benchmark,发现意外偏高的错误率,问题来源包括缺失数据(missing data)、歧义/不完整的形式化(ambiguous formalization)、以及错误的 ground truth 标注;并据此发布清洗后的数据集。
- **清洗后排行榜**:基于清洗数据重建 leaderboard,在同时控制底座 LLM(base model)与数据集的条件下做公平比较,避免被脏数据或不一致评测口径误导。
- **内部视角**:作者团队与 Chain-of-Experts(多智能体 OR 建模)工作有重叠,因而提供的是带有实践/内部视角的分类法,而非纯外部综述。
- **发表与资源**:IJCAI 2025(Survey Track,2025-08-30 于广州),proceedings 论文编号 1192(pp. 10742–10750);arXiv:2508.10047(2025-08-12 提交,cs.AI);并配套上线社区资源门户(在线整合清洗数据集、代码与论文库,见 https://llm4or.github.io/LLM4OR/)。

> 注:title / authors / year / venue / 论文编号 / 主要结论(全栈覆盖、基准高错误率、清洗数据集 + 公平排行榜、在线门户)已经 WebFetch(arXiv abs)与 WebSearch(arXiv、IJCAI proceedings、dblp、alphaXiv)交叉核实。论文未公开各基准"精确错误率百分比"的单一数字,本笔记据原文表述写为"surprisingly high error rate",未编造具体百分比。

## LLM 提炼出的去向(摘入了哪些 wiki 词条)

- [[or-llm-survey]]
- [[process-evaluation-or]]
- [[failure-modes-hallucination]]
- [[or-data-synthesis]]
