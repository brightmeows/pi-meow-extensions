# @brightmeows/pi-inline-context

在会话开始与每轮请求前注入环境摘要，让模型带着当下环境干活。

## 注入内容

- 日期：每轮现算，跨天自动更新
- 系统环境：会话内一次，含 OS、WSL、SSH、提权、代理 TUN 信号，只陈述事实不带操作指南
- Git 快照：remote（URL 剥 userinfo 凭据后才注入）、dirty 数、ahead-behind、stash、进行中操作、最近提交；resume 自动重算，行尾标注快照过期语义
- 工具与 gh：检测 fd、rg 等已装 CLI 与 gh 登录账号，未安装自动省略

完整信息走结构化提示段 `sections.inline_context`，另投一条单行摘要 message 供 TUI 可见。全部检测异步预计算，不阻塞首条消息。

## 安装

```bash
pi install npm:@brightmeows/pi-inline-context
```

## 适配版本

实测 pi 1.6.0。

## License

MIT
