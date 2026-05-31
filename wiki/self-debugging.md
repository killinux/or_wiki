---
title: 自调试与自纠错(Self-Debugging)
type: note
tags: [self-debugging, self-correction, reflection, error-correction]
updated: 2026-05-30
sources: [sources/optimus-2024.md, sources/chain-of-experts-2024.md, sources/llmopt-2025.md, sources/optimus-03-2024.md]
---

# 自调试与自纠错(Self-Debugging)

> LLM 智能体在建模/写代码后,读取求解器与运行时的报错(或对自身推理做批判性反思),迭代修正数学模型与求解代码,以提升正确性与鲁棒性。

## 核心要点
- 自调试闭环:运行求解器 → 读取错误 → 修复代码,是 OptiMUS 智能体的核心环节之一(formulation / programming / debugging 三类角色协同)[[../sources/optimus-2024]]。
- backward reflection 机制:Chain-of-Experts 用 **forward thought construction + backward reflection** 来构建并修订解,实现多专家协作下的自纠错[[../sources/chain-of-experts-2024]]。
- RAG + 错误纠正:OptiMUS-0.3 在管线中加入 **RAG over 问题/模板语料** 与 **error correction loop**(读取 solver/runtime 报错并修正模型/代码),以提升对更大、更难实例的鲁棒性[[../sources/optimus-03-2024]]。
- 抑制幻觉:LLMOPT 用 **model alignment + self-correction** 降低幻觉、提升可靠性,同时报告了求解准确率与跨问题类型泛化的提升,即纠错并不以牺牲求解准确率为代价[[../sources/llmopt-2025]]。
- 自纠错把单次形式化的"一次成型"问题,转化为可观测、可迭代的过程:报错信号(语法/运行时/不可行)成为修正不可行或错误形式化的反馈来源[[../sources/optimus-2024]]。

## 与其它概念的关系
- 上游:[[solver-code-generation]] —— 自调试以"已生成的求解器代码 + 其运行报错"为输入,二者构成迭代闭环。
- 上游 / 容器:[[nl-to-optimization]] —— 自纠错通常嵌在 NL → 模型 → 代码 → 求解的整体回路中,作为其中的修正子步骤。
- 协同:[[multi-agent-or]] —— Chain-of-Experts 把 backward reflection 落在多专家(conductor 协调)框架中,自纠错由专门角色承担[[../sources/chain-of-experts-2024]];[[llm-or-agents]] 中的 debugging 角色亦同源[[../sources/optimus-2024]]。
- 协同:[[retrieval-augmented-or]] —— OptiMUS-0.3 把 RAG 与 error correction 组合使用以增强鲁棒性[[../sources/optimus-03-2024]]。
- 对比 / 缓解:[[failure-modes-hallucination]] —— 自纠错被定位为对幻觉与不可行形式化的抑制手段[[../sources/llmopt-2025]]。
- 相关:[[process-evaluation-or]] —— 自调试产生的中间错误/修复轨迹,可作为过程级评估的观测对象。

## 开放问题 / 矛盾
- 错误信号覆盖面有限:求解器报错能捕捉语法错误与不可行(infeasible),却难以发现"能跑通但语义错"的形式化(约束/目标抽取错误)——这类沉默错误仍可能逃过自调试闭环[[../sources/optimus-2024]]。
- 纠错与准确率的权衡:LLMOPT 报告 self-correction 在抑制幻觉的同时保持/提升求解准确率[[../sources/llmopt-2025]],但能否在所有问题类别上都不牺牲准确率,源笔记未给出可核实的逐类数字,需谨慎对待。
- RAG 归属问题:据 OptiMUS-0.3 论文(arXiv:2407.19633),RAG 与 error correction 是 0.3 版引入、在 0.1/0.2 两个早期版本中均不存在的新增模块;而最初的 OptiMUS(arXiv:2402.10172)论文本身已包含"写并调试求解器代码"的调试/纠错环节。故"自调试"并非 0.3 才出现,但"基于检索的 RAG"确为 0.3 的新增,版本归属以各自原论文为准[[../sources/optimus-2024]] [[../sources/optimus-03-2024]]。

## 来源
- [[../sources/optimus-2024]]
- [[../sources/chain-of-experts-2024]]
- [[../sources/llmopt-2025]]
- [[../sources/optimus-03-2024]]
