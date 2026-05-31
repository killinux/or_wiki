---
title: OR × LLM 综述与领域地图
type: note
tags: [survey, taxonomy, roadmap, moc]
updated: 2026-05-30
sources: [sources/opt-modeling-meets-llms-survey-2025.md, sources/ec-era-llm-survey-2024.md]
---

# OR × LLM 综述与领域地图

> 把「运筹学 × LLM」整片研究领域按全栈分层、梳理基准与评测质量,并兼收演化计算(EC)× LLM 的双向关系,作为本 wiki 的领域地图(map of content)入口。

## 核心要点
- 全栈分类:综述把领域组织为一个 **full stack**——(1) 数据合成与微调(data synthesis / fine-tuning)、(2) 推理框架(inference,含单 LLM 与多智能体)、(3) 基准(benchmarks)、(4) 评测(evaluation)四大块(据 [[../sources/opt-modeling-meets-llms-survey-2025]])。
- 基准质量审计:综述审计了 NL4Opt、MAMO、ComplexOR、IndustryOR、NLP4LP 等常用基准,发现其中数个存在 **意外偏高的标签错误率(label-error rate)**,并据此 **发布了清洗 / 重标注数据集与重新评分后的新排行榜**(据 [[../sources/opt-modeling-meets-llms-survey-2025]])。
- 评测主张:综述论证评测应以 **execution-based**(生成模型/求解结果是否匹配参考最优值)为准,而非文本相似度(据 [[../sources/opt-modeling-meets-llms-survey-2025]])。
- 内部视角分类法:该全栈综述作者与 **Chain-of-Experts** 一脉工作的人员有重叠,因此提供的是一份 insider taxonomy(据 [[../sources/opt-modeling-meets-llms-survey-2025]])。
- EC × LLM 双向关系:演化计算综述给出两条方向——**LLM-enhanced EA**(LLM 充当变异/交叉等搜索算子、初始化、fitness 建模或生成/演化代码与启发式)与 **EA-enhanced LLM**(用演化搜索做 prompt 优化、神经架构搜索、模型合并等 LLM 自我改进环路)(据 [[../sources/ec-era-llm-survey-2024]])。
- EC × LLM 开放挑战:演化计算综述指出 benchmarking、可扩展性、理论理解,以及演化环路内 **LLM 调用成本** 等仍是开放难题(据 [[../sources/ec-era-llm-survey-2024]])。

## 与其它概念的关系
- 作为领域地图(下游入口指向):建模主线 [[nl-to-optimization]]、子步骤 [[constraint-extraction]] / [[objective-inference]] / [[solver-code-generation]] / [[self-debugging]]。
- 评测与基准(下游):评测方法学 [[process-evaluation-or]]、失败模式 [[failure-modes-hallucination]];被审计基准 [[nl4opt-benchmark]]、[[mamo-benchmark]]、[[complexor-benchmark]]、[[industryor-benchmark]]、[[nlp4lp-benchmark]],以及其它 [[optibench-benchmark]] / [[optmath-benchmark]] / [[orqa-benchmark]]。
- 训练与数据(下游):[[or-data-synthesis]]、[[instruction-tuning-or]]、[[open-source-or-models]]。
- 智能体范式(下游):[[multi-agent-or]]、[[llm-or-agents]]、[[retrieval-augmented-or]]、[[human-in-the-loop-or]]。
- EC × LLM 分支(下游):[[llm-as-optimizer]]、[[heuristic-evolution]]、[[combinatorial-opt-llm]]、[[prompt-optimization-evo]]。
- 对比:本词条是 **综述/地图(MOC)**,而 [[nl-to-optimization]] 是具体方法主线、[[llm-as-optimizer]] 是另一条「LLM 直接当优化器」的路线;二者均为本地图所收纳的分支。

## 开放问题 / 矛盾
- 基准可信度:若主流基准本身存在偏高标签错误率,则历史排行榜的横向比较可能失真,需要以清洗后数据集与 execution-based 评测重新校准(据 [[../sources/opt-modeling-meets-llms-survey-2025]])。
- 内部视角的潜在偏倚:综述分类法源自与 Chain-of-Experts 重叠的团队,作为 insider taxonomy 既提供深度也可能带入路线偏好,引用时宜对照外部视角(据 [[../sources/opt-modeling-meets-llms-survey-2025]])。
- 成本与可扩展性:EC × LLM 把 LLM 嵌入演化环路会放大调用成本,与「评测应可复现、可规模化」存在张力,理论理解亦不足(据 [[../sources/ec-era-llm-survey-2024]])。

## 来源
- [[../sources/opt-modeling-meets-llms-survey-2025]]
- [[../sources/ec-era-llm-survey-2024]]
