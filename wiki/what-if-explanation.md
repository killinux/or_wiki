---
title: 可行性/灵敏度的自然语言解释(What-if)
type: note
tags: [what-if, sensitivity-analysis, explainable-optimization, decision-support]
updated: 2026-05-30
sources: [sources/optiguide-2023.md]
---

# 可行性/灵敏度的自然语言解释(What-if)

> 用 LLM 充当优化系统的「解释层」:把用户的 what-if / 灵敏度(sensitivity)问题翻译成对优化模型的扰动并重解,再把求解结果回译成非专家可读的自然语言解释。

## 核心要点
- 面向场景:供应链等运营人员常问「如果把仓库 A 关掉会怎样?」「为什么这个订单走这条路线?」这类 what-if / 解释性问题,需要把求解结果讲成「人话」([[../sources/optiguide-2023]])。
- 翻译为扰动并重解:LLM 不直接做优化决策,而是把自然语言问题翻译成对优化模型的「扰动」(改数据 / 改约束),触发求解器重新求解,再把新结果翻译回自然语言([[../sources/optiguide-2023]])。
- 隐私保护:只把代码和优化模型「结构」发给 LLM,不发送公司专有的具体数值数据([[../sources/optiguide-2023]])。
- 分工边界:LLM 仅在「解释层 / 交互层」,组合优化的正确性仍由经典求解器保证([[../sources/optiguide-2023]])。
- 准确率:OptiGuide 在内部基准上报告 in-distribution 的 what-if 问答准确率 > 90%(论文自述)([[../sources/optiguide-2023]])。
- 可行性解释:同一范式可用于诊断「为什么不可行 / 为什么这样解」——通过对比扰动前后的解或约束状态,生成可读的可行性 / 不可行原因解释。

## 与其它概念的关系
- 上游:[[nl-to-optimization]](先有可被扰动的形式化模型,才能回答 what-if);[[solver-code-generation]](扰动通常表现为对求解器代码 / 模型数据的改写)。
- 下游 / 应用:[[supply-chain-llm]](OptiGuide 即供应链场景的解释接口);[[human-in-the-loop-or]](解释是人在回路决策支持的关键环节)。
- 对比 / 协同:[[multi-agent-or]](可把「提问—扰动—重解—解释」拆成多智能体协作,而非单次问答)。

## 开放问题 / 矛盾
- 泛化边界:>90% 的准确率是 in-distribution 且为论文自述,out-of-distribution 的 what-if(如组合性新约束)表现未知。
- 解释的忠实性:LLM 生成的自然语言解释是否真实反映求解器的灵敏度结果,仍需 [[human-in-the-loop-or]] 校验,存在「听起来合理但与数值不符」的风险。

## 来源
- [[../sources/optiguide-2023]]
