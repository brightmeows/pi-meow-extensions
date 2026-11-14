# @brightmeows/pi-tui-thinking-flow

接管 thinking 块的默认呈现：进行中的 thinking 完整渲染，历史的收起为一行占位，可点击展开。

## 两态

- flow 态（默认）：流式 thinking 随 Markdown 实时渲染，带上下标题行；历史 thinking 收起为一行彩色占位，显示字符数与 token 估算，鼠标点击展开单块
- expanded 态（ctrl+t 切换）：全部 thinking 完整渲染，持久化到设置

## 语义说明

内置 `hideThinkingBlock` 的语义被本扩展反转为“全量展示”：ctrl+t 与 `/settings` 的开关文案沿用内置（hidden 或 visible），与实际行为相反，以本说明为准。

## 安装

```bash
pi install npm:@brightmeows/pi-tui-thinking-flow
```

## 版本敏感性

实现方式为接管 `AssistantMessageComponent` 的渲染方法（pi 对 thinking 渲染暂无 replace 钩子），私有成员经形状守卫读取，结构不匹配时降级原生渲染不崩溃。跨 pi 升级必须 tmux 实测复核。当前实测 pi 1.5.2。

## License

MIT
