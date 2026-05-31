---
title: OptiBench 基准(含非线性/表格)
type: note
tags: [benchmark, optibench, nonlinear, tabular, end-to-end]
updated: 2026-05-30
sources: [sources/resocratic-optibench-2025.md]
---

# OptiBench 基准(含非线性/表格)

> 一个端到端的优化建模评测基准:给定自然语言问题,模型需建模并调用求解器返回精确数值答案,覆盖线性/非线性与含/不含表格数据的题型。

## 核心要点

- 规模与构成:OptiBench 含 605 个经人工校验的问题,题型覆盖线性/非线性以及表格数据(tabular)场景 [[../sources/resocratic-optibench-2025]]。
- 评测方式:端到端任务——模型须从自然语言出发完成建模、生成并执行求解器代码,最终返回精确数值答案,而非仅产出中间表示 [[../sources/resocratic-optibench-2025]]。
- 答案验证:基于代码执行后的最优值(optimal value)比对来判定正确性,而非靠文本匹配 [[../sources/resocratic-optibench-2025]]。
- 基线表现:GPT-4 在 few-shot 设置下于 OptiBench 上约达 65.5% 的准确率 [[../sources/resocratic-optibench-2025]]。
- 配套数据合成:OptiBench 与反向合成法 ReSocratic 配套提出,后者用于反向生成训练数据以提升小/开源模型在该类任务上的表现 [[../sources/resocratic-optibench-2025]]。
- 定位:作为 2024–2025 期间的 OR × LLM 评测套件之一,补充了线性之外的非线性与表格数据维度 [[../sources/resocratic-optibench-2025]]。

## 与其它概念的关系

- 评测对象(上游能力):[[nl-to-optimization]] —— OptiBench 直接度量"自然语言 → 优化建模 → 求解"的端到端能力。
- 强调环节:[[solver-code-generation]](须生成可执行求解器代码)与 [[self-debugging]](执行失败时的修正);其正确性最终由代码执行决定。
- 专题维度:[[nonlinear-optimization-llm]] —— OptiBench 是少数显式覆盖非线性问题的基准,是该专题的关键评测载体。
- 配套/上游数据:[[or-data-synthesis]] —— ReSocratic 反向合成法与本基准配套,为训练数据生成提供方法。
- 受益模型:[[open-source-or-models]] —— 该基准与配套合成数据常用于评估并改进开源 OR 模型。
- 同类对比(其它评测套件):[[nl4opt-benchmark]]、[[mamo-benchmark]]、[[complexor-benchmark]]、[[industryor-benchmark]]、[[optmath-benchmark]];OptiBench 的差异在于端到端数值答案 + 非线性/表格覆盖。
- 评测方法学:[[process-evaluation-or]] —— OptiBench 侧重结果(最优值)验证,可与过程/步骤级评测互为补充对照。

## 开放问题 / 矛盾

- 结果级 vs 过程级:OptiBench 以"最优值比对"为正确性标准,无法区分"答案对但建模错"(如约束遗漏却恰好同解)与"建模正确";这与 [[process-evaluation-or]] 强调的过程评测存在张力。
- 数据泄漏与可比性:few-shot 基线(如 GPT-4 约 65.5%)对示例选择与提示工程敏感,跨论文报告的数字未必同口径,直接横向比较需谨慎。
- 覆盖广度:尽管纳入非线性与表格题型,605 题相对真实工业优化问题的多样性仍有限,泛化能力存疑(参见 [[industryor-benchmark]] 的工业场景视角)。

## 来源

- [[../sources/resocratic-optibench-2025]]
