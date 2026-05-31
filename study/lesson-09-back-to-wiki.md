---
title: 第 9 课:回到本 wiki —— LLM 怎么自动做运筹
tags: [study, or, llm, capstone]
updated: 2026-05-31
---

# 第 9 课(收官):回到本 wiki

承接 [[lesson-08-tools-pulp]]。你已经学完了运筹学的核心地基。现在终于能读懂本仓库
[[../maps/_home]] 里那 34 个 LLM×OR 前沿词条了 —— 它们做的,就是**让 LLM 自动完成你前 8 课手动做的每一步**。

## 你学的每个 OR 概念 → 对应的前沿词条

| 你学过(study) | 它对应的 wiki 词条 | LLM 在这里做什么 |
|----------------|-------------------|------------------|
| 建模五件套 [[lesson-01-linear-programming]] | [[../wiki/nl-to-optimization]] | 把人话题目自动转成数学模型 |
| 设决策变量 / 列约束 | [[../wiki/constraint-extraction]]、[[../wiki/objective-inference]] | 从文字里自动抽约束、定目标 |
| 把数据代进模型 | [[../wiki/data-grounding-parameterization]] | 把文字里的数值落成参数 |
| 写求解器代码 [[lesson-08-tools-pulp]] | [[../wiki/solver-code-generation]] | LLM 自动生成 Gurobi/PuLP 代码 |
| 调试改错 | [[../wiki/self-debugging]] | 读求解器报错,自动迭代修正 |
| 对偶 / 影子价格 [[lesson-03-duality]] | [[../wiki/what-if-explanation]] | 自动回答 what-if / 灵敏度问题 |
| 整数间隙 / optimality gap [[lesson-04-integer-programming]] | [[../wiki/or-evaluation-metrics]] | 用 gap、求解率等判定「做对没」 |
| 启发式 / 演化 [[lesson-07-nonlinear-heuristics]] | [[../wiki/heuristic-evolution]]、[[../wiki/combinatorial-opt-llm]] | LLM 当变异算子,进化启发式 |
| 黑箱优化 | [[../wiki/llm-as-optimizer]] | 把 LLM 直接当无梯度优化器 |

## 两条主线,别混淆

本 wiki 反复强调有**两条不同路线**(见 [[../wiki/nl-to-optimization]] 的对比):

1. **LLM 建模 + 交求解器**(主线):LLM 只负责「翻译成模型 + 写代码」,真正求解交给 Gurobi。
   优点:**求解器保证最优性**。你的第 1–8 课基本都服务于这条线。
2. **LLM 直接当优化器**:不写模型,让 LLM 自己在 in-context 里迭代猜更优解
   ([[../wiki/llm-as-optimizer]]、[[../wiki/heuristic-evolution]])。优点:适合无法形式化的问题;缺点:无最优性保证。

## 评测:怎么知道 LLM 做对了

你学过「最优解」「可行性」「optimality gap」,这些正是评测 LLM 的标尺:

- 端到端基准:[[../wiki/nl4opt-benchmark]]、[[../wiki/nlp4lp-benchmark]]、[[../wiki/industryor-benchmark]]、[[../wiki/complexor-benchmark]] ……
- 不只看答案、还查建模过程:[[../wiki/process-evaluation-or]]、[[../wiki/mamo-benchmark]]。
- 典型翻车方式:[[../wiki/failure-modes-hallucination]](漏约束、目标方向错、不可行)——
  这些错误你现在一眼能看出为什么是错的。
- 全景综述:[[../wiki/or-llm-survey]]。

## 学习闭环

```
study/(你手动学会 OR)  ──→  wiki/(看 LLM 自动做 OR)
   ↑                                    │
   └──── 看不懂某词条就回来补对应一课 ←──┘
```

## 收官的话

你从「什么是决策变量」一路走到「LLM 如何自动建模求解」。OR 的地基(LP→对偶→整数→网络→DP→非线性)
是不变的硬核;LLM 只是把「会用这套地基」的门槛降低。**先懂 OR,再懂 LLM×OR,顺序不能反** —— 这正是
本 study 课程相对直接读 wiki 的价值。

接下来可以:挑一个 wiki 词条精读 → 用 [[lesson-08-tools-pulp]] 的 PuLP 复现它的例子 → 在 `sources/`
放一篇新论文让 wiki 增量生长。

→ 路线图见 [[_roadmap]]。
