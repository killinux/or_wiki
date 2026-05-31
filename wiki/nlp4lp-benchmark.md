---
title: NLP4LP 基准(端到端建模+求解)
type: note
tags: [benchmark, nlp4lp, milp, execution-accuracy]
updated: 2026-05-30
sources: [sources/nlp4lp-2024.md, sources/optimus-2024.md, sources/optimus-03-2024.md]
---
# NLP4LP 基准(端到端建模+求解)

> 随 OptiMUS 提出的优化建模基准:给定自然语言描述,要求系统端到端地完成「建模 + 写求解器代码 + 求解」,并以执行后是否给出正确最优目标值作为评测口径。

## 核心要点
- 随 OptiMUS 引入,定位为**端到端**评测——不只看建模/形式化文本,而要把问题一路做到求解器跑出结果(据 [[../sources/optimus-2024]]、[[../sources/nlp4lp-2024]])。
- 初版 NLP4LP 含 **67 个实例(54 LP + 13 MILP)**,每个实例配有专家形式化、参考解,以及用于**校验最优性的代码**,使评测可自动判定对错(据 [[../sources/nlp4lp-2024]])。
- 评测口径为 **solve / execution 准确率**:只有当生成的优化代码能成功执行**且**给出正确的最优目标值时,该实例才算「解出」——而非只看是否产出形式化标注(据 [[../sources/nlp4lp-2024]])。
- 扩展版随 OptiMUS-0.3 引入更长、更复杂的问题,分为 easy(仅含 LP、短描述、标量参数)与 hard(含 LP + MILP、更长描述、多维参数)两档;规模口径不一:OptiMUS-0.3 论文报告约 **344 个问题**,另有来源记作约 **355 个**(据 [[../sources/optimus-03-2024]]、[[../sources/nlp4lp-2024]])。扩展版刻意以**更长描述 + 数据文件**贴近真实建模并降低数据泄漏(据 [[../sources/nlp4lp-2024]])。
- 部分综述在做标准化切分后引用的实例数约为 **269 个**——不同文献的实例数因版本与切分口径而异(据 [[../sources/nlp4lp-2024]])。
- 题面覆盖设施选址、网络流、调度、组合投资、能源等多类应用;数据集以 CC BY-NC 4.0 发布,托管于 GitHub 与 Hugging Face(据 [[../sources/nlp4lp-2024]])。

## 与其它概念的关系
- 上游 / 被评测对象:[[nl-to-optimization]]——本基准正是用于评测「NL → 优化」的端到端能力。
- 下游子能力:解出最优值依赖 [[solver-code-generation]](生成可执行的求解器代码),并常配合 [[self-debugging]] 迭代修错;OptiMUS-0.3 还引入 [[retrieval-augmented-or]] 提升规模化表现。
- 对比基准:[[nl4opt-benchmark]](偏抽取/形式化标注)、[[complexor-benchmark]]、[[mamo-benchmark]]、[[industryor-benchmark]]、[[optibench-benchmark]];NLP4LP 更强调「执行到正确数值」的端到端口径。
- 评测方法学对比:[[process-evaluation-or]](过程/分步评测)——NLP4LP 以最终最优值为准,属结果导向。

## 开放问题 / 矛盾
- 实例数说法不一:初版 **67**、扩展版(OptiMUS-0.3 论文表格)**约 344**(亦有来源记作约 355)、部分综述切分后**约 269**,引用时须标明版本与切分口径,避免混用。
- 仅以「执行后正确最优目标值」判定,可能掩盖建模过程错误(碰巧值对)或多最优解 / 数值容差带来的判定边界问题;过程级正确性可参 [[process-evaluation-or]]。

## 来源
- [[../sources/nlp4lp-2024]]
- [[../sources/optimus-2024]]
- [[../sources/optimus-03-2024]]
