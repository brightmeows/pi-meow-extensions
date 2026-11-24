# pi-meow-extensions

brightmeows 的 [Pi Coding Agent](https://pi.dev) 扩展集合：`packages/` 下每目录一个独立发布的 npm 包，scope 统一 `@brightmeows/pi-*`。

## 包一览

| 包 | 目录 | 说明 |
| --- | --- | --- |
| [`@brightmeows/pi-aliases`](./packages/aliases) | aliases | 斜杠命令别名 |
| [`@brightmeows/pi-ask-user-question`](./packages/ask-user-question) | ask-user-question | 结构化问卷工具（上游 fork，题数上限移除） |
| [`@brightmeows/pi-tui-editor-input-tweaks`](./packages/tui-editor-input-tweaks) | tui-editor-input-tweaks | 编辑器输入增强：标记符着色与补全停留 |
| [`@brightmeows/pi-tui-esc-hold`](./packages/tui-esc-hold) | tui-esc-hold | Esc 防误触：双击或长按才中断 |
| [`@brightmeows/pi-git-attribution`](./packages/git-attribution) | git-attribution | agent 提交自动署名 |
| [`@brightmeows/pi-git-hooks`](./packages/git-hooks) | git-hooks | 仓库 git hooks 自动配置 |
| [`@brightmeows/pi-herdr-blocked`](./packages/herdr-blocked) | herdr-blocked | herdr blocked 态上报桥接 |
| [`@brightmeows/pi-inline-context`](./packages/inline-context) | inline-context | 会话环境摘要注入 |
| [`@brightmeows/pi-models-dev`](./packages/models-dev) | models-dev | models.dev 模型目录导入 |
| [`@brightmeows/pi-skill-reminders`](./packages/skill-reminders) | skill-reminders | 技能专项提醒注入 |
| [`@brightmeows/pi-tui-statusline`](./packages/tui-statusline) | tui-statusline | 状态栏 footer 与流式速度 |
| [`@brightmeows/pi-subdir-agents-md`](./packages/subdir-agents-md) | subdir-agents-md | 子目录规则懒加载注入 |
| [`@brightmeows/pi-tui-thinking-flow`](./packages/tui-thinking-flow) | tui-thinking-flow | thinking 呈现接管 |
| [`@brightmeows/pi-working-status`](./packages/tui-working-status) | tui-working-status | Working 行多状态计时文案 |

## 安装

```bash
pi install npm:@brightmeows/pi-tui-esc-hold
```

或在 `~/.pi/agent/settings.json` 的 `packages` 数组加 `"npm:@brightmeows/pi-xxx"`。逐包说明见各包 README。

## 开发

`pnpm install` 后 `pnpm check`、`pnpm lint`、`pnpm test`；发布走 release-please，约定见 [AGENTS.md](AGENTS.md)。

## License

MIT
