---
title: 约束抽取(Constraint Extraction)
type: note
tags: [constraint-extraction, ner, faithfulness, autoformulation]
updated: 2026-05-30
sources: [sources/nl4opt-2022.md, sources/peering-black-box-2025.md, sources/chain-of-experts-2024.md]
---

# 约束抽取(Constraint Extraction)

> 从自然语言题面中识别构成约束的实体(决策变量、参数、限值、约束方向),并把它们映射为可被求解器处理的不等式/等式。

## 核心要点
- 约束抽取是 NL → 优化建模(autoformulation)的关键子步骤:先认出题面里的"变量、参数、限值、约束方向",再组装成 ≤ / ≥ / = 形式的代数约束。
- NL4Opt(NeurIPS 2022 竞赛)把这一步形式化为**子任务 1:优化组件的命名实体识别(NER)**——识别 objective(目标)、variable(变量)、constraint(约束)、parameter(参数)等语义实体,用 **F1** 评测;子任务 1 是子任务 2(生成 canonical 形式化表示)的预处理步骤(据 [[../sources/nl4opt-2022]])。
- 因此约束抽取的质量直接限制了下游建模的上限:子任务 1 抽出的组件喂给子任务 2 才能生成可转成求解器格式的精确数学表示(据 [[../sources/nl4opt-2022]])。
- 组件级(component-level)研究表明:求解最终正确性(solver correctness)**最强地依赖于高约束 recall 与低约束 RMSE**——即约束的结构完整性与数值准确性是模型可靠性的首要驱动因素,而约束 precision、决策变量指标只起次要作用(据 [[../sources/peering-black-box-2025]])。
- 该组件级框架把模型拆成 decision variables / constraints / objective 分别打分:变量与约束用 precision / recall(recall 暴露"漏约束"、precision 暴露"错约束/幻觉约束"),目标函数用 normalized RMSE;相比只看 solver accuracy 的聚合指标更能定位出错组件(据 [[../sources/peering-black-box-2025]])。
- 常见错误模式:漏约束(missing,recall 低)、虚构约束(hallucinated,precision 低)——该源还观察到模型会误加多余的非负性约束等冗余条件;其中缺失约束(recall 低)被组件级分析认定为对最终 solver 正确性影响最大的因子,因而是 LLM 优化建模最关键的 faithfulness 失败来源之一(据 [[../sources/peering-black-box-2025]])。隐含约束(implicit,如非负性、整数性、容量上限等题面未明说的条件)与单位/方向错误(把 ≤ 写成 ≥ 或量纲不一致)是约束抽取的一般性失败类型,但并非该组件级评测源逐项枚举的内容。

## 与其它概念的关系
- 上游父任务:[[nl-to-optimization]](约束抽取是其内部的一个子步骤)。
- 并列子任务 / 对比:[[objective-inference]](目标抽取与约束抽取相对,二者同为 NER 要识别的核心组件)。
- 下游:[[solver-code-generation]](抽出的约束需转写为求解器代码);[[self-debugging]](靠求解器/可行性反馈与"前向构造 + 后向反思"回路迭代自纠错、修正建模错误,见 [[../sources/chain-of-experts-2024]];该源未具体说明这一回路专门针对漏约束或约束方向错误)。
- 评测:[[nl4opt-benchmark]](子任务 1 即约束相关组件的 NER);组件级 / 过程级评测见 [[process-evaluation-or]]。
- 失败分析:[[failure-modes-hallucination]](漏约束、隐含约束、虚构约束等是核心失败类型)。

## 开放问题 / 矛盾
- 隐含约束(非负、整数、互斥等)如何系统性补全?题面常默认省略,纯 NER 难以"识别本不存在的文本片段",需结合领域常识或 [[human-in-the-loop-or]] 校验。
- 组件指标与端到端正确性的衡量目标存在张力:
  > ⚠️ 矛盾:NL4Opt 以约束相关组件 NER 的 **F1** 作为子任务 1 主指标(来源 [[../sources/nl4opt-2022]])vs 组件级评测主张 **约束 recall / 约束 RMSE** 才是最终 solver 正确性的主导因子(来源 [[../sources/peering-black-box-2025]]);F1 同等看待 precision 与 recall,而组件级研究发现 recall 对成败更关键,两者衡量重点不完全对齐。

## 来源
- [[../sources/nl4opt-2022]]
- [[../sources/peering-black-box-2025]]
- [[../sources/chain-of-experts-2024]]
