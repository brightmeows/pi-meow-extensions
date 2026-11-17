#!/usr/bin/env bash
# 给 packages/ 下所有已发布包配置 npm Trusted Publishing（GitHub Actions）
#
# 前提：npm >= 11.15、账号已启用 2FA（WebAuthn）、包已在 registry 上存在。
# 认证：不接受 bypass-2FA 的 granular token，必须交互式 2FA。
# 首次 trust 会在浏览器要求认证，认证页可勾选「跳过 2FA 5 分钟」，
# 之后本脚本的其余调用在窗口内无需重复验证。
set -uo pipefail

cd "$(dirname "$0")/.."

REPO="${REPO:-brightmeows/pi-meow-extensions}"
WORKFLOW="${WORKFLOW:-release.yml}"
REGISTRY="https://registry.npmjs.org/"

for dir in packages/*/; do
  name=$(node -p "require('./${dir}package.json').name")
  echo "== 配置 $name"
  npm trust github "$name" \
    --file "$WORKFLOW" \
    --repo "$REPO" \
    --allow-publish \
    --registry "$REGISTRY" \
    --yes || echo "   （未完成，稍后可重跑本脚本，已配置的会报已存在）"
  sleep 2
done

echo "全部执行完毕。"
