---
title: 面向 OR 的检索增强(RAG in OptiMUS-0.3)
type: note
tags: [rag, retrieval, error-correction, scalability]
updated: 2026-05-30
sources: [sources/optimus-03-2024.md]
---

# 面向 OR 的检索增强(RAG in OptiMUS-0.3)

> 在 LLM 建模 agent 的求解流水线中,于查询时检索相关示例/知识(Retrieval-Augmented Generation)并配合错误纠正闭环,以提升对长、复杂优化问题的规模化与鲁棒性。

## 核心要点

- OptiMUS-0.3 在模块化建模 agent 之上加入 RAG 与错误纠正:相比 v1/v2,0.3 版引入 Retrieval-Augmented Generation 检索相关示例信息,并对生成解与求解代码加入评估、调试、自我修正闭环(develop model → write/debug solver code → evaluate → improve)([[../sources/optimus-03-2024]])。
- RAG 与错误纠正的组合用于把"自然语言 → 优化模型 → 求解代码"流水线的规模与鲁棒性又推进一步([[../sources/optimus-03-2024]])。
- 结果数字:论文报告 OptiMUS 在 easy 数据集上超过 SOTA 22% 以上、在 hard 数据集上超过 24% 以上(原文:"outperforms existing state-of-the-art methods on easy datasets by more than 22% and on hard datasets ... by more than 24%")([[../sources/optimus-03-2024]])。
- 规模化承载来自 connection graph 模块化:用 connection graph 表示变量/约束/目标之间的关系,独立处理每一条约束与目标,避免把整个问题塞进一个超长 prompt,使系统在不超出 context 限制下处理长描述、复杂数据问题;检索因此只需按需注入相关片段,而非全量上下文([[../sources/optimus-03-2024]])。
- 评测载体是扩展版 NLP4LP:引入含更长、更复杂问题的新数据集,用于压力测试规模化能力([[../sources/optimus-03-2024]])。
- 与 Karpathy 风格"知识沉淀"的对比:本知识库属于离线、人/LLM 预先编纂并互链的静态 wiki;而 OR 的 RAG 是查询时(query-time)按当前问题动态检索相关示例的特例——同为"复用既有知识",但前者沉淀于写入时、后者注入于推理时。

## 与其它概念的关系

- 上游/母概念:[[nl-to-optimization]](RAG 是其求解闭环里的一个增强环节)。
- 紧密耦合:[[self-debugging]](错误纠正闭环——对求解代码评估、调试、自我修正);[[solver-code-generation]](被检索示例与纠错所服务的代码生成步骤)。
- 上游框架:[[llm-or-agents]](模块化 agent 是承载 RAG 的系统)、[[multi-agent-or]](多 agent 协作下的检索与纠错分工)。
- 评测:[[nlp4lp-benchmark]](扩展版 NLP4LP 是其规模化能力的压力测试基准)。
- 对比:[[failure-modes-hallucination]](RAG/纠错旨在缓解的失败模式,如错误形式化、幻觉式约束)。

## 开放问题 / 矛盾

- 检索质量与示例库覆盖度如何影响最终建模正确性?源未给出检索消融,RAG 贡献与错误纠正贡献的拆分尚不清晰。
- 规模数字存在记法差异且未独立核实:源记录扩展版 NLP4LP 规模"约 344 个问题,另记作约 355,以论文为准"。源中另给出的 easy/hard 拆分(约 287 / 约 67)既未被独立来源证实,且 287+67=354 与 344/355 均不自洽,故此处不采纳具体拆分数字、亦不固定单一总数以免编造(底本为 arXiv:2407.19633,OptiMUS-0.3)([[../sources/optimus-03-2024]])。

## 来源

- [[../sources/optimus-03-2024]]
