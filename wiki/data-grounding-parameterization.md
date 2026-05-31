---
title: 数据/参数落地:从表格与外部数据到模型实例(Data Grounding & Parameterization)
type: note
tags: [llm, or]
updated: 2026-05-30
sources: [sources/resocratic-optibench-2025.md, sources/optimus-03-2024.md, sources/orlm-2024.md]
---

# 数据/参数落地:从表格与外部数据到模型实例(Data Grounding & Parameterization)

> 把自然语言中的实体、数值与约束映射成具体的参数(parameters)与索引集合(index sets),从而由抽象数学模型构造出一个可被求解器实例化、求解的模型实例(model instance)。

## 核心要点
- 任务边界:数据落地处于"NL → 数学模型"之后、"求解"之前——它负责给抽象模型填入真实数值与集合,使其成为可执行的实例。OptiMUS 用 connection graph 表示变量/约束/目标之间的关系并独立处理每一条约束与目标,这种结构化拆分中,为变量/约束填入具体数值与集合即数据落地要解决的部分 [[../sources/optimus-03-2024]]。
- 数据来源:数值不止来自文本内嵌,也来自结构化数据。OptiBench 明确包含带**表格(tabular)**数据的问题,要求模型从结构化数据中抽取参数,而不仅是从文本句子做约束抽取 [[../sources/resocratic-optibench-2025]]。
- 模块化以扩展规模:OptiMUS 用 connection graph 独立处理每一条约束与目标,避免把整个问题塞进一个超长 prompt,从而在不超出 context 限制的情况下处理**长描述、复杂数据**的问题 [[../sources/optimus-03-2024]]。
- 真实场景更难:IndustryOR 是首个工业级 OR 基准,覆盖 13 个行业、5 种题型、3 个难度等级,其工业级真实性可放大数据/参数落地的难度(如单位、口径与缺失值等问题——此为本词条的推断,源文未逐项列举) [[../sources/orlm-2024]]。
- 失败模式独立:参数落地错误(数值抽取错、参数错配、索引/集合对齐错)是一类区别于"约束/目标逻辑建模错误"的失败来源,常导致模型可被求解但答案错误(此区分为本词条的分析框架)——OptiBench 采用端到端评测,要求 LLM 调用代码求解器并给出可读的数值答案,因此把代码可执行与最终数值答案正确性绑定在一起考察 [[../sources/resocratic-optibench-2025]]。

## 与其它概念的关系
- 上游:[[nl-to-optimization]](整体形式化流程,数据落地是其中一环)、[[constraint-extraction]](先抽出约束的逻辑骨架,再为其填入参数数值)。
- 下游:[[solver-code-generation]](填好参数后生成可运行的求解器代码)。
- 对比:[[failure-modes-hallucination]](参数落地错误是与逻辑建模错误并列的一类失败,需区分对待)。
- 相关:[[retrieval-augmented-or]](从外部 CSV/DB/知识中检索并对齐数据,辅助参数落地)、[[structured-intermediate-representation]](把模型骨架与实例数据解耦的中间表示有助于参数落地)。
- 评测:[[optibench-benchmark]](含表格数据,考察结构化→参数的落地能力)、[[industryor-benchmark]](真实工业数据,放大单位/口径/缺失值等落地难点)。

## 开放问题 / 矛盾
- 表格/外部数据与文本约束如何在同一管线中可靠对齐?命名实体对齐与单位换算缺乏统一评测协议。
- 大规模参数下,模块化处理能扩展到多大?OptiMUS 主张用 connection graph 独立处理约束/目标有助于扩展 [[../sources/optimus-03-2024]],但合成数据(如 ReSocratic 反向合成)是否覆盖了真实业务中的大规模、稀疏与缺失参数分布,仍是开放问题 [[../sources/resocratic-optibench-2025]]。

## 来源
- [[../sources/resocratic-optibench-2025]]
- [[../sources/optimus-03-2024]]
- [[../sources/orlm-2024]]
