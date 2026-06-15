# 블로그 쓰는 법

> 이 저장소에 TIL 글을 쓰고 올리는 방법. 까먹으면 여기 보면 된다.
> 매번 하는 건 3단계뿐: **만들기 → 쓰기 → 올리기**

---

## 0. 처음 한 번만 (이미 했으면 건너뛰기)

`til` 명령을 현재 터미널에 적용:

```zsh
source ~/.zshrc
```

확인 — 사용법이 나오면 준비 끝:

```zsh
til help
```

(새로 여는 터미널은 자동 적용되니 다음부턴 이 단계 없음)

---

## 1단계. 새 글 만들기

작업하던 폴더 어디서든 실행:

```zsh
til <영문슬러그> "한글 제목" 태그1 태그2
```

예시:

```zsh
til redshift-zero-etl "Redshift Zero-ETL 동작 방식" redshift data-pipeline
```

- **슬러그** = 파일 이름에 쓸 영문 (소문자, 띄어쓰기 대신 `-`)
- **제목** = 한글 그대로, 따옴표로 묶기
- **태그** = 공백으로 구분, 여러 개 가능

→ `~/blog/posts/날짜-슬러그.md` 가 생기고 VS Code로 자동으로 열린다.
→ `project:` 에는 명령을 실행한 폴더 이름이 자동으로 들어간다 (어느 프로젝트에서 배웠는지 기록).

---

## 2단계. 글 쓰기

열린 파일에서:

1. 맨 위 frontmatter 확인 (title/date/tags/project 는 자동으로 채워져 있음)
2. `summary:` 에 한 줄 요약 채우기 (선택 — 나중에 목록에서 미리보기로 쓰임)
3. `## 오늘 배운 것` 아래에 본문 작성
4. 저장 (Cmd+S)

frontmatter 예시:

```markdown
---
title: "Redshift Zero-ETL 동작 방식"
date: 2026-06-15
tags: [redshift, data-pipeline]
project: data-catalog
summary: "DynamoDB 변경분이 Redshift로 자동 복제되는 구조"
draft: false
---
```

---

## 3단계. 올리기

```zsh
til push
```

- `~/blog` 의 모든 변경을 커밋하고 GitHub로 푸시한다 (한 방).
- 커밋 메시지를 직접 쓰려면: `til push "redshift til 추가"`
- 올라간 결과 확인: https://github.com/MingyumSong/til

**끝. 매번 이 3단계 반복.**

---

## 참고: 상황별

### 아직 안 끝난 글 (초안)
- frontmatter의 `draft: false` 를 `draft: true` 로 바꿔두면, 나중에 사이트로 만들 때 빠진다.
- 또는 `posts/` 대신 `drafts/` 폴더에 둬도 된다.

### `til` 명령 없이 손으로 쓰고 싶을 때
1. `templates/post-template.md` 복사
2. 파일명을 `posts/날짜-슬러그.md` 로 변경
3. 내용 채우고 저장
4. `cd ~/blog && git add -A && git commit -m "메시지" && git push`

### 다른 컴퓨터에서 쓸 때
- 처음 한 번: `git clone https://github.com/MingyumSong/til.git`
- 쓰기 **전**: `git pull` (다른 데서 쓴 글 받아오기)
- 쓰고 **나서**: `til push`

### 이미지 넣기
1. 이미지를 `assets/` 에 넣는다
2. 본문에서: `![설명](../assets/그림.png)`

---

## 보안: 푸시 전 자동 검사 (pre-push 훅)

Public 저장소라, `git push` 할 때 `bin/secret-scan.sh` 가 자동으로 돈다. API 키·내부 호스트·사설 IP·DB 커넥션 스트링·회사 도메인 등이 글에 섞여 있으면 **푸시를 막는다**. (`/til` 스킬의 점검과 별개의 이중 안전망)

- 오탐이라 확신하면 우회: `git push --no-verify`
- **다른 컴퓨터에서 클론하면 훅 재설치 필요** (훅은 클론에 안 따라옴):
  ```zsh
  chmod +x bin/secret-scan.sh
  ln -sf ../../bin/secret-scan.sh .git/hooks/pre-push
  ```

---

## 좋은 TIL 습관 (나중에 Obsidian / AI 지식베이스로 써먹기 위해)

- 태그는 **소문자 영문**으로 통일 (`sql` O, `SQL`/`Sql` X)
- 같은 개념은 **한 태그로** (`redshift` 하나로, `amazon-redshift` 섞지 않기)
- 관련 글끼리 `[[2026-06-14-til-blog-setup]]` 처럼 연결 (Obsidian 기본 문법, 표준 마크다운이라 안 깨짐)
- 한 글은 **한 주제**로, 자기완결적으로 쓴다
