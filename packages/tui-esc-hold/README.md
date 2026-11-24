# @brightmeows/pi-tui-esc-hold

Esc 防误触：单击 Esc 只提示不中断，双击或长按才放行。

## 行为

- 运行中（等待模型、工具执行、自动重试、自动压缩）：单击吞掉并底部提示；双击（800ms 内）或长按放行，中断对话或取消重试与压缩
- 运行中出现阻塞式扩展对话框：单击吞掉，提示改为“双击 Esc 取消对话框”；双击交给对话框原生取消（问卷取消提问，run 继续）
- 空闲时完全放行：双击开对话树、关闭选择器、取消补全等原生行为原样保留
- 场景切换时重置按键周期，一次按住周期只放行一次

## 终端兼容

支持 Kitty 键盘协议的终端（kitty、alacritty 0.13+、wezterm 等）按 repeat 与 release 事件精确区分长按与松开；传统终端按重复字节退化识别。

## 安装

```bash
pi install npm:@brightmeows/pi-tui-esc-hold
```

## 适配版本

实测 pi 1.6.0。

## License

MIT
