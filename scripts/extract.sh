#!/usr/bin/env bash
# 用法: extract.sh <视频路径> [输出目录]
# 依赖: ffmpeg, ffprobe
set -euo pipefail
F="$1"; D="${2:-/tmp/video_breakdown}"
command -v ffmpeg >/dev/null || { echo "需要 ffmpeg"; exit 1; }
mkdir -p "$D"

echo "== 基础信息 =="
ffprobe -v error -show_entries format=duration:stream=codec_type,width,height,r_frame_rate -of compact "$F"
DUR=$(ffprobe -v error -show_entries format=duration -of csv=p=0 "$F")

echo "== 剪辑点 (scene>0.08，无输出=一镜到底) =="
ffmpeg -v info -i "$F" -vf "select='gt(scene,0.08)',showinfo" -f null - 2>&1 \
  | grep -o 'pts_time:[0-9.]*' | tr '\n' ' ' || true
echo

echo "== 静音段 (台词停顿) =="
ffmpeg -v info -i "$F" -af silencedetect=n=-35dB:d=0.3 -f null - 2>&1 \
  | grep -oE 'silence_(start|end): [0-9.]+' | tr '\n' ' ' || true
echo

echo "== 联系表 =="
ffmpeg -v error -y -i "$F" -vf "fps=1,scale=360:-1,tile=7x$(( ( ${DUR%.*} + 7 ) / 7 ))" -frames:v 1 "$D/grid_full.jpg"
i=0; s=0
while (( s < ${DUR%.*} + 1 )); do
  i=$((i+1))
  ffmpeg -v error -y -ss "$s" -i "$F" -t 12 -vf "fps=2,scale=300:-1,tile=6x4" -frames:v 1 "$D/grid_part$i.jpg"
  s=$((s+12))
done
ls "$D"/grid_*.jpg
