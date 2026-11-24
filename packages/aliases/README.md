# @brightmeows/pi-aliases

斜杠命令别名：把顺手的名字映射到 Pi 内置命令。

## 功能

- `/clear` 映射到 `/new`：清空会话走新建语义
- `/exit` 映射到 `/quit`

实现在 `command-aliases.ts`，注册表形态，加别名就是加一行映射。

## 安装

```bash
pi install npm:@brightmeows/pi-aliases
```

或在 `~/.pi/agent/settings.json` 的 `packages` 数组加 `"npm:@brightmeows/pi-aliases"`。

## 适配版本

实测 pi 1.6.0。

## License

MIT
