#!/usr/bin/env bash
# 给 packages/ 下所有已发布包配置 npm Trusted Publishing（GitHub Actions）
#
# 前提：npm >= 11.15、账号已启用 2FA、包已在 registry 上存在。
# 认证：不接受 bypass-2FA 的 granular token，必须用交互式登录（npm login）。
# 首次 npm trust 会触发 2FA，网页上可勾选「跳过 2FA 5 分钟」，此后本脚本
# 的其余调用在窗口内无需重复验证。
set -euo pipefail

cd "$(dirname "$0")/.."

REPO="${REPO:-brightmeows/pi-meow-extensions}"
WORKFLOW="${WORKFLOW:-release.yml}"
REGISTRY="https://registry.npmjs.org/"

for dir in packages/*/; do
  name=$(node -p "require('./${dir}package.json').name")
  if ! npm view "$name" version --registry "$REGISTRY" >/dev/null 2>&1; then
    echo "跳过 $name：registry 上不存在"
    continue
  fi
  if npm trust list "$name" --registry "$REGISTRY" 2>/dev/null | grep -q "github"; then
    echo "$name：已有 trusted publisher，跳过"
    continue
  fi
  echo "配置 $name"
  npm trust github "$name" \
    --file "$WORKFLOW" \
    --repo "$REPO" \
    --allow-publish \
    --yes
  sleep 2
done

echo "完成。核对："
npm trust list "$(node -p "require('./packages/aliases/package.json').name")"
