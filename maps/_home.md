---
title: or-wiki 首页(MOC)
tags: [moc]
updated: 2026-05-30
---

# or-wiki — LLM × 运筹学

本页是 OR×LLM 知识库的地图(MOC),按主题汇集全部词条与一句话索引。理念见 [[../README]],约定见 [[../CONVENTIONS]]。

### 建模(NL→数学规划)

- [[nl-to-optimization]] — 把自然语言问题描述转成可求解的数学优化模型的总任务。
- [[constraint-extraction]] — 从自然语言题面中识别构成约束的实体(决策变量、参数、限值、约束方向),并把它们映射为可被求解器处理的不等式/等式。
- [[objective-inference]] — 从自然语言描述中识别优化方向(max/min)并抽取目标函数的项与系数,把它形式化为求解器可用的目标表达式;它是 autoformulation 中与约束抽取并列的核心子步骤。
- [[nonlinear-optimization-llm]] — 把 LLM 的"自然语言 → 优化建模"能力,从 LP/MILP 扩展到非线性规划(NLP/SOCP 等)与含表格数据(tabular data)的问题,并研究其评测难度。
- [[structured-intermediate-representation]] — 在自然语言描述与具体求解器代码之间插入一层求解器无关、按元素组织(集合 / 参数 / 变量 / 目标 / 约束)的结构化表示,使建模与编码解耦、可逐元素校验、可作为代码生成的统一输入。
- [[data-grounding-parameterization]] — 把自然语言中的实体、数值与约束映射成具体的参数(parameters)与索引集合(index sets),从而由抽象数学模型构造出一个可被求解器实例化、求解的模型实例(model instance)。

### 求解与工具调用

- [[solver-code-generation]] — 把形式化的优化模型翻译为可执行的求解器代码(Gurobi/COPT/.lp),由外部求解器实际求解,LLM 借执行反馈迭代,从而以求解器保证最优性。
- [[self-debugging]] — LLM 智能体在建模/写代码后,读取求解器与运行时的报错(或对自身推理做批判性反思),迭代修正数学模型与求解代码,以提升正确性与鲁棒性。
- [[multi-agent-or]] — 用多个**角色化(role-specialized)**的 LLM agent 分工协作来把自然语言优化问题建模、写代码、校验、解释,由一个 conductor(指挥)调度它们,而不是让单个 LLM 一口气完成全部。
- [[llm-or-agents]] — 用一个(或多个)LLM 智能体把自然语言描述的运筹优化(OR)问题端到端地转成可验证的最优解:形式化建模 → 生成求解器代码 → 自动调试 → 验证迭代。
- [[retrieval-augmented-or]] — 在 LLM 建模 agent 的求解流水线中,于查询时检索相关示例/知识(Retrieval-Augmented Generation)并配合错误纠正闭环,以提升对长、复杂优化问题的规模化与鲁棒性。

### 解释与人在回路

- [[what-if-explanation]] — 用 LLM 充当优化系统的「解释层」:把用户的 what-if / 灵敏度(sensitivity)问题翻译成对优化模型的扰动并重解,再把求解结果回译成非专家可读的自然语言解释。
- [[human-in-the-loop-or]] — 让非专家用自然语言驱动优化模型,LLM 充当助手而非替代,关键执行环节由人类规划者(planner)在回路中把关。
- [[supply-chain-llm]] — 在供应链规划场景中,用 LLM 把规划者的自然语言 what-if 提问翻译成对既有优化求解器的修改与查询,并把求解结果解释回自然语言,而非用 LLM 取代求解器本身。

### 评测与风险

