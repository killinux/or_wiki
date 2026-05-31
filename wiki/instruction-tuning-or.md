---
title: OR 指令微调与模型对齐
type: note
tags: [instruction-tuning, alignment, self-correction, five-element]
updated: 2026-05-30
sources: [sources/llmopt-2025.md, sources/orlm-2024.md, sources/resocratic-optibench-2025.md]
---
# OR 指令微调与模型对齐

> 通过多任务指令微调(multi-instruction tuning)+ 模型对齐(alignment)+ 测试时自纠错(self-correction),让(尤其是开源)LLM 同时学会把自然语言优化问题形式化、并生成可执行的求解器代码,从而显著提升端到端求解准确率。

## 核心要点

- 多指令微调:LLMOPT 用 multi-instruction tuning 同时改进「问题 formalization」与「solver code generation」两类任务的准确性与通用性,使一个模型覆盖从建模到求解的完整链路(据 [[../sources/llmopt-2025]])。
- five-element formulation:LLMOPT 提出通用的「五要素」表示,把不同类型优化问题统一抽象为一种结构化定义,以提升 optimization generalization(优化泛化),覆盖 linear / nonlinear programming、mixed integer programming 与 combinatorial optimization 等多类问题(据 [[../sources/llmopt-2025]])。
- 对齐 + 测试时自纠错:LLMOPT 在指令微调之外引入 model alignment 与 self-correction(自纠错)机制以抑制求解过程中的 hallucination(幻觉);在 6 个真实数据集(约 20 个领域)上相比 SOTA 平均求解准确率(solving accuracy)提升约 11.08%(据 [[../sources/llmopt-2025]])。
- SFT 对开源模型的大幅提升:在合成数据 ReSocratic-29k 上做监督微调(SFT)后,Llama-3-8B-Instruct 在 OptiBench 上从 13.6% 提升到 51.7%,Llama-2-7B-Chat 从 0.0% 提升到 30.6%(据 [[../sources/resocratic-optibench-2025]])。
- 与开源 OR 模型路线一致:ORLM 用半自动数据合成框架 OR-Instruct 产出指令微调数据,训练出的最佳 7B/8B 级模型(LLaMA-3-8B)在 NL4Opt、MAMO、IndustryOR 上同时达到 SOTA,验证「指令微调 + 数据合成」是开源 OR 模型的核心配方(据 [[../sources/orlm-2024]])。

## 与其它概念的关系

- 上游(数据来源):依赖 [[or-data-synthesis]] 产出的合成指令/解答对作为 SFT 训练语料(OR-Instruct、ReSocratic 均属此类)。
- 下游(产物):指令微调后的模型即 [[open-source-or-models]],是本词条方法的直接成果。
- 子能力 / 平行步骤:微调目标之一是 [[solver-code-generation]];自纠错机制与 [[self-debugging]] 高度重叠(后者侧重运行报错驱动的代码修复,本词条侧重训练 + 测试时联合的自我修正)。
- 任务定位:服务于 [[nl-to-optimization]] 的端到端目标。
- 抑制对象:对齐 + 自纠错直接针对 [[failure-modes-hallucination]](LLMOPT 以此抑制求解过程中的幻觉)。
- 评测:效果在 [[optibench-benchmark]]、[[industryor-benchmark]]、[[mamo-benchmark]]、[[nl4opt-benchmark]] 等基准上度量(ReSocratic 数字来自 OptiBench;ORLM SOTA 来自后三者)。
- 对比:与不微调、仅靠提示/智能体编排的 [[llm-or-agents]] 路线形成对比——前者把能力固化进权重,后者靠推理时编排;两者可叠加。

## 开放问题 / 矛盾

- 自纠错的真实增益边界:测试时自纠错对训练分布内的问题提升明显,但对分布外(OOD)/真正新颖问题是否仍有效,各工作口径不一,缺乏统一对照实验。
- 准确率提升的可比性:不同论文报告的「准确率提升」基线、数据集与评测口径不同(LLMOPT 的平均 +11.08% 跨 6 数据集 vs ReSocratic 的 13.6%→51.7% 仅在 OptiBench),数字不可直接横向相加或比较;需参见 [[process-evaluation-or]] 关注解题过程正确性而非仅最终答案。

> ⚠️ 矛盾:在 OptiBench 上,经 ReSocratic-29k SFT 的开源 Llama-3-8B-Instruct 约 51.7%(来源:[[../sources/resocratic-optibench-2025]]),仍低于闭源 GPT-4 few-shot 约 65.5% 的最强基线(来源:[[../sources/resocratic-optibench-2025]]);而 ORLM 则报告其 7B/8B 级模型在 NL4Opt / MAMO / IndustryOR 上反超 GPT-4 标准 prompting(来源:[[../sources/orlm-2024]])。两者结论差异主要源于基准与 prompting 设置不同(OptiBench 偏非线性/表格、few-shot vs 标准 prompting),不可直接对冲。

## 来源
- [[../sources/llmopt-2025]]
- [[../sources/orlm-2024]]
- [[../sources/resocratic-optibench-2025]]
