@echo off
chcp 65001 >nul
title 北京城市更新政策问答 - GitHub Pages 一键部署

echo.
echo ============================================
echo   北京城市更新政策问答 - GitHub Pages 部署
echo ============================================
echo.

:: 检查 Git 是否安装
where git >nul 2>&1
if %errorlevel% neq 0 (
    echo [错误] 未检测到 Git，请先安装 Git。
    echo 下载地址: https://git-scm.com/download/win
    pause
    exit /b 1
)

echo [✓] Git 已安装
echo.

:: 获取当前目录
set "DEPLOY_DIR=%~dp0"
cd /d "%DEPLOY_DIR%"

:: 检查是否已经是 Git 仓库
if exist ".git" (
    echo [✓] 检测到已有 Git 仓库
    echo.
    goto :push
)

:: 初始化 Git 仓库
echo [*] 正在初始化 Git 仓库...
git init
if %errorlevel% neq 0 (
    echo [错误] Git 初始化失败
    pause
    exit /b 1
)
echo [✓] Git 仓库初始化完成
echo.

:: 配置用户信息（如果未配置）
git config user.name >nul 2>&1
if %errorlevel% neq 0 (
    echo [*] 请配置 Git 用户信息:
    set /p GIT_NAME="请输入您的姓名: "
    set /p GIT_EMAIL="请输入您的邮箱: "
    git config user.name "%GIT_NAME%"
    git config user.email "%GIT_EMAIL%"
    echo [✓] Git 用户信息已配置
    echo.
)

:: 添加所有文件
echo [*] 正在添加文件到暂存区...
git add .
if %errorlevel% neq 0 (
    echo [错误] 添加文件失败
    pause
    exit /b 1
)
echo [✓] 文件已添加
echo.

:: 提交
echo [*] 正在提交...
git commit -m "Initial commit: 北京城市更新政策问答 PWA"
if %errorlevel% neq 0 (
    echo [警告] 提交可能没有新内容，继续推送...
)
echo [✓] 提交完成
echo.

:push
:: 检查远程仓库
git remote -v | findstr "origin" >nul 2>&1
if %errorlevel% neq 0 (
    echo [*] 未检测到远程仓库
    echo.
    echo 请先在 GitHub 上创建仓库:
    echo   1. 访问 https://github.com/new
    echo   2. 仓库名称建议: beijing-urban-renewal-policy-qa
    echo   3. 不要勾选 "Add a README file"
    echo   4. 不要勾选 ".gitignore"
    echo   5. 创建后复制仓库 URL
    echo.
    set /p REPO_URL="请输入 GitHub 仓库 URL (如 https://github.com/用户名/仓库名.git): "
    git remote add origin "%REPO_URL%"
    if %errorlevel% neq 0 (
        echo [错误] 添加远程仓库失败
        pause
        exit /b 1
    )
    echo [✓] 远程仓库已添加
    echo.
)

:: 设置默认分支为 main
git branch -M main

:: 推送
echo [*] 正在推送到 GitHub...
echo.
git push -u origin main
if %errorlevel% neq 0 (
    echo.
    echo [错误] 推送失败，请检查:
    echo   1. 网络连接是否正常
    echo   2. GitHub 仓库 URL 是否正确
    echo   3. 是否有仓库写入权限
    echo.
    pause
    exit /b 1
)

echo.
echo ============================================
echo   ✓ 部署成功！
echo ============================================
echo.
echo 接下来:
echo   1. 访问你的 GitHub 仓库页面
echo   2. 点击 Settings ^> Pages
echo   3. Source 选择 "GitHub Actions"
echo   4. 等待 Actions 自动部署完成
echo   5. 访问 https://你的用户名.github.io/仓库名/
echo.
echo 详细说明请查看 deploy_github.md
echo.
pause
