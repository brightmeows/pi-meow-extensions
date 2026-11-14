---
description: pi-meow-extensions 仓库维护约定与运行时验证方法
tags: [pi, extensions, typescript, npm]
---

# pi-meow-extensions（面向代理）

brightmeows 的 pi 扩展 monorepo：`packages/` 下每目录一个独立发布的 npm 包（`@brightmeows/pi-*`）。
约定优先级：本文件 > 各文件头部注释（即设计文档，修改前完整读取）> 各包 README > 官方文档 `extensions.md` 与 `packages.md`。

## 命令

| 命令 | 用途 |
|---|---|
| `pnpm check` | pi 运行时漂移检查 + `tsc --noEmit`（最小验证 gate） |
| `pnpm check:pi` | 仅漂移检查（pi 三包与 typebox 精确锁，随 pi 运行时升级同步） |
| `pnpm lint` / `pnpm lint:fix` | oxlint |
| `pnpm format` / `pnpm format:check` | oxfmt |
| `pnpm test` | `node:test`（ask-user-question、git-attribution，含真 git 集成测试） |
| `pnpm install` | 装 hook（`prepare` 写 `core.hooksPath .githooks`） |

## 包约定

- 一包一扩展，完全自包含：包间零 import，需复用的模块各包自备副本，无同步义务；目录名用语义短名，不跟包名走
- 入口 `index.ts`，必须 `export default function (pi)`（仅命名导出加载报错）；包内纯库归 `internal/`
- 包名规则 `pi-<域>-<名>`：域词表 tui / git / models / skills / ask / herdr；域已在名首则不再重复标（git-hooks、models-dev、skill-reminders、herdr-blocked 即此形态）
- keywords 固定含 `pi-package` 加域词；description 一句话中文；发布物 TS 源码直发（pi 用 jiti 加载），`files` 白名单排除 `*.test.ts`
- 各文件头部注释即设计文档：改动前完整读取，改动后同步更新（含包内模块）
- 新增包五件事：建目录；按既有包模板写 `package.json`；补 README；在 `release-please-config.json` 与 `.release-please-manifest.json` 登记（漏登记则该包永不发版）；`pnpm install`
- 摸 pi 内部结构的包（monkey-patch、私有成员、渲染接管）必须在 README 版本敏感性一节写明，升级 pi 后 tmux 实测

## fork 政策（ask-user-question）

`@brightmeows/pi-ask-user-question` 是 `@juicesharp/rpiv-ask-user-question@2.15.0` 的冻结 fork：
不整体跟上游，按需吸收单个补丁并记录进 `docs/ask-user-question-limits.md`；上游 tests 不带，本地 `node:test` 覆盖。
改动语义以包内 `index.ts` 头注释与该文档为准。

## 版本与发布

- release-please manifest 模式：Conventional Commits 进 main 后自动维护 release PR，合并即打 tag、建 GitHub Release 并 npm publish（provenance）
- 版本语义按 crates.io 惯例：0.x 的 minor 既是新功能位也是依赖方眼中的破坏线（Cargo 把 `^0.1.0` 解为 `>=0.1.0 <0.2.0`）
- 落到 release-please 就是 feat 走 minor、fix 走 patch、breaking 走 minor 而不跳 1.0.0，配置只开 `bump-minor-pre-major`
- 不要加 `bump-patch-for-minor-pre-major`：那是 patch-only 派（feat 也落 patch），会让 minor 退化成只表示破坏，与上述语义相反
- manifest 基线 0.0.0 表示尚未发布；但 release-please 会把 0.0.0 视作占位符而走 bootstrap（默认 1.0.0），故首发用顶层 `release-as` 锁版本
- `release-as` 只在需要强制某次版本号时使用，该次 release PR 合并后必须立刻删除，否则后续每次发版都会重复用同一版本
- 禁止手改 `packages/*/package.json` 的 `version`：版本号由 release PR 统一 bump，`.release-please-manifest.json` 是版本记录源
- pi 对带 `CHANGELOG.md` 的包会在更新时弹 Extension Updates 提示；changelog 由 release-please 生成，不手写
- `publishConfig.registry` 固定官方源：本机 npmrc 指镜像（npmmirror）不影响发布
- npm 认证走 GitHub Secrets 的 `NPM_TOKEN`（granular automation token）；本地发布调试用 `npm publish --dry-run`

## 检查门禁与棘轮

- 提交须过 pre-commit（format、lint、漂移检查、md 检查，单测按改动路径触发）；失败先本地修，不绕过
- `pnpm check` 只保证类型与版本一致，不验证运行时行为；扩展代码的提交正文须记录运行时实测（命令与结果）
- oxlint overrides 是存量热点棘轮（subdir-agents-md、skill-reminders、models-dev、inline-context 的复杂度放宽与 ask-user-question 的上游风格豁免）：只许收紧删除，不许放松；触碰重构后从 overrides 移除对应条目

## 运行时验证

- 隔离加载本仓副本：`pi -p -ne -e packages/<name>/index.ts --no-session "只回复：收到"`；不带 `-ne` 会与 settings 注册的 npm 安装副本冲突，工具覆盖类扩展直接报 Tool conflicts
- 对比验证（行为回归）：从 git 检出旧版到 /tmp，两边分别跑 dump，diff 落盘产物；对比前移走 npm 安装副本 `~/.pi/agent/npm/node_modules/@brightmeows/<pkg>/`，否则双重改写失真
- 验证 before_agent_start 类改写：pi 无 dump 系统提示词命令，须 `-e <被测扩展> -e <dump 扩展>`（dump 在后），配 `--no-session`
- TUI 渲染验证：`-p` headless 不走 TUI，须 tmux 交互会话触发，`tmux capture-pane -p -e` 捕获带 ANSI 画面 grep
- tmux 实测会污染持久化状态（ctrl+t、/statusline 等开关经 settingsManager 写回 settings.json）：测完复位原值，或 `PI_CODING_AGENT_DIR=$(mktemp -d)` 软链 auth.json 与 models.json 彻底隔离
- 块注释内禁含 `*/` 序列（TS1443、oxfmt 语法错）；写路径如 `*/index.ts` 时改写避让
- pi 二进制经 bun 打包，未初始化的字段声明会被丢弃：探测 private 成员用 `in` 加运行时守卫，勿把 d.ts 可选成员纳入硬性自检
- reload 幂等的扩展（statusline、thinking-flow）用 globalThis Symbol 槽存原生方法引用，新扩展沿用此模式
- 自用更新通道：settings 注册 `npm:@brightmeows/pi-*`（无版本 pin，registry 有新版即重装）；发版后重启拾取，`pi list` 看安装版本

## 仓库与镜像

- GitHub 主仓 brightmeows/pi-meow-extensions，Codeberg 镜像同名；本地双远端，push 后 `git push codeberg main` 同步
