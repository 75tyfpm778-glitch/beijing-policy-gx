# 北京城市更新政策问答 PWA

基于《北京市城市更新条例》及配套政策文件的纯前端RAG智能问答系统。

## 功能特性

- **纯前端实现**：所有数据嵌入页面，无需后端服务
- **移动优先**：响应式设计，触摸友好
- **PWA支持**：可安装到手机桌面，支持离线访问
- **智能检索**：基于BM25算法的政策文档检索
- **多专题分类**：14个政策专题，精准定位
- **离线缓存**：Service Worker缓存核心资源

## 快速开始

### 本地使用
1. 双击 `policy_pwa.html` 即可运行
2. 或使用 `python -m http.server 8000` 启动本地服务器

### GitHub Pages 部署
```bash
# 使用一键部署脚本
./deploy_github.bat    # Windows
./deploy_github.sh     # Mac/Linux
```

详细部署指南见 [deploy_github.md](deploy_github.md)

## 技术架构

- **前端框架**：原生 HTML/CSS/JavaScript
- **检索算法**：BM25 + 倒排索引
- **移动优化**：触摸目标 ≥ 44px，字体 ≥ 16px
- **PWA功能**：Manifest + Service Worker + 离线缓存
- **数据格式**：JSON嵌入政策数据（977个文本块，63个文件）

## 文件说明

| 文件 | 用途 |
|------|------|
| `policy_pwa.html` | PWA移动优化版主页面 |
| `policy_rag_single.html` | 原始桌面版 |
| `mobile.css` | 移动端专用样式 |
| `manifest.json` | PWA应用清单 |
| `sw.js` | Service Worker脚本 |
| `index.html` | GitHub Pages入口（自动跳转） |

## 开发说明

### 数据更新
如需更新政策数据，修改 `policy_pwa.html` 中的 `POLICY_DATA` 对象。

### 样式定制
- 主题色：修改 `mobile.css` 中的 `--primary` 变量
- 图标：替换 `icons/` 目录下的PNG文件
- 布局：调整CSS中的媒体查询断点

### 测试
1. 打开 `policy_pwa.html`
2. 按 `F12` 打开开发者工具
3. 在 Application 面板检查 PWA 功能
4. 测试离线访问功能

## 浏览器支持

- Chrome 54+ ✓
- Firefox 63+ ✓
- Safari 11.3+ ✓
- Edge 79+ ✓
- iOS Safari 11.3+ ✓
- Android Chrome 54+ ✓

## 许可证

本项目基于开源协议发布，仅供学习和研究使用。

## 联系

如有问题或建议，请通过GitHub Issues提交。