# GitHub Pages 部署指南

## 概述

本文档介绍如何将"北京城市更新政策问答"PWA系统部署到 GitHub Pages。

系统是纯前端应用（HTML + CSS + JS），部署后可通过 `https://你的用户名.github.io/仓库名/` 访问。

---

## 方式一：一键脚本部署（推荐）

### Windows
1. 双击运行 `deploy_github.bat`
2. 按提示输入 GitHub 用户名和邮箱（首次部署）
3. 按提示输入 GitHub 仓库 URL
4. 等待脚本自动推送

### Mac / Linux
```bash
chmod +x deploy_github.sh
./deploy_github.sh
```
按提示完成操作。

---

## 方式二：手动部署

### 第1步：创建 GitHub 仓库

1. 登录 [GitHub](https://github.com)
2. 点击右上角 `+` -> `New repository`
3. 仓库名称（建议）：`beijing-urban-renewal-policy-qa`
4. 设置为 **Public**（公开）
5. **不要**勾选 "Add a README file"
6. **不要**勾选 ".gitignore"
7. 点击 **Create repository**

### 第2步：推送代码

打开终端（Windows: PowerShell / CMD, Mac: 终端），进入 deploy 目录：

```bash
cd output/deploy
```

初始化 Git 并推送：

```bash
# 初始化 Git 仓库
git init

# 添加所有文件
git add .

# 提交
git commit -m "Initial commit: 北京城市更新政策问答 PWA"

# 设置默认分支为 main
git branch -M main

# 添加远程仓库（替换为你的仓库 URL）
git remote add origin https://github.com/你的用户名/仓库名.git

# 推送到 GitHub
git push -u origin main
```

### 第3步：启用 GitHub Pages

#### 方法 A：使用 GitHub Actions（推荐，自动部署）

1. 在你的 GitHub 仓库页面，点击 **Settings**
2. 左侧菜单找到 **Pages**
3. 在 **Build and deployment** 部分：
   - **Source**：选择 `GitHub Actions`
4. GitHub Actions 会自动运行 `.github/workflows/deploy.yml`
5. 等待约 1-2 分钟，部署完成后页面会显示 URL

#### 方法 B：手动设置 Pages

1. 在你的 GitHub 仓库页面，点击 **Settings**
2. 左侧菜单找到 **Pages**
3. 在 **Build and deployment** 部分：
   - **Source**：选择 `Deploy from a branch`
   - **Branch**：选择 `main`，目录选择 `/ (root)`
4. 点击 **Save**
5. 等待约 1-2 分钟，刷新页面查看 URL

### 第4步：访问网站

部署成功后，访问地址格式为：

```
https://你的用户名.github.io/仓库名/
```

例如：
```
https://zhangsan.github.io/beijing-urban-renewal-policy-qa/
```

---

## 如何在手机上访问

1. 在手机浏览器中打开上述 URL
2. 首次访问后，浏览器会自动提示 **"添加到主屏幕"**
3. 点击安装后，应用图标就会出现在手机桌面
4. 安装后可以像原生 App 一样使用，支持离线访问

**注意**：PWA 功能需要 HTTPS，GitHub Pages 默认提供 HTTPS，满足要求。

---

## 文件结构说明

```
deploy/
├── index.html                    # GitHub Pages 默认入口（自动跳转到 PWA 页面）
├── policy_pwa.html               # PWA 移动优化版主页
├── policy_rag_single.html        # 原始桌面版
├── mobile.css                    # 移动端专用样式
├── manifest.json                 # PWA 应用清单
├── sw.js                         # Service Worker（离线缓存）
├── .gitignore                    # Git 忽略文件
├── .nojekyll                     # 禁用 Jekyll 处理
├── .github/
│   └── workflows/
│       └── deploy.yml            # GitHub Actions 自动部署配置
├── icons/                        # PWA 图标（多尺寸）
│   ├── icon-16x16.png
│   ├── icon-32x32.png
│   ├── icon-72x72.png
│   ├── icon-96x96.png
│   ├── icon-128x128.png
│   ├── icon-144x144.png
│   ├── icon-152x152.png
│   ├── icon-192x192.png
│   ├── icon-384x384.png
│   └── icon-512x512.png
├── deploy_github.bat             # Windows 一键部署脚本
├── deploy_github.sh              # Mac/Linux 一键部署脚本
├── deploy_github.md              # 本文件（部署指南）
└── README.md                     # 项目说明
```

---

## 测试 PWA 功能

1. 使用 Chrome 浏览器打开部署的 URL
2. 按 `F12` 打开开发者工具
3. 切换到 **Application** 标签
4. 左侧菜单检查：
   - **Manifest**：确认应用名称、图标、主题色正确
   - **Service Workers**：确认 sw.js 已注册且状态为 "activated"
5. 测试离线功能：
   - 在 Service Workers 面板勾选 **Offline**
   - 刷新页面，确认仍然可以正常访问

---

## 常见问题

### Q: 部署后页面显示404？
A: 确认 Settings > Pages 中 Source 设置正确，等待几分钟让 GitHub Pages 生效。

### Q: PWA 安装提示不显示？
A: 需要满足以下条件：
- 网站必须通过 HTTPS 访问（GitHub Pages 满足）
- 必须有有效的 manifest.json
- 必须有注册成功的 Service Worker
- 用户必须与网站有交互（至少点击一次）

### Q: 图标不显示？
A: 检查 icons 目录下的图片文件是否都存在，manifest.json 中的图标路径是否正确。

### Q: Service Worker 注册失败？
A: Service Worker 必须在网站根路径下，确保 sw.js 和 index.html 在同一目录层级。

### Q: 如何更新已部署的网站？
A: 修改文件后，执行：
```bash
git add .
git commit -m "更新内容描述"
git push
```
GitHub Actions 会自动重新部署。

---

## 技术参数

| 项目 | 值 |
|------|-----|
| 应用名称 | 北京城市更新政策问答 |
| 短名称 | 政策问答 |
| 主题色 | `#1a56db`（政务蓝） |
| 显示模式 | `standalone`（独立应用） |
| 缓存策略 | Cache First + Network Fallback |
| 支持平台 | iOS 11.3+, Android 5.0+, Chrome/Firefox/Edge |