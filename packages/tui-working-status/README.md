# @brightmeows/pi-tui-working-status

把流式期间的 Working 指示行改为随 agent 生命周期切换的状态文案，全状态带持续计时。

## 状态机

- `agent_start` 后显示“准备请求”
- 请求发出显示“发送请求 N KB”，失败重试附重试序号
- 请求体写完（undici 诊断事件）显示“等待模型响应”
- 首个流式事件显示“生成中”
- 工具执行显示“执行工具 X”，嵌套调用回退父工具名
- `agent_end` 复位内置默认文案

计时按状态切换重锚定，整秒节奏不漂移。

## 安装

```bash
pi install npm:@brightmeows/pi-working-status
```

## 边界

状态样例基于事件面三段切分（发出前、响应头到达、首个流式事件），连接与上传过程对 JS 层不可见，以 undici 诊断通道补足；无诊断通道的运行时走响应事件兜底。实测 pi 1.6.0。

## License

MIT
