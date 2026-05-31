---
title: 供应链优化中的 LLM 应用
type: note
tags: [supply-chain, optiguide, microsoft, applied-or]
updated: 2026-05-30
sources: [sources/optiguide-2023.md]
---
# 供应链优化中的 LLM 应用
> 在供应链规划场景中,用 LLM 把规划者的自然语言 what-if 提问翻译成对既有优化求解器的修改与查询,并把求解结果解释回自然语言,而非用 LLM 取代求解器本身。

## 核心要点
- 真实部署:论文把 OptiGuide 部署到微软 Azure 云供应链的 server placement 优化场景(原文「we deploy OptiGuide for the server deployment optimization used in Microsoft Azure's supply chain」),帮助规划者就既有优化模型提出 what-if 问题并获得可解释的回答;微软研究院项目页进一步称其「已用于生产(used in production)」回答云供应链规划者的 what-if 提问(原论文 2307.03875 措辞为 deploy + 规划者反馈积极,「生产」一词主要见于项目页)(据 [[../sources/optiguide-2023]])。
- 耦合而非替代:LLM 不直接求解,而是充当既有求解器之上的接口——把自然语言问题转写为对模型/求解代码的改动,触发求解器重算,再将结果翻译回自然语言(据 [[../sources/optiguide-2023]])。
- 评测基准:论文还构建了一个用于评估此类问答系统回答准确性的通用基准(evaluation benchmark),覆盖多场景的 what-if 提问(据 [[../sources/optiguide-2023]])。
- 开源与生态:OptiGuide 以 `microsoft/OptiGuide` 开源;其多智能体(coder/safeguard/interpreter)版本在 AutoGen 中有官方重实现(nested chat),故常被归入 AutoGen 生态(注:原论文 2307.03875 早于 AutoGen,未提及 AutoGen)(据 [[../sources/optiguide-2023]])。
- 工业约束:由于面向生产规划数据,落地时强调隐私与可靠性——LLM 接触的是模型结构与查询而非直接改写敏感业务决策,输出需可核验(据 [[../sources/optiguide-2023]])。

## 与其它概念的关系
- 对比:[[what-if-explanation]] 是本词条的核心机制(把求解结果与情景变更解释给人),OptiGuide 是其代表性应用,二者紧密互为上下游。
- 上游/支撑:[[solver-code-generation]]——OptiGuide 通过生成/修改求解器代码来实现 what-if 重算,依赖代码生成能力。
- 下游/校验:[[human-in-the-loop-or]]——规划者作为回路中的人对 LLM 给出的解释与改动进行判断与采纳,符合「人在回路」范式。
- 相关范式:[[multi-agent-or]] / [[llm-or-agents]]——OptiGuide 隶属 AutoGen 多智能体框架,可视为多智能体 OR 在供应链上的落地。
- 相关:[[nl-to-optimization]]——同属「自然语言驱动优化」家族,但侧重对既有模型的 what-if 查询而非从零形式化。

## 开放问题 / 矛盾
- 回答准确性的保证:LLM 转写的查询/代码可能误解业务语义,需基准评测与人工校验([[human-in-the-loop-or]])共同兜底。
- 生产环境的隐私与可靠性边界尚不清晰:在多大程度上可让 LLM 触达真实供应链数据与决策逻辑,仍是开放的工程与治理问题。

## 来源
- [[../sources/optiguide-2023]]
