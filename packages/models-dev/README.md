# @brightmeows/pi-models-dev

models.dev 模型目录导入：协议感知注册、用户配置过滤与覆盖。

## 行为

- 拉取 models.dev 目录（24 小时缓存，离线守卫与刷新合流），按协议判定注册 provider 与模型
- 与内建重名的 provider 走 legacy 注册保留内建 auth 与登录，并按 `id|api` 合并内建 compat 与档位映射；非重名走原生注册，接平台刷新与持久化
- 用户配置 `~/.pi/agent/models-dev.json`（不存在按全量注册运行）：provider 与模型级 `disabled` 黑名单、`api` 与 `baseUrl` 覆盖、救活被协议判定跳过的 provider

优先级：pi 原生 `models.json` 中显式声明的 provider 受保护（本扩展跳过），模型级 `modelOverrides` 直接生效。

```json
{
  "providers": {
    "<provider-id>": {
      "disabled": false,
      "api": "openai-responses",
      "baseUrl": "https://gw.example.com/v1",
      "models": { "<model-id>": { "disabled": false, "api": "openai-completions", "name": "显示名" } }
    }
  }
}
```

`api` 合法值：anthropic-messages、openai-completions、openai-responses、google-generative-ai、google-vertex、bedrock-converse-stream。配置语法或校验失败时告警并按无配置运行，不崩溃。

## 安装

```bash
pi install npm:@brightmeows/pi-models-dev
```

## 适配版本

实测 pi 1.5.2。

## License

MIT
