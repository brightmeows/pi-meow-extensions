/**
 * Pi 内置 createMarkdownTransform 的包内副本。
 *
 * 依据：该工厂在 pi 内部模块 markdown-transform.js 中，未从
 * @earendil-works/pi-coding-agent 公开导出；ext 家规"各包自包含，
 * 需复用的模块自备副本"。逻辑与 pi 1.6.0 源码对齐：
 * 按序应用 transformer 管道，单只 transformer 抛错时保留当前文本继续；
 * context 同步 1.6.0 新增的可选 messageId/timestamp。
 */

import type {
  MarkdownTransformContext,
  MarkdownTransformer,
} from "@earendil-works/pi-coding-agent";

interface CreateMarkdownTransformOptions {
  messageType: MarkdownTransformContext["messageType"];
  isStreaming: boolean;
  transformers: readonly MarkdownTransformer[];
  messageId?: string | undefined;
  timestamp?: string | undefined;
}

export function createMarkdownTransform({
  messageType,
  isStreaming,
  transformers,
  messageId,
  timestamp,
}: CreateMarkdownTransformOptions): (markdown: string, availableWidth: number) => string {
  return (markdown: string, availableWidth: number) =>
    applyMarkdownTransformers(
      markdown,
      {
        messageType,
        isStreaming,
        availableWidth,
        ...(messageId !== undefined ? { messageId } : {}),
        ...(timestamp !== undefined ? { timestamp } : {}),
      },
      transformers,
    );
}

function applyMarkdownTransformers(
  markdown: string,
  context: MarkdownTransformContext,
  transformers: readonly MarkdownTransformer[],
): string {
  let transformedMarkdown = markdown;
  for (const transformer of transformers) {
    try {
      const transformed = transformer(transformedMarkdown, context);
      if (typeof transformed === "string") {
        transformedMarkdown = transformed;
      }
    } catch {
      // Keep the current Markdown and continue with the next transformer.
    }
  }
  return transformedMarkdown;
}
