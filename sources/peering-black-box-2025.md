---
title: "窥探黑箱：用组件级评测揭示 LLM 优化建模中的错误 (Peering Inside the Black Box: Uncovering LLM Errors in Optimization Modelling through Component-Level Evaluation)"
type: source
authors: Dania Refai, Moataz Ahmed
year: 2025
url: https://arxiv.org/abs/2510.16943
added: 2026-05-30
tags: [source]
---

# 窥探黑箱：用组件级评测揭示 LLM 优化建模中的错误

> 一句话：这篇源把 LLM 生成的优化模型拆成决策变量 / 约束 / 目标分别打分，用 component-level evaluation 诊断「LLM 优化建模为什么错」，直指漏约束、错约束等失败模式，而不是只看 solver accuracy 这种聚合指标。

## 关键内容

- **提出组件级评测框架**：把优化模型拆成三个核心元素——decision variables、constraints、objective function——并各自独立评估。决策变量与约束用 precision / recall；目标函数用 normalized RMSE（归一化均方根误差）。这相比传统只看 solver accuracy / execution success 的 outcome-level 指标，能定位具体出错在哪个组件。
- **核心发现：结构正确性驱动可靠性**。分析各组件对整体 solver correctness 的影响后发现，solver 正确性最强地依赖于**高 constraint recall 与低 constraint RMSE**——也就是约束的结构完整性与准确性是模型可靠性能的首要驱动因素。
- **提炼三条实践原则**：(i) 完整的约束覆盖（complete constraint coverage）防止违例；(ii) 最小化约束 RMSE（minimize constraint RMSE）保证 solver 级准确性；(iii) 简洁输出（concise output）提升计算效率。
- **直接针对幻觉 / 缺失约束与 faithfulness 失败模式**：组件级 recall 可暴露「漏约束」，precision 可暴露「错约束 / 幻觉约束」，使 fine-grained 的失败模式可被量化诊断。
- **评测范围**：评测 GPT-5、LLaMA 3.1 Instruct、DeepSeek Math 三个模型，跨 6 种 prompting 策略（Basic、Act-As-Expert、Chain-of-Thought、Program-of-Thought、Self-Consistency、Modular Prompting），测试题取自 ComplexOR 数据集的四个不同难度问题（Knapsack 易、Aircraft Assignment 与 Diet 中、Aircraft Landing 难）。结果显示 GPT-5 一致领先，且 chain-of-thought、self-consistency、modular prompting 最有效。
- **可访问性**：HTML 版位于 arxiv.org/html/2510.16943v1（v1 提交于 2025-10-19，cs.LG）。

## LLM 提炼出的去向（摘入了哪些 wiki 词条）

- [[failure-modes-hallucination]]
- [[constraint-extraction]]
- [[process-evaluation-or]]
- [[objective-inference]]
