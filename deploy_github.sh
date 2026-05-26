#!/usr/bin/env bash
set -euo pipefail

echo ""
echo "============================================"
echo "  北京城市更新政策问答 - GitHub Pages 部署"
echo "============================================"
echo ""

# 检查 Git 是否安装
if ! command -v git &> /dev/null; then
    echo "[错误] 未检测到 Git，请先安装 Git。"
    echo "macOS: brew install git"
    echo "Ubuntu/Debian: sudo apt install git"
    echo "CentOS/RHEL: sudo yum install git"
    exit 1
fi

echo "[✓] Git 已安装"
echo ""

# 获取脚本所在目录
DEPLOY_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$DEPLOY_DIR"

# 检查是否已经是 Git 仓库
if [ -d ".git" ]; then
    echo "[✓] 检测到已有 Git 仓库"
    echo ""
else
    # 初始化 Git 仓库
    echo "[*] 正在初始化 Git 仓库..."
    git init
    echo "[✓] Git 仓库初始化完成"
    echo ""

    # 配置用户信息（如果未配置）
    if ! git config user.name &> /dev/null; then
        echo "[*] 请配置 Git 用户信息:"
        read -p "请输入您的姓名: " GIT_NAME
        read -p "请输入您的邮箱: " GIT_EMAIL
        git config user.name "$GIT_NAME"
        git config user.email "$GIT_EMAIL"
        echo "[✓] Git 用户信息已配置"
        echo ""
    fi

    # 添加所有文件
    echo "[*] 正在添加文件到暂存区..."
    git add .
    echo "[✓] 文件已添加"
    echo ""

    # 提交
    echo "[*] 正在提交..."
    git commit -m "Initial commit: 北京城市更新政策问答 PWA" || echo "[警告] 提交可能没有新内容，继续推送..."
    echo "[✓] 提交完成"
    echo ""
fi

# 检查远程仓库
if ! git remote -v 2>/dev/null | grep -q "origin"; then
    echo "[*] 未检测到远程仓库"
    echo ""
    echo "请先在 GitHub 上创建仓库:"
    echo "  1. 访问 https://github.com/new"
    echo "  2. 仓库名称建议: beijing-urban-renewal-policy-qa"
    echo "  3. 不要勾选 \"Add a README file\""
    echo "  4. 不要勾选 \".gitignore\""
    echo "  5. 创建后复制仓库 URL"
    echo ""
    read -p "请输入 GitHub 仓库 URL (如 https://github.com/用户名/仓库名.git): " REPO_URL
    git remote add origin "$REPO_URL"
    echo "[✓] 远程仓库已添加"
    echo ""
fi

# 设置默认分支为 main
git branch -M main

# 推送
echo "[*] 正在推送到 GitHub..."
echo ""
git push -u origin main || {
    echo ""
    echo "[错误] 推送失败，请检查:"
    echo "  1. 网络连接是否正常"
    echo "  2. GitHub 仓库 URL 是否正确"
    echo "  3. 是否有仓库写入权限"
    echo ""
    exit 1
}

echo ""
echo "============================================"
echo "  ✓ 部署成功！"
echo "============================================"
echo ""
echo "接下来:"
echo "  1. 访问你的 GitHub 仓库页面"
echo "  2. 点击 Settings > Pages"
echo "  3. Source 选择 \"GitHub Actions\""
echo "  4. 等待 Actions 自动部署完成"
echo "  5. 访问 https://你的用户名.github.io/仓库名/"
echo ""
echo "详细说明请查看 deploy_github.md"
echo ""