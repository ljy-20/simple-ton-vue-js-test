#!/usr/bin/env sh

# 构建项目
npm run build

# 进入构建后的文件夹
cd dist

# 初始化 Git 并提交代码
git init
git add -A
git commit -m 'deploy'

# 推送到 GitHub Pages 分支
# 替换 <username> 和 <repository> 为你的 GitHub 用户名和仓库名
git push -f git@github.com:ljy-20/simple-ton-vue-js-test.git master:gh-pages

cd -