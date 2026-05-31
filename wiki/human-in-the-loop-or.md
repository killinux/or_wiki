---
title: 人在回路的 OR 决策
type: note
tags: [human-in-the-loop, decision-intelligence, interactive, autogen]
updated: 2026-05-30
sources: [sources/optiguide-2023.md]
---

# 人在回路的 OR 决策

> 让非专家用自然语言驱动优化模型,LLM 充当助手而非替代,关键执行环节由人类规划者(planner)在回路中把关。

## 核心要点
- 交互范式:规划者用自然语言提问(如"为什么不用供应商 B?"),系统据此改写/重解模型并回答,无需理解底层数学 [[../sources/optiguide-2023]]。
- 角色分工:LLM 负责"翻译/解释",真正的求解仍交给求解器;LLM 充当助手而非替代决策者 [[../sources/optiguide-2023]]。
- safeguard agent:OptiGuide 设有 safeguard / 校验环节,在执行前检查 LLM 生成代码的安全性,降低其直接操作生产系统的风险 [[../sources/optiguide-2023]]。
- 真实部署:OptiGuide 在微软 Azure 云供应链的 server placement 真实场景中验证 [[../sources/optiguide-2023]]。
- 场景定位:面向规划者的生产用 what-if 决策支持("什么会发生"),而非完全自动决策 [[../sources/optiguide-2023]]。

## 与其它概念的关系
- 上游能力:自然语言到优化建模 [[nl-to-optimization]]、求解器代码生成 [[solver-code-generation]]——人在回路在其产物之上加一层校验与解释。
- 下游应用:what-if 解释 [[what-if-explanation]]、供应链场景 [[supply-chain-llm]]。
- 对比:多智能体 OR [[multi-agent-or]] 与 LLM 智能体 [[llm-or-agents]] 追求更高自动化;人在回路则以可靠性换自动化,safeguard agent 是二者之间的折中(参见自我调试 [[self-debugging]] 的自动纠错与之互补)。

## 开放问题 / 矛盾
- 可靠性权衡:人机协作相对全自动 agent,牺牲了端到端自动化以换取可控性,但人工把关的吞吐与延迟代价缺乏量化(原笔记未记录准确率/延迟数字,建议回原文确认)[[../sources/optiguide-2023]]。
- safeguard 的覆盖边界:静态/执行前检查能拦截多少类危险操作仍不明确,过度依赖人审或导致"橡皮图章"式签字。

## 来源
- [[../sources/optiguide-2023]]
