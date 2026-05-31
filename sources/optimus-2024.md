---
title: OptiMUS — Scalable Optimization Modeling with (MI)LP Solvers and LLMs
type: paper
url: https://arxiv.org/abs/2402.10172
added: 2026-05-30
---

# OptiMUS — Scalable Optimization Modeling with (MI)LP Solvers and LLMs

## 出处
- 作者 / 机构 / 年份:AhmadiTeshnizi 等,ICML 2024(初版 arXiv 2310.06116,scalable 版 2402.10172)
- 链接:https://arxiv.org/abs/2402.10172 ;代码:https://github.com/teshnizi/OptiMUS

## 要点摘录(人放,LLM 读不改写)
- 是一个 **LLM 智能体**,从**自然语言描述**出发,形式化并求解(混合整数)线性规划 (MI)LP。
- 动机:现实优化问题普遍存在,但形式化+求解需要专家,门槛高,导致很多问题靠手工启发式而非用求解器求最优。
- 能力闭环:建数学模型 → 写并调试求解器代码 → 评估解 → 据评估**迭代改进**模型与代码。
- **模块化结构**:把长描述/复杂数据拆开处理,避免超长 prompt,从而能 scale 到大问题。
- 自带基准 **NLP4LP**(LP 与 MILP 题目数据集)。
- 效果:相比"朴素 LLM 直接 prompting",多解出约 **67%** 的问题。

## 我的问题 / 想让 wiki 回答的
- "NL→优化建模"这条路线的标准范式是什么?瓶颈和评测怎么做?
