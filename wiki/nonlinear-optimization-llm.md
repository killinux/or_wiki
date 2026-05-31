---
title: LLM 与非线性优化建模
type: note
tags: [nonlinear-programming, nlp, optibench, tabular]
updated: 2026-05-30
sources: [sources/resocratic-optibench-2025.md, sources/optmath-2025.md]
---
# LLM 与非线性优化建模

> 把 LLM 的"自然语言 → 优化建模"能力,从 LP/MILP 扩展到非线性规划(NLP/SOCP 等)与含表格数据(tabular data)的问题,并研究其评测难度。

## 核心要点
- 范围扩展:早期 NL→优化 评测多聚焦线性规划(LP)与混合整数线性规划(MILP);非线性约束/目标(NLP、SOCP 等)与"表格数据"输入是更难、更贴近实务的设定,也是近期基准的扩展方向。
- OptiBench 覆盖线性/非线性并含表格数据:基准包含 605 个经人工校验(human-verified)的优化问题,覆盖线性/非线性、含/不含表格数据四类组合,变量类型涵盖连续、整数(IP)与混合整数(MIP);采用端到端评测——要求 LLM 调用代码求解器(code solver)给出精确数值答案,而非只评中间形式化(据 [[../sources/resocratic-optibench-2025]])。
- OptMATH-Bench 覆盖多类问题:166 个高难度问题的评测集,题目类别覆盖 LP / MILP / IP / NLP / SOCP(即同时含线性、整数与非线性/二阶锥范畴),且自然语言上下文比同类基准长约 2.9 倍(据 [[../sources/optmath-2025]])。
- 难度信号:非线性与表格类问题显著拉低端到端建模/求解准确率——相较纯线性文字题,模型在变量类型判定、非线性约束表达、以及从表格抽取并对齐数据等环节更易出错;OptiBench 即以"覆盖非线性与表格"作为其相较早期 LP/MILP 基准更难的核心卖点(据 [[../sources/resocratic-optibench-2025]])。
- 评测口径:端到端"代码可执行 + 数值正确"比"公式匹配"更严格,能暴露建模到求解全链路的失败,而非单点正确(可与 [[process-evaluation-or]] 的过程级评测对照)。

## 与其它概念的关系
- 上游/母任务:[[nl-to-optimization]](本词条是其在非线性/表格维度上的延伸)。
- 子步骤:[[constraint-extraction]](非线性约束的抽取更难)、[[objective-inference]]、[[solver-code-generation]](需生成支持非线性/锥规划的求解器代码)。
- 评测(并列基准):[[optibench-benchmark]]、[[optmath-benchmark]];对比线性为主的 [[nl4opt-benchmark]]、[[mamo-benchmark]]、[[complexor-benchmark]]、[[industryor-benchmark]]。
- 相关方法:[[self-debugging]](靠运行结果迭代修正非线性代码)、[[or-data-synthesis]](OptiBench/OptMATH 均配套合成数据以扩充含非线性/表格的训练样本)。

## 开放问题 / 矛盾
- 非线性问题的"正确建模"难以仅凭最终数值判定:不同非线性表述可能得到相同(或不同)最优值,端到端数值评测可能掩盖建模错误,需结合 [[process-evaluation-or]] 或 [[human-in-the-loop-or]] 校验。
- 表格数据对齐是独立失败源:数据抽取错误与建模错误在端到端口径下被混在一起,难以归因(参见 [[failure-modes-hallucination]])。
- 强度待量化:两源均强调"覆盖非线性/表格"使基准更难,但本词条未给出"非线性 vs 线性"分项准确率的精确差值;此类细分数据有待补齐。

## 来源
- [[../sources/resocratic-optibench-2025]]
- [[../sources/optmath-2025]]
