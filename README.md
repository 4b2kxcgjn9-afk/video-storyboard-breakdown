# video-storyboard-breakdown

一个通用的 Agent Skill：把参考视频（.mp4 / .mov）拆解成可以直接投喂 AI 生图、生视频工具（即梦、可灵、Runway、Midjourney 等）的 **AIGC 制作提示词包**。

## 产出内容

- **原片拆解**：规格、一镜到底/多镜判断、梗概、笑点/情绪结构、时间轴、视觉锚点
- **全局风格锚**：真人实拍质感 + 相机参数（正向 + 负向）
- **资产提示词**：`@角色` 三视图、`@场景` 空景、`@站位参考`、`@道具`
- **7 列高密度分镜表**：镜号 / 景别 / 运镜 / 画面内容 / 声音对白 / 时长 / 备注教学点
- **声音设定**、时长汇总、制作提醒

## 发给任何 AI 代理直接用（无需安装）

`AGENT.md` 是一份独立完整的指令，合并了全部流程、规范和示例。不能运行命令、只能看图或看视频的代理，它也教了对应的读片方法。

把下面这段话连同视频一起发给任意代理（ChatGPT、Gemini、Claude、Cursor 等）：

> 先读这份指令并严格照做：https://raw.githubusercontent.com/4b2kxcgjn9-afk/video-storyboard-breakdown/main/AGENT.md
> 然后拆解我发的这个视频，给我分镜提示词。

如果对方打不开链接，就把 `AGENT.md` 的全文复制给它。

## 作为 Skill 安装（Claude Code / Codex）

```bash
git clone https://github.com/4b2kxcgjn9-afk/video-storyboard-breakdown.git ~/.agents/skills/video-storyboard-breakdown

# Claude Code
ln -s ~/.agents/skills/video-storyboard-breakdown ~/.claude/skills/video-storyboard-breakdown
# Codex
ln -s ~/.agents/skills/video-storyboard-breakdown ~/.codex/skills/video-storyboard-breakdown
```

其他支持 `SKILL.md` 格式的 agent，把这个目录放进它的 skills 目录即可。

**依赖**：`ffmpeg` / `ffprobe`，以及能查看图片的 agent（用来读联系表）。

## 使用

对 agent 说：

> 「/path/to/video.mp4 拆解一下这个视频，给我分镜提示词」

只在提供了视频文件、并要求拆解或复刻时触发；从剧本或创意写分镜时不触发。

也可以单独运行抽帧脚本：

```bash
bash scripts/extract.sh video.mp4 /tmp/out
```

## 文件结构

| 文件 | 说明 |
|---|---|
| `AGENT.md` | 通用单文件版本，可以直接发给任何代理 |
| `SKILL.md` | 触发条件、流程清单、硬性规则 |
| `REFERENCE.md` | 风格锚、资产、分镜表、声音的详细规范 |
| `EXAMPLES.md` | 产出示例 |
| `scripts/extract.sh` | 基础信息、剪辑点、台词停顿、联系表 |

## 许可

MIT
