# @brightmeows/pi-tui-editor-input-tweaks

编辑器输入增强：`/` 与 `@` 标记符着色，`/` 补全选中后停留输入框。

## 功能

- 标记符着色：行首 `/` 命令标记符黄色，token 开头的 `@` 文件引用标记符蓝色，只染标记符单字符，参数保持默认色
- 补全停留：`/` 命令补全按 enter 选中后不直接执行，再按一次 enter 才提交，避免手滑触发命令
- 纯视觉保证：着色只在渲染输出层注入 ANSI 颜色码，不触碰纯文本状态，pi 的命令与引用触发全部不受影响

## 安装

```bash
pi install npm:@brightmeows/pi-tui-editor-input-tweaks
```

## 编辑器槽位独占

本扩展接管主编辑器组件（`ctx.ui.setEditorComponent` 全局单例，后设覆盖先设）。其他需要替换编辑器的扩展与本包互斥，须链式包装或并入本包。

## 版本敏感性

渲染主体按 pi 编辑器内部结构等价重写（grapheme 遍历、假光标注入、鼠标命中计数），跨 pi 升级必须实测复核。当前实测 pi 1.6.0。

## License

MIT
