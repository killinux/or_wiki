---
title: 第 8 课:工具实战(PuLP / Gurobi)
tags: [study, or, tools, pulp, gurobi, python]
updated: 2026-05-31
---

# 第 8 课:工具实战 —— 用 Python 求解优化

承接 [[lesson-07-nonlinear-heuristics]]。前面都在手算建立直觉;真实问题靠**求解器**。
本课用开源库 **PuLP** 把第 1 课的农场题敲成代码。

## 1. 安装

```bash
pip install pulp
```
PuLP 自带开源求解器 CBC,无需额外配置即可解 LP / MILP。

## 2. 农场题(LP 版)

回顾模型:`max 40x+50y`,`x+y≤10`(土地),`x+2y≤16`(工时),`x,y≥0`。

```python
import pulp

# 1) 建问题(最大化)
prob = pulp.LpProblem("farm", pulp.LpMaximize)

# 2) 决策变量(下界 0 = 非负约束)
x = pulp.LpVariable("wheat", lowBound=0)   # 小麦公顷
y = pulp.LpVariable("corn",  lowBound=0)   # 玉米公顷

# 3) 目标函数(写在第一条 += 里)
prob += 40 * x + 50 * y

# 4) 约束
prob += x + y <= 10,      "land"
prob += x + 2 * y <= 16,  "labor"

# 5) 求解
prob.solve()

print("状态:", pulp.LpStatus[prob.status])      # Optimal
print("小麦:", x.value(), "玉米:", y.value())    # 4.0  6.0
print("利润:", pulp.value(prob.objective))       # 460.0
```

代码结构和「建模五件套」一一对应:**问题方向 → 变量 → 目标 → 约束 → 求解**。

## 3. 整数版(改一个参数就行)

要求「整数公顷」?给变量加 `cat="Integer"`,PuLP 自动走分支定界([[lesson-04-integer-programming]]):

```python
x = pulp.LpVariable("wheat", lowBound=0, cat="Integer")
y = pulp.LpVariable("corn",  lowBound=0, cat="Integer")
# 0-1 决策则用 cat="Binary"
```

## 4. 读出影子价格(对偶,见 [[lesson-03-duality]])

```python
for name, c in prob.constraints.items():
    print(name, "影子价格 =", c.pi, " 剩余 =", c.slack)
# land  影子价格 = 30   slack = 0
# labor 影子价格 = 10   slack = 0
```
代码直接验证了第 3 课手算的影子价格 30 / 10。

## 5. 生态:还有哪些工具

| 工具 | 特点 |
|------|------|
| **PuLP** | 最易上手,适合学习,自带 CBC |
| **Pyomo** | 更强大的建模语言,支持非线性 |
| **OR-Tools**(Google) | 网络流、约束规划、路由(VRP)强 |
| **Gurobi / COPT** | 商用顶级求解器,工业首选(本 wiki 词条里 LLM 生成的就是这类代码) |
| **SciPy / CVXPY** | 连续/凸优化([[lesson-07-nonlinear-heuristics]]) |

> 本仓库词条 [[../wiki/solver-code-generation]] 讲的正是「让 LLM 自动写出上面这类 Gurobi/PuLP 代码」。
> 你现在能看懂它生成的代码对不对了。

## 一句话总结

- 真实优化靠求解器;PuLP 用几行 Python 就能把模型解出来,代码结构 = 建模五件套。
- 加 `cat="Integer"/"Binary"` 即得整数/0-1 规划;`constraint.pi` 直接读影子价格。
- 工业级用 Gurobi/OR-Tools —— 这正是 LLM×OR 里「solver code generation」生成的目标代码。

→ 收官课:[[lesson-09-back-to-wiki]] 回到本 wiki,看 LLM 怎么自动做这一切。
