# ForML — 机器学习入门笔记

## 项目概述

这是一套以"翻书"体验呈现的机器学习入门学习笔记，部署于 GitHub Pages。
每章有两个产出物：`.factor` 知识图谱 和 `.html` 翻书页面。

---

## 仓库结构

```
index.html              ← GitHub Pages 首页，章节导航
ch{N}-book.html         ← 各章翻书页面（序章 + 6 页）
factors/
  ch00-ml-intro-index.factor  ← 课程总索引
  ch{N}-*.factor               ← 各章知识因子图谱
```

---

## Factor 图谱规范

### 文件格式

- 后缀 `.factor`，纯文本
- 每个文件对应一个章节的知识结构

### 语法规则

```
# 头部指令（必须）
# use-this-graph-to-build: 章节标题
# scope: 作用域标识
# status: pending | built | updated

# 节点格式
topic.facet: [因子词1, 因子词2, 权重:critical|important|low-priority]

# 边格式
A -> B: [关系描述, 类型, 权重]

# 尾部自评分
# ~90%
```

### 编写原则

- 因子词用连字符连接多词，禁止自然语句
- 方括号内左侧放实现细节，右侧放意图/权重
- 权重三档：`critical`（核心）、`important`（重要）、`low-priority`（补充）
- 核心节点必须嵌入具体值和约束，下游 agent 无需查找即可执行
- 辅助内容不超过总行数 30%，禁止辅助节点自描述
- `homework` 节点按 **现象 → 原因 → 对策** 组织答题线索

### 章节索引 (ch00)

- `@path/to/file` 语法链接到子图谱文件
- 章节间用 `->` 表达学习顺序依赖
- `insight.*` 节点记录贯穿全课的核心洞察

---

## 书页设计规范（Scholar's Desk 风格）

### 美术方向

**Scholar's Desk** —— 书斋案头风格：宣纸暖色底、水墨配色、书法风标题、3D 翻页。

### 色彩系统（CSS 变量）

| 变量 | 色值 | 用途 |
|------|------|------|
| `--paper` | `#f5f0e8` | 页面底色（宣纸） |
| `--paper-dark` | `#e8e0d0` | 深纸色 |
| `--ink` | `#2c1810` | 正文主色（深墨） |
| `--ink-light` | `#5a4a3a` | 正文次色 |
| `--ink-faint` | `#9a8a7a` | 注释/辅助文字 |
| `--vermillion` | `#c41e3a` | 朱砂红（重点标注、标签） |
| `--blue-ink` | `#2a4a6b` | 青墨蓝（特征、参数 w） |
| `--green-ink` | `#2a6b4a` | 松绿（参数 b、正向概念） |
| `--gold` | `#b8943e` | 金色（装饰线、预测） |

### 字体

| 字体 | 用途 |
|------|------|
| `ZCOOL XiaoWei` | 中文标题（书法风） |
| `Noto Serif SC` | 中文正文（宋体） |
| `Crimson Pro` | 英文/数字/页码（衬线） |

### 页面结构

每本书固定 7 页：

```
Page 0  序章（封面）: 章节编号、标题、英文副标题、目录
Page 1-5  内容页: 各节知识点
Page 6  章节小结: summary-list + 下一章预告
```

### 组件类名

| 类名 | 用途 |
|------|------|
| `.note-box` | 红色左边框提示框（要点/关键） |
| `.insight-box` | 蓝色左边框洞察框（预告/深层理解） |
| `.compare-row` + `.compare-card` | 并排对比卡片 |
| `.data-table` | 数据表格 |
| `.formula-block` + `.formula` | 公式展示区 |
| `.param-cards` + `.param-card` | 参数双卡片（w/b 等） |
| `.flow-steps` + `.flow-step` | 流程步骤（带编号圆点） |
| `.summary-list` | 带编号的总结列表 |
| `.venn-container` | 嵌套圆形韦恩图 |

### 文字强调

```html
<span class="highlight">朱砂红重点</span>
<span class="blue">青墨蓝术语</span>
<span class="green">松绿正向概念</span>
<span class="gold">金色标注</span>
<strong>加粗</strong>
```

### 交互

- CSS 3D 翻页动效（`transform-origin: left center`，`rotateY`）
- 底部导航：上一页/下一页按钮 + 圆点指示器
- 键盘 ← → 方向键
- 触屏左右滑动
- 页面内容 `fadeUp` 渐入动画（逐元素延迟）

### 暗色桌面背景

```css
body { background: #1a1612; }
body::before {
  background: radial-gradient(ellipse at 50% 40%, #2a2320 0%, #1a1612 70%);
}
```

### 新增章节步骤

1. 先编写 `factors/chN-topic.factor` 因子图谱
2. 基于图谱构建 `chN-book.html`（复用完整 CSS/JS 框架）
3. 在 `index.html` 中添加章节导航链接
4. 在 `factors/ch00-ml-intro-index.factor` 中注册新章节节点和边

---

## 内容语言

所有书页内容为**中文**，页码标注和装饰性标签用英文（如 `Chapter 01 · Page 1`、`Key`、`Machine Learning Notes`）。
