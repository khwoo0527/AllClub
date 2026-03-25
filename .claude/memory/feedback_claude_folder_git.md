---
name: .claude 폴더는 git에 포함
description: .claude 폴더를 .gitignore에 넣지 않음. 멀티 환경(회사/집) 동기화 필수.
type: feedback
---

.claude/ 폴더는 반드시 git에 포함되어야 한다. .gitignore에 넣지 않는다.

**Why:** 사용자가 회사와 집 등 여러 환경에서 작업하며, .claude가 gitignore되면 다른 환경에서 받았을 때 설정이 없어서 고생한다. 실제로 이 문제를 겪음.

**How to apply:**
- .claude/ 내 파일에 .gitignore 추가를 권유하지 않기
- 토큰 등 민감 정보가 .claude/에 포함된 경우, gitignore가 아닌 다른 안전한 방법을 제안
- 환경 동기화가 최우선 가치
