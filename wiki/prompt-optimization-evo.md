---
title: Prompt 优化作为 LLM 优化范式
type: note
tags: [prompt-optimization, opro, evolutionary, self-improvement]
updated: 2026-05-30
sources: [sources/opro-2024.md, sources/ec-era-llm-survey-2024.md]
---

# Prompt 优化作为 LLM 优化范式

> 把"找一段好 prompt"本身当成一个黑箱优化问题:在自然语言的 prompt 空间里搜索,使下游任务指标最大化——LLM 既可以充当被优化对象,也可以充当优化器本身。

## 核心要点

- 问题设定:prompt 工程被重述为搜索 / 优化问题——决策变量是 prompt 文本(离散、组合、无梯度),目标是任务准确率等指标,只依赖对目标的黑箱打分;因此可用迭代搜索替代人工试错。
- OPRO(Optimization by PROmpting)的核心机制是 **meta-prompt 迭代**:把待解任务用自然语言写进 meta-prompt,并把此前评估过的(解, 分数)按分数排序作为优化轨迹一并喂给 LLM;LLM 据此提出新一批候选解,评估后回填,无梯度地循环改进(据 [[../sources/opro-2024]])。
- 效果:OPRO 优化得到的 prompt 在 GSM8K 上比人工设计的 prompt 高最多约 **8%**,在 Big-Bench Hard(BBH)的若干任务上高最多达 **50%**(据 [[../sources/opro-2024]])。
- 标志性结果:在 PaLM-2-L 上,OPRO 优化出的指令把 GSM8K 零样本准确率从 **71.8% 提升到 80.2%**,过程中"发现"了著名提示句 "Take a deep breath and work on this problem step by step."(据 [[../sources/opro-2024]])。
- 进化计算视角:有综述把"用进化计算(EC)作为 black-box optimizer 增强 LLM(典型场景即 prompt engineering / prompt optimization,在文本空间无梯度搜索)"归为 EA-enhanced LLM 这条主线(据 [[../sources/ec-era-llm-survey-2024]])。
- 互补性:LLM 提供领域知识与生成 / 推理能力,EA 提供鲁棒的黑箱全局搜索能力,二者结合是该交叉领域的核心动机(据 [[../sources/ec-era-llm-survey-2024]]);无论用 LLM 自身还是 EC 作搜索器,都把"自然语言 artifact 的改进"形式化为可迭代、可评分的优化循环。

## 与其它概念的关系

- 上游 / 互补:[[llm-as-optimizer]]——本词条是其在"prompt 空间"上最成熟的落地;LLM-as-optimizer 是更一般的范式(把 LLM 当通用黑箱优化器),OPRO 即其代表作。
- 对比:[[heuristic-evolution]]——同属"用进化 / 迭代搜索改进文本 artifact",但 heuristic-evolution 优化的是启发式 / 算法代码,本词条优化的是 prompt 指令;两者都可借助 EC 算子做无梯度搜索。
- 对比:[[combinatorial-opt-llm]]——OPRO 也在线性回归与小规模 TSP 上作热身演示,但本词条聚焦"优化 prompt"这一元任务,而非直接求解 OR 问题。
- 下游应用:[[nl-to-optimization]]——更好的 prompt 优化可作为提升 NL→优化建模等 OR 流水线零样本表现的通用增益手段。

## 开放问题 / 矛盾

- 适用边界:OPRO 自述适合**小规模 / 黑箱**场景;当搜索空间显著增大时性能退化,LLM 难以在大空间内稳定逼近最优(据 [[../sources/opro-2024]])。
- 泛化与稳健性:被搜索出的 prompt 往往与具体模型 / 任务强绑定(换模型即可能失效),其增益是真实推理改进还是对评测集的过拟合,仍待厘清。
- 评测口径:论文报告的"相对人工 prompt 提升 8% / 50%"是**上界**而非平均,且基线 prompt 选取差异大,跨工作的数字不直接可比。

## 来源

- [[../sources/opro-2024]]
- [[../sources/ec-era-llm-survey-2024]]
