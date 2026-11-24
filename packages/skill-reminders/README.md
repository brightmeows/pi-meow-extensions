# @brightmeows/pi-skill-reminders

带专项提醒的技能文档被读取或写入时，把提醒段注入 LLM 上下文。

## 通道

- read、edit、write 的 `input.path` 命中注册项时，提醒段拼进 tool_result 尾部
- bash 与 powershell 命令的白名单启发式（cat 等纯读取命令在列），经回合边界条目投递，codemode 嵌套下不丢
- `/skill:<name>` 手动命令命中时拼到输入文本尾部，先于 Pi 技能展开

## 去重与守卫

持久去重按内容 hash 为权威键，同一段提醒跨文件只进一次上下文；compact 后标记消失，回到可注入态。存在性守卫探测目标技能是否安装，未安装整条静默跳过。

## 注册表

提醒内容数据驱动，见 `internal/reminders.ts`：一条提醒一个注册项，命中判断加条目正文，新增提醒只追加注册项。内置注册项是作者的自用条目，经存在性守卫对未安装相应技能的用户完全无感；按同格式追加自己的条目即可。

## 安装

```bash
pi install npm:@brightmeows/pi-skill-reminders
```

## 适配版本

实测 pi 1.6.0。

## License

MIT
