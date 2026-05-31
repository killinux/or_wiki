---
title: 求解器代码生成与工具调用
type: note
tags: [solver-code-generation, tool-use, gurobi, copt, code-generation]
updated: 2026-05-30
sources: [sources/optimus-2024.md, sources/optimus-03-2024.md, sources/optiguide-2023.md, sources/orlm-2024.md, sources/mamo-2024.md]
---
# 求解器代码生成与工具调用

> 把形式化的优化模型翻译为可执行的求解器代码(Gurobi/COPT/.lp),由外部求解器实际求解,LLM 借执行反馈迭代,从而以求解器保证最优性。

## 核心要点

- 把形式化模型翻译为可执行求解器代码,是 NL→优化流水线的下游一环:OptiMUS 的工作流为 formulate → generate solver code → debug → evaluate,强调与真实求解器(Gurobi 等)对接以保证可行性/最优性(据 [[../sources/optimus-2024]])。
- 工具调用模式(tool-use):LLM 不替代求解器,而是把用户问题翻译成对优化模型的查询/扰动,让真实求解器去求解、保证最优性,LLM 只负责自然语言接口与解释——OptiGuide 即此设计(据 [[../sources/optiguide-2023]])。
- 输出格式 .lp:MAMO 要求用 .lp 形式或等价模型表达,交由求解器(如 COPT)求解并比对最优值,评测重点是「建模是否正确可解」而非文本相似度(据 [[../sources/mamo-2024]])。
- 执行反馈闭环:OptiMUS 自动生成并运行求解器代码,据执行结果做自检/调试并迭代,直至通过测试(据 [[../sources/optimus-2024]],OptiMUS-0.3 进一步「自动生成并调试求解器代码,迭代直至通过测试」据 [[../sources/optimus-03-2024]])。
- 典型工具调用流程:问题 → 代码/数据改写(扰动脚本)→ 重新求解 → 用自然语言解释差异,答案基于求解器结果而非 LLM 臆测(据 [[../sources/optiguide-2023]])。
- 代码生成可纳入训练目标:ORLM 对开源 LLM 做「建模 + 代码生成(求解器脚本)联合训练」,而非仅靠 prompt(据 [[../sources/orlm-2024]])。

## 与其它概念的关系

- 上游:[[nl-to-optimization]](本词条是其「写并运行求解器代码」的执行环节);更细粒度的上游子步骤见 [[constraint-extraction]]、[[objective-inference]]。
- 下游/伴生:[[self-debugging]](据执行反馈修代码)、[[what-if-explanation]](OptiGuide 把求解器结果回译为自然语言解释)。
- 对比:[[llm-as-optimizer]](让 LLM 直接当优化器)与本词条(LLM 只生成代码、由外部求解器求最优)路线相反。
- 评测:[[mamo-benchmark]](用 .lp + COPT 比对最优值)、[[nlp4lp-benchmark]]。
- 相关方向:[[open-source-or-models]]、[[supply-chain-llm]](OptiGuide 的应用场景)、[[llm-or-agents]]。

## 开放问题 / 矛盾

- 安全检查(safeguard):LLM 生成并执行代码意味着任意代码执行风险,如何在保留迭代闭环的同时做沙箱/校验,源笔记未给出统一方案,是待解问题。
- 「保最优性」的边界:OptiGuide/MAMO 路线依赖外部求解器保证最优(据 [[../sources/optiguide-2023]]、[[../sources/mamo-2024]]),但前提是生成的模型/代码本身正确——错误的形式化仍可被「最优地」求解出错误答案,需 [[self-debugging]] 与 [[human-in-the-loop-or]] 兜底。

## 来源

- [[../sources/optimus-2024]]
- [[../sources/optimus-03-2024]]
- [[../sources/optiguide-2023]]
- [[../sources/orlm-2024]]
- [[../sources/mamo-2024]]
