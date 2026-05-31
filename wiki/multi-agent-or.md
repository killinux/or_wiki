---
title: 多智能体 OR 建模(Chain-of-Experts 等)
type: note
tags: [multi-agent, chain-of-experts, conductor, role-specialization]
updated: 2026-05-30
sources: [sources/chain-of-experts-2024.md, sources/optiguide-2023.md, sources/complexor-2024.md]
---

# 多智能体 OR 建模(Chain-of-Experts 等)

> 用多个**角色化(role-specialized)**的 LLM agent 分工协作来把自然语言优化问题建模、写代码、校验、解释,由一个 conductor(指挥)调度它们,而不是让单个 LLM 一口气完成全部。

## 核心要点
- **角色化专家 + conductor 调度**:Chain-of-Experts(CoE)把 OR 求解拆给一组各有专长的 expert agent(术语解释、建模、编程、代码审查等),初始化约 **11 个**角色化专家,由一个 **conductor** 动态决定每一步调用哪个专家([[../sources/chain-of-experts-2024]])。
- **前向构造 + 后向反思的协同**:conductor 用 **forward thought construction + backward reflection** 机制驱动——前向让专家链逐步构造解,后向在检测到错误时回溯、反思并修正此前步骤,形成自纠错回路([[../sources/chain-of-experts-2024]])。
- **多 agent 相对单 LLM 的收益**:在 **LPWP(NL4Opt)** 上 CoE 达到 **58.9%**,比 **Reflexion** agent 高约 **8.2 个百分点**;换用 GPT-4 时相对基线在 LPWP 上 +8.3%、在 ComplexOR 上 +5.5%([[../sources/chain-of-experts-2024]])。
- **复杂问题仍是硬骨头**:在更难的 **ComplexOR**(规模较小、约 18~20 道精选难题,以 execution accuracy 评测)上,即便是配套提出的 CoE,正确率也明显低于 LPWP,说明多智能体提升明显但复杂 OR 自动建模远未饱和([[../sources/complexor-2024]])。
- **OptiGuide 的三类 agent 分工**:面向供应链 what-if 解释,OptiGuide 用 **coder**(把 what-if 问题改写成对原模型/代码的扰动 code perturbation)、**safeguard**(执行前做安全检查)、**interpreter**(把求解结果翻成自然语言解释)三类 agent 协作;组合优化仍交给真实求解器,保最优性并避免泄露专有数据([[../sources/optiguide-2023]])。
- **收益与开销的权衡**:多智能体提升了复杂问题的建模成功率与可纠错性,但带来更多调用次数、token 开销与编排复杂度;简单问题单 LLM 往往已够。

## 与其它概念的关系
- 上游能力:[[nl-to-optimization]]——多智能体是实现 NL → 优化建模的一种编排范式。
- 下游/被复用子步骤:[[constraint-extraction]]、[[objective-inference]]、[[solver-code-generation]] 常被拆给不同角色专家承担。
- 协同闭环:[[self-debugging]]——后向反思与 OptiGuide 的 coder→safeguard 回路本质上是多 agent 形态的运行/纠错闭环。
- 应用对比:[[what-if-explanation]](OptiGuide 的 interpreter 即服务于此)、[[supply-chain-llm]](OptiGuide 的落地域)。
- 上位/相邻概念:[[llm-or-agents]](agent 化求解的总框架,多智能体是其一类)。
- 评测基准:[[complexor-benchmark]](CoE 在 ComplexOR 上评测复杂 OR 建模)。

## 开放问题 / 矛盾
- **角色数量与收益的边际关系**:11 个专家是否都必要、是否存在冗余角色,论文未充分消融;更多 agent 不一定线性提升正确率,却必然抬高开销。
- **何时该用多智能体**:对简单线性规划,[[nl-to-optimization]] 中单 agent + 结构化表示已较稳;多智能体的优势主要体现在复杂、约束多的问题上,而在 ComplexOR 这类难基准上正确率仍偏低,边界需更多 benchmark 佐证。
- **安全 vs 能力**:OptiGuide 的 safeguard 要拦截危险/越权代码,但过严会牺牲 coder 的表达能力,二者平衡尚无统一标准。

## 来源
- [[../sources/chain-of-experts-2024]]
- [[../sources/optiguide-2023]]
- [[../sources/complexor-2024]]
