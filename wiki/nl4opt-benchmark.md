---
title: NL4Opt / LPWP 基准
type: note
tags: [benchmark, nl4opt, lpwp, ner, linear-programming]
updated: 2026-05-30
sources: [sources/nl4opt-2022.md]
---

# NL4Opt / LPWP 基准

> NeurIPS 2022 的 NL4Opt 竞赛及其配套 LPWP 数据集——首个面向「线性规划(LP)词题 → 形式化」的标注基准,把自然语言描述映射为可求解的 LP 模型。

## 核心要点
- LPWP(Linear Programming Word Problems)是 NL4Opt 竞赛的数据集,首次系统标注 LP 词题,用于把一段文字描述转成 canonical 的 LP 形式 [[../sources/nl4opt-2022]]。
- 数据集共含 **1101** 个标注 LP 词题,按 **713 / 99 / 289** 切分为 train / dev / test,测试集为 289 [[../sources/nl4opt-2022]]。
- 竞赛设两个子任务:**子任务 1 = 组件 NER**(识别目标、决策变量、约束、参数等语义实体);**子任务 2 = canonical 形式化生成**(由文本与实体标注产出 LP 的标准中间表示) [[../sources/nl4opt-2022]]。
- 竞赛总奖金 **22000 美元**,两个任务均分;领先方案在子任务 1 上的 F1 约 **0.93** [[../sources/nl4opt-2022]]。
- 域切分以测泛化:source 域(如 advertising / investment / sales)在各划分中均出现(含训练),target 域 **production / transportation / sciences** 被刻意留到 dev/test,考察对未见领域的迁移能力 [[../sources/nl4opt-2022]]。
- 作为该方向首个公开标注基准,NL4Opt/LPWP 成为后续「NL → 优化」工作的标准起点与对比锚点 [[../sources/nl4opt-2022]]。

## 与其它概念的关系
- 评测对象(上游任务):[[nl-to-optimization]] —— LPWP 正是衡量「自然语言 → 优化建模」这一整体范式的基准。
- 子任务对应:子任务 1 的组件 NER 直接对应 [[constraint-extraction]] 与 [[objective-inference]];子任务 2 的形式化生成与 [[solver-code-generation]] 相邻(canonical 形式是通往求解器代码的中间表示)。
- 同类对比(后续/更难基准):[[nlp4lp-benchmark]]、[[complexor-benchmark]] —— 均在 NL4Opt 之后扩展规模或难度;更晚的 [[mamo-benchmark]]、[[optibench-benchmark]] 进一步覆盖非线性/复杂场景。
- 评测方法论:[[process-evaluation-or]] —— NL4Opt 用 NER F1 与形式化精确度做结果评估,后续工作转向过程级评估。

## 开放问题 / 矛盾
- canonical 形式化的「正确」如何判定?基于标注的形式匹配可能对等价但写法不同的模型给出假阴性,需结合求解结果或 [[human-in-the-loop-or]] 校验。
- 域泛化的边界有限:source/target 仅覆盖少数线性场景,F1 约 0.93 的成绩未必迁移到真实工业问题,后续基准(如 [[industryor-benchmark]])正是为补这一缺口而生。
- LPWP 仅限 LP(线性),不覆盖整数/非线性建模,因此不能作为 [[nonlinear-optimization-llm]] 能力的衡量标准。

## 来源
- [[../sources/nl4opt-2022]]
