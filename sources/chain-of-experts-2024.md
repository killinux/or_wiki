---
title: "Chain-of-Experts:当 LLM 遇上复杂运筹优化问题(Chain-of-Experts: When LLMs Meet Complex Operations Research Problems)"
type: source
authors: "Ziyang Xiao, Dongxiang Zhang, Yangjun Wu, Lilin Xu, Yuan Jessica Wang, Xiongwei Han, Xiaojin Fu, Tao Zhong, Jia Zeng, Mingli Song, Gang Chen"
year: 2024
url: "https://openreview.net/forum?id=HobyL1B9CZ"
added: 2026-05-30
tags: [source]
---

# Chain-of-Experts:当 LLM 遇上复杂运筹优化问题

> 一句话:首个面向复杂 OR(Operations Research)的多智能体协作 LLM 框架,由 conductor 调度一组角色化专家完成"前向构造 + 后向反思"的自纠错回路,并发布 ComplexOR 基准;值得收是因为它确立了"建模—编程—审查"多 agent 流水线的范式,后续 OR×LLM agent 工作多有承接。

## 关键内容

- **多智能体架构(conductor + experts)**:由一个 conductor(指挥)动态调度约 **11 个角色化专家** agent(如术语解释、建模、编程、代码审查等),让 LLM 各司其职而非单体作答。
- **前向构造 + 后向反思(forward thought construction + backward reflection)**:专家链条先逐步前向构造解法,再通过 backward reflection 自我反思、定位并修正错误,形成自纠错回路。
- **LPWP(NL4Opt)上的结果**:在 LPWP 基准上达到 **58.9%** 准确率,比 Reflexion agent 高出约 **8.2 个百分点**。
- **换用 GPT-4 的增益**:使用 GPT-4 时,相对基线在 LPWP 上提升约 **8.3%**、在 ComplexOR 上提升约 **5.5%**。
- **发布 ComplexOR 基准**:作者构建并发布了面向复杂 OR 的 **ComplexOR** 基准(含 **37 个复杂问题**),用于评测端到端的自然语言到优化建模能力。
- **开源与发表**:被 **ICLR 2024**(poster;OpenReview HobyL1B9CZ)收录;代码开源于 github.com/xzymustbexzy/Chain-of-Experts。

## LLM 提炼出的去向(摘入了哪些 wiki 词条)

- [[multi-agent-or]]
- [[nl-to-optimization]]
- [[self-debugging]]
- [[complexor-benchmark]]
- [[llm-or-agents]]
