# 北京城市更新政策问答 PWA - GitHub Pages 部署完成

## 部署文件已就绪

所有 GitHub Pages 部署所需的文件已创建完成，位于 `output/deploy/` 目录。

### 文件结构
```
output/deploy/
├── index.html                    # GitHub Pages 入口（自动跳转）
├── policy_pwa.html               # PWA 移动优化版主页
├── policy_rag_single.html        # 原始桌面版
├── mobile.css                    # 移动端专用样式
├── manifest.json                 # PWA 应用清单
├── sw.js                         # Service Worker 脚本
├── .gitignore                    # Git 忽略文件
├── .nojekyll                     # 禁用 Jekyll 处理
├── .github/workflows/deploy.yml  # GitHub Actions 自动部署
├── deploy_github.bat             # Windows 一键部署脚本
├── deploy_github.sh              # Mac/Linux 一键部署脚本
├── deploy_github.md              # 详细部署指南
├── README.md                     # 项目说明
└── icons/                        # PWA 图标（10种尺寸）
```

## 部署步骤

### 方法一：一键脚本部署（推荐）

#### Windows
1. 进入 `output/deploy/` 目录
2. 双击运行 `deploy_github.bat`
3. 按提示输入 GitHub 用户名、邮箱和仓库 URL
4. 脚本会自动完成所有部署步骤

#### Mac/Linux
```bash
cd output/deploy/
chmod +x deploy_github.sh
./deploy_github.sh
```

### 方法二：手动部署

#### 第1步：创建 GitHub 仓库
1. 访问 https://github.com/new
2. 仓库名：`beijing-urban-renewal-policy-qa`
3. 设置为 **Public**（公开）
4. 不要勾选 README 和 .gitignore

#### 第2步：推送代码
```bash
cd output/deploy/
git init
git add .
git commit -m "Initial commit: 北京城市更新政策问答 PWA"
git branch -M main
git remote add origin https://github.com/你的用户名/仓库名.git
git push -u origin main
```

#### 第3步：启用 GitHub Pages
1. 在 GitHub 仓库页面，点击 **Settings**
2. 左侧找到 **Pages**
3. **Source** 选择 `GitHub Actions`
4. 等待约 1-2 分钟自动部署完成

#### 第4步：访问网站
```
https://你的用户名.github.io/仓库名/
```

## PWA 功能验证

部署成功后，在手机上访问网站：
1. 浏览器会自动提示 **"添加到主屏幕"**
2. 点击安装，应用图标出现在手机桌面
3. 支持离线访问，像原生 App 一样使用

## 技术特性

- **纯前端实现**：无需后端服务，数据嵌入页面
- **移动优化**：触摸目标 ≥ 44px，字体 ≥ 16px
- **PWA 完整功能**：可安装、离线访问、独立窗口
- **智能检索**：基于 BM25 算法的政策文档检索
- **多专题分类**：14 个政策专题，精准定位
- **自动部署**：GitHub Actions 自动部署到 Pages

## 文件清单

