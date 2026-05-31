---
title: "OptiMUS-0.3：用大语言模型大规模建模与求解优化问题 (Using Large Language Models to Model and Solve Optimization Problems at Scale)"
type: source
authors: Ali AhmadiTeshnizi, Wenzhi Gao, Herman Brunborg, Shayan Talaei, Connor Lawless, Madeleine Udell
year: 2024
url: https://arxiv.org/abs/2407.19633
added: 2026-05-30
tags: [source]
---

# OptiMUS-0.3：用大语言模型大规模建模与求解优化问题

> 一句话：OptiMUS 第三代,在模块化建模 agent 之上加入 RAG(Retrieval-Augmented Generation)与错误纠正,并引入更长更难的扩展版 NLP4LP 基准,把"自然语言 → 优化模型 → 求解代码"流水线的规模与鲁棒性又推进一步;值得收为 nl-to-optimization 与 OR-agent 方向的关键参考。

## 关键内容

- **新增 RAG 与错误纠正**:相比 v1/v2,0.3 版引入 Retrieval-Augmented Generation 检索相关示例信息,并加入对生成解与求解代码的评估、调试、自我修正闭环(develop model → write/debug solver code → evaluate → improve)。
- **结果数字**:论文报告 OptiMUS 在 easy 数据集上超过 SOTA **22% 以上**,在 hard 数据集上超过 **24% 以上**(原文:"outperforms existing state-of-the-art methods on easy datasets by more than 22% and on hard datasets ... by more than 24%")。
- **扩展版 NLP4LP 基准**:引入含更长、更复杂问题的新数据集 NLP4LP(long and complex problems),用于压力测试规模化能力;论文表格中报告的规模约为 **344 个问题**(easy 子集约 287 + hard 子集约 67;源信息另记作约 355,以论文为准)。
- **connection graph 模块化**:用 connection graph 表示变量/约束/目标之间的关系,**独立处理每一条约束与目标**,从而避免把整个问题塞进一个超长 prompt,使系统能在不超出 context 限制的情况下处理长描述、复杂数据的问题。
- **出处与作者**:来自 Stanford 的 Madeleine Udell 组;arXiv:2407.19633 [cs.AI](2024 年 7 月);HTML 版见 arxiv.org/html/2407.19633v1。

## LLM 提炼出的去向(摘入了哪些 wiki 词条)

- [[nl-to-optimization]]
- [[retrieval-augmented-or]]
- [[solver-code-generation]]
- [[llm-or-agents]]
- [[nlp4lp-benchmark]]
