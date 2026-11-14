# @brightmeows/pi-git-hooks

会话启动时检测当前仓库的 git hooks 配置状态，缺失时自动补配并提示。

## 行为

- 仓库根 `.githooks/` 含可执行脚本且 `core.hooksPath` 未设时，补设为 `.githooks`（项目自定义 hooks 约定优先）
- 仓库根有 `.pre-commit-config.yaml` 且系统装有 pre-commit 命令时，hook 未安装则运行 `pre-commit install`；工具缺失静默跳过
- 两功能互斥锚定：`core.hooksPath` 已设时 pre-commit install 上游拒绝执行，githooks 命中即完成分流
- 已就绪零输出；激活与失败提示走独立 widget 槽，激活 8 秒自动清除，失败不自动清；非 tui 模式打一行摘要到 stderr
- 幂等：`/new`、`/reload` 重绑会话时重检测补挂；hooks 目录用 `--git-path hooks` 解析，兼容 worktree

## 边界

仅 session_start 检测一次，会话中途 cd 到其他仓库不检测；Windows 无执行位语义，可执行判定退化为“目录含文件”。

## 安装

```bash
pi install npm:@brightmeows/pi-git-hooks
```

## 适配版本

实测 pi 1.5.2。

## License

MIT
