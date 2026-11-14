# @brightmeows/pi-git-attribution

只对 agent 通过 Pi shell 工具产生的提交自动追加署名：不改命令文本、不改仓库文件、不覆盖仓库 hooks。

## 行为

- 覆盖 bash 与 powershell 工具，spawnHook 向每次命令注入临时 `core.hooksPath`，内含生成的 `prepare-commit-msg` 与全量委托脚本
- 原 hook 始终先执行（失败仍中止提交），再按 merge 与 squash 跳过、规范化旧 agent 署名、追加 trailer
- `Generated-By: pi <版本> (<模型> @ <provider>, reasoning=<档位>)` 恒注入
- `Co-Authored-By` 默认关闭，配置后才注入；注入前按配置邮箱与已知 agent 模式清理历史 agent 署名行，人类 co-author 与其他 trailer 保留
- 会话结束删除临时目录，仓库零改动

## 配置（可选）

全局 `<agent dir>/git-attribution.json`，仓库 `<repo>/.pi/git-attribution.json` 覆盖全局，字段级合并，session_start 读取：

```json
{ "coAuthor": { "name": "你的名字", "email": "you@example.com" } }
```

`name` 与 `email` 都配置才启用 Co-Authored-By。

## 退出

- 会话级：`PI_GIT_ATTRIBUTION=0`（false、no、off 同效）
- 仓库级：`git config --local pi.attribution false`

## 安装

```bash
pi install npm:@brightmeows/pi-git-attribution
```

## 边界

`git commit-tree`、`git revert`、`git am`、rebase 内部提交通常不触发 prepare-commit-msg；`env -i`、不带 `-E` 的 sudo、清空环境变量的容器不会注入。另一个扩展若在本扩展之后覆盖 bash 与 powershell，spawnHook 会失效。Windows PowerShell 需在 Windows 上实测。

## 适配版本

实测 pi 1.5.2。hook 脚本行为由真 git 集成测试覆盖（`pnpm test`）。

## License

MIT