- [[nl4opt-benchmark]] — NeurIPS 2022 的 NL4Opt 竞赛及其配套 LPWP 数据集——首个面向「线性规划(LP)词题 → 形式化」的标注基准,把自然语言描述映射为可求解的 LP 模型。
- [[nlp4lp-benchmark]] — 随 OptiMUS 提出的优化建模基准:给定自然语言描述,要求系统端到端地完成「建模 + 写求解器代码 + 求解」,并以执行后是否给出正确最优目标值作为评测口径。
- [[complexor-benchmark]] — 一个面向复杂运筹学(OR)问题的数据集,由 OR 专家从论文、教材与工业场景中挑选,以最终最优值的正确性来评测 LLM 建模与求解能力。
- [[mamo-benchmark]] — 一个以「建模过程」而非仅「最终数值答案」来评测 LLM 数学建模能力的基准,覆盖 ODE 与优化两大类问题,并借助求解器自动验证模型是否正确。
- [[industryor-benchmark]] — IndustryOR 是首个面向真实工业场景的运筹优化(OR)基准,收集多行业、多题型、多难度的真实业务问题,用于评测 LLM 把自然语言问题转化为可求解优化模型的能力。
- [[optibench-benchmark]] — 一个端到端的优化建模评测基准:给定自然语言问题,模型需建模并调用求解器返回精确数值答案,覆盖线性/非线性与含/不含表格数据的题型。
- [[optmath-benchmark]] — OptMATH 是一套面向优化建模的可扩展双向数据合成框架,既产出大规模训练集 OptMATH-Train,也给出高难度、长上下文的 held-out 基准 OptMATH-Bench。
- [[orqa-benchmark]] — ORQA(Operations Research Question Answering)是由专家构建的多选题(multiple-choice)基准,用于测量 LLM 对 Operations Research(OR)概念的多步推理能力,而非单纯写代码的能力。
- [[process-evaluation-or]] — 不再只比对「最终答案」,而是用求解器执行、组件级核对建模过程本身,并审计基准数据质量、重建公平排行榜,以衡量 NL → 优化 系统的真实可靠性。
- [[failure-modes-hallucination]] — LLM 把自然语言问题形式化为优化模型时反复出现的错误类型(漏约束、错约束、目标方向错、不可行形式化),以及如何诊断、度量与缓解这些错误。
- [[or-llm-survey]] — 把「运筹学 × LLM」整片研究领域按全栈分层、梳理基准与评测质量,并兼收演化计算(EC)× LLM 的双向关系,作为本 wiki 的领域地图(map of content)入口。
- [[or-evaluation-metrics]] — OR×LLM 任务怎样判定"做对了":从声明级映射准确率,到 execution rate / solving accuracy / optimality gap 的端到端指标,再到 pass@k 采样口径与求解器校验,构成一套需统一口径才能跨基准比较的评测体系。

### LLM 作为优化器

- [[llm-as-optimizer]] — 把 LLM 当作无梯度 / 黑箱优化器:不算梯度,而是把「历史(解,分数)」喂给模型,让它在 in-context 里迭代提出更优的候选解。
- [[heuristic-evolution]] — 把 LLM 当作"变异/交叉算子"放进演化循环里,搜索的不是某个具体解、而是生成解的程序或启发式(heuristic)本身;每个候选由可执行评估器自动打分,迭代演化出更优的算法。
- [[combinatorial-opt-llm]] — 用 LLM 来求解或设计求解经典组合优化问题(TSP、bin packing、VRP/routing 等)的方法:既可让 LLM 直接搜索解,也可让它演化出可执行的「启发式程序」,再由确定性 evaluator 打分迭代。
- [[prompt-optimization-evo]] — 把"找一段好 prompt"本身当成一个黑箱优化问题:在自然语言的 prompt 空间里搜索,使下游任务指标最大化——LLM 既可以充当被优化对象,也可以充当优化器本身。

### 训练与开源模型

- [[open-source-or-models]] — 通过在合成的优化建模数据上微调开源中小模型(7B/8B/32B 量级),让其在自然语言到优化建模任务上追平甚至超过闭源大模型(GPT-4 等),同时规避把专有问题发往闭源 API 的数据隐私风险。
- [[or-data-synthesis]] — 为「自然语言优化建模」训练数据稀缺的问题,用半自动 / 反向 / 双向方式批量合成「问题描述 ↔ 数学模型 ↔ 求解代码」三元组,作为开源 OR 模型的指令微调语料。
- [[instruction-tuning-or]] — 通过多任务指令微调(multi-instruction tuning)+ 模型对齐(alignment)+ 测试时自纠错(self-correction),让(尤其是开源)LLM 同时学会把自然语言优化问题形式化、并生成可执行的求解器代码,从而显著提升端到端求解准确率。
- [[solver-feedback-rl]] — 用求解器返回的客观信号(执行成功、可行性、最优目标值)作为可验证奖励(verifiable reward),通过强化学习把 LLM 训练成更可靠的优化建模器。

