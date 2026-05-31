---
title: "ComplexOR:复杂运筹学问题基准(随 Chain-of-Experts 发布) (ComplexOR)"
type: source
authors: "Ziyang Xiao, Dongxiang Zhang, Yangjun Wu, Lilin Xu, Yuan Jessica Wang, Xiongwei Han, Xiaojin Fu, Tao Zhong, Jia Zeng, Mingli Song, Gang Chen"
year: 2024
url: https://openreview.net/forum?id=HobyL1B9CZ
added: 2026-05-30
tags: [source]
---

# ComplexOR:复杂运筹学问题基准(随 Chain-of-Experts 发布)

> 一句话:一个刻意比 NL4Opt 更难的复杂 OR 基准,由三位 OR 专家从论文/教材/工业场景挑选,用最终求解最优值的正确性(execution accuracy)评测;随多智能体框架 Chain-of-Experts(ICLR 2024)一同发布。

## 关键内容
- 提出 **ComplexOR** 基准:收录 37 个复杂 OR 问题,由三位 OR 专家从学术论文、教材与真实工业场景中挑选,定位为比 **NL4Opt** 更难的评测集。
- 评测指标为 **execution accuracy**——以求解器跑出的最终最优值是否正确为准,而非仅看建模文本的相似度。
- 难度高:配套提出的多智能体框架 **Chain-of-Experts (CoE)** 在该基准上表现最好时也仅解出 37 题中的 10 题,凸显复杂 OR 自动建模的挑战性。
- CoE 采用多 LLM "专家" agent 协作(含 conductor 调度与 reflection 反思机制),将自然语言 OR 问题分步建模、生成求解器代码并自检。
- 公开发布时初版数据较原始,正式的 37 题集随后释出;代码见 github.com/xzymustbexzy/Chain-of-Experts。

## LLM 提炼出的去向(摘入了哪些 wiki 词条)
- [[complexor-benchmark]]
- [[multi-agent-or]]
- [[nl-to-optimization]]