```<yyb-file-list>
[.gitignore](<C:\Users\wmz90\AppData\Roaming\Tencent\Marvis\User\oAN1i2cFfRfFRc0ZVuEo8Bw4-IQI\workspace\conv_19e625f9b22_cf32fd8db848\output\deploy\.gitignore>)
[.nojekyll](<C:\Users\wmz90\AppData\Roaming\Tencent\Marvis\User\oAN1i2cFfRfFRc0ZVuEo8Bw4-IQI\workspace\conv_19e625f9b22_cf32fd8db848\output\deploy\.nojekyll>)
[deploy.yml](<C:\Users\wmz90\AppData\Roaming\Tencent\Marvis\User\oAN1i2cFfRfFRc0ZVuEo8Bw4-IQI\workspace\conv_19e625f9b22_cf32fd8db848\output\deploy\.github\workflows\deploy.yml>)
[deploy_github.bat](<C:\Users\wmz90\AppData\Roaming\Tencent\Marvis\User\oAN1i2cFfRfFRc0ZVuEo8Bw4-IQI\workspace\conv_19e625f9b22_cf32fd8db848\output\deploy\deploy_github.bat>)
[deploy_github.md](<C:\Users\wmz90\AppData\Roaming\Tencent\Marvis\User\oAN1i2cFfRfFRc0ZVuEo8Bw4-IQI\workspace\conv_19e625f9b22_cf32fd8db848\output\deploy\deploy_github.md>)
[deploy_github.sh](<C:\Users\wmz90\AppData\Roaming\Tencent\Marvis\User\oAN1i2cFfRfFRc0ZVuEo8Bw4-IQI\workspace\conv_19e625f9b22_cf32fd8db848\output\deploy\deploy_github.sh>)
[index.html](<C:\Users\wmz90\AppData\Roaming\Tencent\Marvis\User\oAN1i2cFfRfFRc0ZVuEo8Bw4-IQI\workspace\conv_19e625f9b22_cf32fd8db848\output\deploy\index.html>)
[manifest.json](<C:\Users\wmz90\AppData\Roaming\Tencent\Marvis\User\oAN1i2cFfRfFRc0ZVuEo8Bw4-IQI\workspace\conv_19e625f9b22_cf32fd8db848\output\deploy\manifest.json>)
[mobile.css](<C:\Users\wmz90\AppData\Roaming\Tencent\Marvis\User\oAN1i2cFfRfFRc0ZVuEo8Bw4-IQI\workspace\conv_19e625f9b22_cf32fd8db848\output\deploy\mobile.css>)
[policy_pwa.html](<C:\Users\wmz90\AppData\Roaming\Tencent\Marvis\User\oAN1i2cFfRfFRc0ZVuEo8Bw4-IQI\workspace\conv_19e625f9b22_cf32fd8db848\output\deploy\policy_pwa.html>)
[policy_rag_single.html](<C:\Users\wmz90\AppData\Roaming\Tencent\Marvis\User\oAN1i2cFfRfFRc0ZVuEo8Bw4-IQI\workspace\conv_19e625f9b22_cf32fd8db848\output\deploy\policy_rag_single.html>)
[README.md](<C:\Users\wmz90\AppData\Roaming\Tencent\Marvis\User\oAN1i2cFfRfFRc0ZVuEo8Bw4-IQI\workspace\conv_19e625f9b22_cf32fd8db848\output\deploy\README.md>)
[sw.js](<C:\Users\wmz90\AppData\Roaming\Tencent\Marvis\User\oAN1i2cFfRfFRc0ZVuEo8Bw4-IQI\workspace\conv_19e625f9b22_cf32fd8db848\output\deploy\sw.js>)
[icon-16x16.png](<C:\Users\wmz90\AppData\Roaming\Tencent\Marvis\User\oAN1i2cFfRfFRc0ZVuEo8Bw4-IQI\workspace\conv_19e625f9b22_cf32fd8db848\output\deploy\icons\icon-16x16.png>)
[icon-32x32.png](<C:\Users\wmz90\AppData\Roaming\Tencent\Marvis\User\oAN1i2cFfRfFRc0ZVuEo8Bw4-IQI\workspace\conv_19e625f9b22_cf32fd8db848\output\deploy\icons\icon-32x32.png>)
[icon-72x72.png](<C:\Users\wmz90\AppData\Roaming\Tencent\Marvis\User\oAN1i2cFfRfFRc0ZVuEo8Bw4-IQI\workspace\conv_19e625f9b22_cf32fd8db848\output\deploy\icons\icon-72x72.png>)
[icon-96x96.png](<C:\Users\wmz90\AppData\Roaming\Tencent\Marvis\User\oAN1i2cFfRfFRc0ZVuEo8Bw4-IQI\workspace\conv_19e625f9b22_cf32fd8db848\output\deploy\icons\icon-96x96.png>)
[icon-128x128.png](<C:\Users\wmz90\AppData\Roaming\Tencent\Marvis\User\oAN1i2cFfRfFRc0ZVuEo8Bw4-IQI\workspace\conv_19e625f9b22_cf32fd8db848\output\deploy\icons\icon-128x128.png>)
[icon-144x144.png](<C:\Users\wmz90\AppData\Roaming\Tencent\Marvis\User\oAN1i2cFfRfFRc0ZVuEo8Bw4-IQI\workspace\conv_19e625f9b22_cf32fd8db848\output\deploy\icons\icon-144x144.png>)
[icon-152x152.png](<C:\Users\wmz90\AppData\Roaming\Tencent\Marvis\User\oAN1i2cFfRfFRc0ZVuEo8Bw4-IQI\workspace\conv_19e625f9b22_cf32fd8db848\output\deploy\icons\icon-152x152.png>)
[icon-192x192.png](<C:\Users\wmz90\AppData\Roaming\Tencent\Marvis\User\oAN1i2cFfRfFRc0ZVuEo8Bw4-IQI\workspace\conv_19e625f9b22_cf32fd8db848\output\deploy\icons\icon-192x192.png>)
[icon-384x384.png](<C:\Users\wmz90\AppData\Roaming\Tencent\Marvis\User\oAN1i2cFfRfFRc0ZVuEo8Bw4-IQI\workspace\conv_19e625f9b22_cf32fd8db848\output\deploy\icons\icon-384x384.png>)
[icon-512x512.png](<C:\Users\wmz90\AppData\Roaming\Tencent\Marvis\User\oAN1i2cFfRfFRc0ZVuEo8Bw4-IQI\workspace\conv_19e625f9b22_cf32fd8db848\output\deploy\icons\icon-512x512.png>)
```

