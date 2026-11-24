# @brightmeows/pi-subdir-agents-md

子目录规则文件懒加载：代理访问某个路径时，发现并注入管辖该路径的子目录 AGENTS.md。Pi 默认只向上加载规则，不向下递归；上游已确认不进核心，扩展是官方认可的实现位置。

## 行为

- 触发：结构化工具的 `input.path` 加 bash 与 powershell 命令的白名单启发式，双通道收集被访问路径
- 投递：回合边界统一处理，短通知与全文两条 custom_message 条目，codemode 嵌套下脚本不回传内容时仍保证送达
- 去重三路：会话实例集、会话库扫描标记、与 Pi 原生已加载内容的基准判定（嵌套 worktree 副本不重复注入）
- 代理读取规则文件本身时标记已返回，不再重复注入；compact 后标记消失，允许重新注入

## 安装

```bash
pi install npm:@brightmeows/pi-subdir-agents-md
```

## 版本敏感性

原生基准判定依赖 `ctx.getSystemPrompt()` 返回的会话系统提示词口径，跨 pi 升级需复核。当前实测 pi 1.6.0。

## License

MIT
