---
title: ORQA 推理基准
type: note
tags: [benchmark, orqa, reasoning, multiple-choice]
updated: 2026-05-30
sources: [sources/orqa-2024.md]
---

# ORQA 推理基准

> ORQA(Operations Research Question Answering)是由专家构建的多选题(multiple-choice)基准,用于测量 LLM 对 Operations Research(OR)概念的多步推理能力,而非单纯写代码的能力。

## 核心要点

- 规模与覆盖:ORQA 含 1513 个多选实例,覆盖 20 个应用领域(application domains),题目由 OR 专家构建以考查概念层面的多步推理 [[../sources/orqa-2024]]。
- 三种核心能力:基准设计针对(1)规格理解(specification / problem-spec 理解)、(2)实体识别(entity recognition)、(3)关系识别(relationship recognition)三类技能,而非直接生成可运行模型代码 [[../sources/orqa-2024]]。
- 模型 vs 人类差距:Llama-3.1-405B 在 3-shot 设置下达到 77.2%,而人类专家约为 93%(基于 100 题样本),显示出明显的能力差距 [[../sources/orqa-2024]]。
- CoT 反常现象:在该基准上,chain-of-thought(CoT)提示并未稳定提升、有时反而降低表现,伴随幻觉(hallucination)与忽略指令(ignoring instructions)等失败模式 [[../sources/orqa-2024]]。
- 定位区别:ORQA 测的是对 OR 问题"是什么/如何关联"的概念推理,刻意区别于以"写出并调试求解器代码"为评分目标的代码生成式评测。

## 与其它概念的关系

- 对比 / 评测视角:与 [[process-evaluation-or]] 互补——ORQA 用静态多选题考概念推理,过程式评测则审查建模链路的中间步骤(上游/对比)。
- 下游风险:CoT 降效与幻觉印证了 [[failure-modes-hallucination]] 中描述的失败模式(下游)。
- 应用对照:ORQA 不直接评测 [[nl-to-optimization]] 的端到端建模代码,而是隔离其中的"理解规格、识别实体与关系"这一前置推理能力(对比 / 上游子能力)。
- 同类基准:可与 [[nl4opt-benchmark]]、[[mamo-benchmark]]、[[optibench-benchmark]] 等并列参考,但后者更偏向建模/求解正确性,ORQA 更偏向概念多选推理(对比)。

## 开放问题 / 矛盾

- 为何 CoT 在此类专家级 OR 概念题上反而有害?是提示分布外、上下文过长导致注意力分散,还是模型在长推理中累积幻觉?机制尚不明确 [[../sources/orqa-2024]]。
- 多选格式能否真正衡量"推理",抑或部分得分来自选项消除等捷径?其结论需配合 [[process-evaluation-or]] 的过程审查交叉验证。

## 来源

- [[../sources/orqa-2024]]
