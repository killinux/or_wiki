---
title: "OptiGuide:把 LLM 接到供应链求解器上,让非专家问 what-if(Large Language Models for Supply Chain Optimization, 2023)"
type: source
authors: Beibin Li, Konstantina Mellou, Bo Zhang, Jeevan Pathuri, Ishai Menache
year: 2023
url: https://arxiv.org/abs/2307.03875
added: 2026-05-30
tags: [source]
---

# OptiGuide:把 LLM 接到供应链求解器上,让非专家问 what-if

> 一句话:把 LLM 接在既有供应链优化求解器的自然语言接口层,让非专家用自然语言提 what-if 问题并得到可读解释,且不把专有数据交给 LLM——求解仍由真实求解器完成,保持最优性。

## 关键内容

- **问题**:运筹优化的解对非专家是黑箱——结果难懂、难信、难追问「如果改条件会怎样(what-if)」,而把专有数据喂给 LLM 又有隐私风险。
- **方法(多 agent)**:OptiGuide 框架以多个 LLM agent 分工——coder 把用户的 what-if 问题改写成对原模型/代码的扰动(code perturbation),safeguard 在执行前做安全检查,interpreter 把求解结果翻译成自然语言解释。
- **保持最优性**:组合优化仍交给真实求解器求解,LLM 只工作在自然语言接口层(改写问题、解释结果),不替代优化引擎,因此不损失解的最优性。
- **隐私保护**:只把模型/代码结构发送给 LLM,不发送专有数值数据(proprietary data),降低敏感信息泄露风险。
- **结果**:论文报告 in-distribution what-if 问答准确率 >90%。
- **落地与开源**:在微软 Azure 云供应链的 server placement 真实场景中部署;开源为 `microsoft/OptiGuide`,属于 AutoGen 多 agent 生态。

## LLM 提炼出的去向

- [[what-if-explanation]]
- [[human-in-the-loop-or]]
- [[supply-chain-llm]]
- [[solver-code-generation]]
- [[multi-agent-or]]
