# @brightmeows/pi-tui-statusline

自定义三行状态栏 footer 加输入框下边框流式速度显示。

## 布局

- 行 1 pwd：左为目录（home 缩写）、分支、会话名，右为提供商、模型与思考档位
- 行 2 stats：左为 token 用量、缓存、费用，右为上下文占比与窗口标记
- 行 3 扩展状态行：承接 `ctx.ui.setStatus`，其他扩展的状态提示经此行显示

下边框在流式期间显示“平均 N 与当前回合 tok/s”，空闲时只留平均段，滚动提示优先。数据在回合结束时按精确 usage 校准。

## 行为

- 默认启用，`/statusline` 命令切回内置 footer，开关状态持久化
- reload 幂等；usage 聚合按签名缓存，避免重复全量扫描

## 已知省略

内置 footer 有而本版省略：虚拟模型路由显示与订阅半边标记（数据源扩展侧不可达）。

## 安装

```bash
pi install npm:@brightmeows/pi-tui-statusline
```

## 版本敏感性

下边框经 monkey-patch `CustomEditor` 的渲染方法实现，footer 依赖 pi 内部组件结构，跨 pi 升级必须 tmux 实测复核。当前实测 pi 1.5.2。

## License

MIT
