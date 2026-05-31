---
title: "从程序搜索中发现数学:FunSearch(Mathematical discoveries from program search with large language models)"
type: source
authors: "Bernardino Romera-Paredes, Mohammadamin Barekatain, Alexander Novikov, Matej Balog, M. Pawan Kumar, Emilien Dupont, Francisco J. R. Ruiz, Jordan S. Ellenberg, Pengming Wang, Omar Fawzi, Pushmeet Kohli, Alhussein Fawzi"
year: 2024
url: "https://www.nature.com/articles/s41586-023-06924-6"
added: 2026-05-30
tags: [source]
---

# 从程序搜索中发现数学:FunSearch

> 一句话:Google DeepMind 把 LLM 和自动评测器组成「演化式程序搜索」——让 LLM 生成的不是「解」而是「启发式程序」,用可执行评测打分、优者回灌为示例迭代,从而在 cap set 和在线装箱(online bin packing)等问题上产出可验证的新结果。值得收,是因为它给出了「LLM 搜程序空间 + 评测器把关」这一缓解幻觉、可落地到 OR 组合优化的范式。

## 关键内容

- **方法 = LLM + 评测器 + island 演化库。** FunSearch 把问题写成一段「待补全的程序/函数」,由预训练 LLM(论文用 Codey/PaLM 系)提出大量候选程序;每个候选交给一个确定性的自动评测器(evaluator)运行打分;高分程序存入按「islands」划分的演化程序库(programs database),再作为 in-context 示例回灌给 LLM(best-shot prompting),如此迭代。关键在于**搜的是程序而非答案**,且评测器对每个候选给出客观分数,从而**缓解 LLM 幻觉**——输出本身是可执行、可验证的代码。
- **cap set 问题(纯数学组合上界):** FunSearch 给出新的构造,带来**约 20 年来对该问题渐近下界的最大改进**;在 n=8 维下找到了**比此前已知更大的 cap set**(512 个元素的构造)。这是 LLM 辅助产出、并经人工/形式验证为真的新数学结果。
- **online bin packing(在线装箱,OR 经典问题):** FunSearch 自动**发现了优于经典 first-fit 与 best-fit 的装箱启发式**,在 OR-Library 基准与模拟数据(Weibull 分布等)上均取得更好表现,说明该范式能直接服务于 OR 组合优化的启发式设计。
- **可验证性是核心卖点。** 与「让 LLM 直接给答案」不同,FunSearch 产出的是可运行程序,既能被评测器自动验证,又**易于人类阅读、解释和复用**(可读的启发式比黑箱解更有科研价值)。
- **出处与开放性。** 论文发表于 *Nature* 625(7995):468–475(在线 2023 年 12 月,DOI 10.1038/s41586-023-06924-6),共 12 位作者,均来自 Google DeepMind;代码开源于 github.com/google-deepmind/funsearch。

## LLM 提炼出的去向(摘入了哪些 wiki 词条)

- [[llm-as-optimizer]]
- [[heuristic-evolution]]
- [[combinatorial-opt-llm]]
