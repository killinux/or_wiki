---
title: 目标函数推断(Objective Inference)
type: note
tags: [objective-inference, autoformulation, optimization-direction]
updated: 2026-05-30
sources: [sources/nl4opt-2022.md, sources/peering-black-box-2025.md, sources/llmopt-2025.md, sources/optimus-2024.md]
---

# 目标函数推断(Objective Inference)

> 从自然语言描述中识别优化方向(max/min)并抽取目标函数的项与系数,把它形式化为求解器可用的目标表达式;它是 autoformulation 中与约束抽取并列的核心子步骤。

## 核心要点

- 任务定位:目标(objective)是 NL→优化形式化中与变量(variable)、约束(constraint)、参数(parameter)并列的核心组件之一——NL4Opt(NeurIPS 2022)的子任务 1 就是把这四类语义实体做命名实体识别(NER)并用 F1 评测 [[../sources/nl4opt-2022]]。
- 方向误判的危害:目标推断要同时确定优化方向(maximize / minimize)和目标表达式(决策变量上的系数与项)。把 max 写成 min(或反之)会在数学上完全翻转最优解,却往往仍能通过求解器、产出"看似合理"的数值,因此是端到端 autoformulation 最隐蔽、最典型的失败来源之一(参见 [[failure-modes-hallucination]];动机与 NL4Opt 把 objective 单独标注、单独评测一致 [[../sources/nl4opt-2022]])。
- 目标与约束的耦合:自然语言里"成本不超过 X""利润尽量高"等表述容易被误解析——把本应作为约束的上下界写进目标,或把"最小化总成本"误当作一条约束。因此目标推断不能孤立完成,需与 [[constraint-extraction]] 联合消歧。
- 统一建模要素:LLMOPT(ICLR 2025)提出的 five-element formulation 把优化问题统一抽象为"集合(sets)/ 参数(parameters)/ 变量(variables)/ 目标(objective)/ 约束(constraints)"五要素,其中目标被显式列为与变量、约束并列的独立建模要素,而非约束的副产品,以此提升优化泛化(optimization generalization)[[../sources/llmopt-2025]]。
- 组件级评测:Peering Inside the Black Box(2025)把 LLM 生成的模型拆成 decision variables / constraints / objective 分别打分——变量与约束用 precision / recall,目标函数用 normalized RMSE(归一化均方根误差)——使"目标推断对不对"成为独立于变量与约束的评测信号,而非只看聚合的 solver accuracy [[../sources/peering-black-box-2025]]。
- 这套形式化(变量 + 约束 + 目标)正是 NL→优化建模的标准三要素,传统上需 OR 专家手工完成 [[../sources/optimus-2024]]。

## 与其它概念的关系

- 上游 / 父任务:[[nl-to-optimization]](目标推断是其形式化阶段的子步骤);并列子步骤:[[constraint-extraction]](二者耦合、需联合消歧)。
- 下游:[[solver-code-generation]](把推断出的目标写成求解器目标函数)、[[what-if-explanation]](方向 / 系数变化对最优解的影响解释)。
- 对比 / 风险:[[failure-modes-hallucination]](方向误判、幻造系数是其典型失败模式)。
- 评测:[[nl4opt-benchmark]]、[[process-evaluation-or]](把目标作为独立打分维度,做组件级 / 过程级评估)。
- 校验:[[human-in-the-loop-or]](方向与系数易错,常需人工核对)。

## 开放问题 / 矛盾

- 端到端"解对了"是否等于"目标建对了"?方向或系数错误有时会与数据巧合互相抵消,使最终数值看似正确——这正是组件级 / 过程级评测([[process-evaluation-or]],及 [[../sources/peering-black-box-2025]])相对纯结果评测的价值所在,但二者对"正确"的口径并不一致。
- 目标 vs 约束的归属判定在自然语言中本质模糊("尽量低 / 不超过 X"),目前缺乏统一标准;[[constraint-extraction]] 与目标推断的边界如何划定仍是开放问题。
- 注意:Peering(2025)发现 solver 正确性最强地依赖于约束的 recall 与 RMSE,这提示在该实验设置下,约束的结构完整性比目标项更主导端到端可靠性——目标推断的相对权重仍有待更多证据 [[../sources/peering-black-box-2025]]。

## 来源

- [[../sources/nl4opt-2022]]
- [[../sources/peering-black-box-2025]]
- [[../sources/llmopt-2025]]
- [[../sources/optimus-2024]]
