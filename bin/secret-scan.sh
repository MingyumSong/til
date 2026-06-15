#!/usr/bin/env bash
# Public 저장소 푸시 전 기밀·민감정보 자동 검사 (git pre-push 훅으로 사용).
# /til 스킬의 점검과 별개의 이중 안전망 — 손으로 push 하거나 bash til로 쓴 글도 검사한다.
# 오탐이라 확신하면 우회: git push --no-verify
set -uo pipefail

root="$(git rev-parse --show-toplevel)" || exit 0
cd "$root" || exit 0

# 추적 중인 파일 (스캐너 자신은 제외 — 패턴 문자열이 자기 자신에 걸리지 않도록)
files=$(git ls-files -- . ':(exclude)bin/secret-scan.sh')
[ -z "$files" ] && exit 0

# "정규식|설명" 목록
patterns=(
  'sk-[A-Za-z0-9_-]{16,}|LLM/OpenAI API 키'
  'AKIA[0-9A-Z]{16}|AWS 액세스 키'
  'gh[oprsu]_[A-Za-z0-9]{20,}|GitHub 토큰'
  'xox[baprs]-[A-Za-z0-9-]+|Slack 토큰'
  'BEGIN [A-Z ]*PRIVATE KEY|개인키(PEM)'
  '(api[_-]?key|secret|password|passwd|access[_-]?token)["'"'"' ]*[:=]["'"'"' ]*[^[:space:]"'"'"']{8,}|시크릿/비밀번호 추정'
  '(redshift|postgresql|postgres|mysql|mongodb)://[^[:space:]]+|DB 커넥션 스트링'
  '\b(10\.[0-9]{1,3}|192\.168|172\.(1[6-9]|2[0-9]|3[01]))\.[0-9]{1,3}\.[0-9]{1,3}\b|사설 IP'
  'datastream\.co\.kr|내부 호스트(datastream)'
  'medistream\.co\.kr|회사 이메일/도메인'
)

hits=0
for entry in "${patterns[@]}"; do
  pat="${entry%%|*}"
  desc="${entry##*|}"
  if matches=$(grep -InE "$pat" $files 2>/dev/null); then
    echo "⛔ [$desc] 의심 패턴:"
    echo "$matches" | sed 's/^/   /'
    hits=1
  fi
done

if [ "$hits" -ne 0 ]; then
  echo ""
  echo "푸시 중단. 위 내용을 일반화/삭제 후 다시 시도하세요."
  echo "오탐 확신 시: git push --no-verify"
  exit 1
fi
exit 0
