---
title: IndustryOR 工业基准
type: note
tags: [benchmark, industryor, industrial-or, orlm]
updated: 2026-05-30
sources: [sources/orlm-2024.md]
---
# IndustryOR 工业基准
> IndustryOR 是首个面向真实工业场景的运筹优化(OR)基准,收集多行业、多题型、多难度的真实业务问题,用于评测 LLM 把自然语言问题转化为可求解优化模型的能力。

## 核心要点
- 定位:首个工业 OR 基准,问题取自真实多行业业务场景,而非教材式的合成习题,因此更贴近实践 [[../sources/orlm-2024]]。
- 覆盖面:约 100 个真实问题,横跨 5 种题型(线性规划、整数规划、混合整数规划、非线性规划、其它)与 3 个难度等级(易/中/难),刻画了工业建模任务的多样性;问题取自多个行业(论文/解读中常述为约 13 个行业,亦有来源称 8 个,具体数目口径不一,所引来源未列明) [[../sources/orlm-2024]]。
- 发布方式:随 ORLM 框架一同发布,作为衡量自动优化建模能力的配套测试集 [[../sources/orlm-2024]]。
- 评测指标:以执行准确率(execution accuracy)为准——抽取并运行模型生成的求解程序,将执行得到的最优值与参考最优值比对,而非仅看文本相似度(指标细节见 ORLM 官方仓库;所引来源页本身未列明指标名称) [[../sources/orlm-2024]]。
- SOTA 结果:在 OR-Instruct 合成数据上训练的最佳 ORLM(基于 LLaMA-3-8B)在 IndustryOR 上达到 SOTA,并在 NL4Opt、MAMO 等基准上同时取得 SOTA [[../sources/orlm-2024]]。

## 与其它概念的关系
- 上游/任务:评测的是 [[nl-to-optimization]] 这一核心任务的端到端表现。
- 上游/被评模型:主要服务于 [[open-source-or-models]] 的能力评估;模型训练数据来自 [[or-data-synthesis]](OR-Instruct 流程)。
- 对比/同类基准:与 [[mamo-benchmark]]、[[nl4opt-benchmark]] 互补——后两者偏学术/教材题,IndustryOR 强调真实工业场景与更高难度;也可与 [[complexor-benchmark]]、[[optibench-benchmark]] 对照其难度与覆盖面。
- 相关技术:被评流程通常涉及 [[solver-code-generation]] 与 [[self-debugging]],其正确性直接反映在执行准确率上。

## 开放问题 / 矛盾
- 规模有限:约 100 题虽贴近真实,但样本量较小,单题难度差异大,可能导致准确率波动与统计显著性存疑。
- 评测口径:执行准确率依赖参考最优值与求解器配置(官方实现目前主要支持 COPT 求解器);同一问题可能存在多个等价最优建模,如何判定"正确"仍有解释空间,可能需要 [[process-evaluation-or]] 式的过程评估补充。

## 来源
- [[../sources/orlm-2024]]
