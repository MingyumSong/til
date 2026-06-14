# TIL (Today I Learned)

매일 배운 것을 기록하는 공간. 마크다운으로 글을 쌓아두고, 사이트는 나중에 정적 사이트 생성기로 얹는다.

## 구조

```
posts/        글 본체 (사이트 생성기가 읽는 폴더)
drafts/       작성 중인 초안 (사이트엔 안 올라감)
assets/       이미지 등 첨부파일
templates/    새 글 복붙용 템플릿
```

## 글 쓰는 법

1. `templates/post-template.md`를 `posts/`로 복사
2. 파일명을 `YYYY-MM-DD-영문슬러그.md`로 변경
3. frontmatter(제목·날짜·태그) 채우고 본문 작성
4. 커밋 & 푸시

## frontmatter 규칙

```markdown
---
title: "한글 제목"
date: 2026-06-14
tags: [redshift, sql]
summary: "한 줄 요약 (목록/미리보기용)"
draft: false
---
```

## 글 목록

<!-- 글이 늘어나면 여기에 정리. 나중에 사이트 생성기가 자동으로 목록 페이지를 만들어준다 -->

- 2026-06-14 · [TIL 블로그를 GitHub 마크다운으로 시작하다](posts/2026-06-14-til-blog-setup.md)
