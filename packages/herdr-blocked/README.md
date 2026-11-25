# @brightmeows/pi-herdr-blocked

把 Pi 的阻塞态对话框翻译成 herdr 的 blocked 上报，修“等人时侧栏停在 working”的缺口。

## 背景

herdr 官方 pi 集成只听共享总线上的 `herdr:blocked` 事件，但 pi 侧没有内置来源 emit 它：ask-user-question 等扩展对话框等人时，herdr 侧栏停留在 working。pi 原生 OSC 7501 程序状态协议 herdr 0.9.1 不解析。

## 行为

- 监听 `ui_prompt_start` 与 `ui_prompt_end`（pi 对 select、confirm、input、editor、custom 五类阻塞式对话框的生命周期包装），换算成 `herdr:blocked` 事件，start 与 end 严格配对，嵌套对话框不早释
- label 取对话框 title；问卷弹窗回退到 ask-user-question 广播的问题清单首条
- `HERDR_ENV`、`HERDR_SOCKET_PATH`、`HERDR_PANE_ID` 三重门控，herdr 环境外零行为

## 安装

```bash
pi install npm:@brightmeows/pi-herdr-blocked
```

## 适配版本

pi 1.6.0，herdr 0.9.5。

## License

MIT