```<yyb-product>
[index.html](<C:\Users\wmz90\AppData\Roaming\Tencent\Marvis\User\oAN1i2cFfRfFRc0ZVuEo8Bw4-IQI\workspace\conv_19e625f9b22_cf32fd8db848\output\deploy\index.html>)
[.gitignore](<C:\Users\wmz90\AppData\Roaming\Tencent\Marvis\User\oAN1i2cFfRfFRc0ZVuEo8Bw4-IQI\workspace\conv_19e625f9b22_cf32fd8db848\output\deploy\.gitignore>)
[.nojekyll](<C:\Users\wmz90\AppData\Roaming\Tencent\Marvis\User\oAN1i2cFfRfFRc0ZVuEo8Bw4-IQI\workspace\conv_19e625f9b22_cf32fd8db848\output\deploy\.nojekyll>)
[deploy.yml](<C:\Users\wmz90\AppData\Roaming\Tencent\Marvis\User\oAN1i2cFfRfFRc0ZVuEo8Bw4-IQI\workspace\conv_19e625f9b22_cf32fd8db848\output\deploy\.github\workflows\deploy.yml>)
[deploy_github.bat](<C:\Users\wmz90\AppData\Roaming\Tencent\Marvis\User\oAN1i2cFfRfFRc0ZVuEo8Bw4-IQI\workspace\conv_19e625f9b22_cf32fd8db848\output\deploy\deploy_github.bat>)
[deploy_github.md](<C:\Users\wmz90\AppData\Roaming\Tencent\Marvis\User\oAN1i2cFfRfFRc0ZVuEo8Bw4-IQI\workspace\conv_19e625f9b22_cf32fd8db848\output\deploy\deploy_github.md>)
[deploy_github.sh](<C:\Users\wmz90\AppData\Roaming\Tencent\Marvis\User\oAN1i2cFfRfFRc0ZVuEo8Bw4-IQI\workspace\conv_19e625f9b22_cf32fd8db848\output\deploy\deploy_github.sh>)
[README.md](<C:\Users\wmz90\AppData\Roaming\Tencent\Marvis\User\oAN1i2cFfRfFRc0ZVuEo8Bw4-IQI\workspace\conv_19e625f9b22_cf32fd8db848\output\deploy\README.md>)
