# Product Backlog

> Sprint 리뷰, Phase 리뷰에서 발견된 이슈를 기록합니다.
> Sprint Planning 시 여기서 다음 Sprint에 포함할 항목을 선별합니다.
> 완료된 항목은 `[x]`로 체크하고, 해결 Sprint를 기록합니다.

## 우선순위 범례
- 🔴 Critical: 현재 Sprint에서 반드시 수정
- 🟠 High: 다음 Sprint에 반드시 포함
- 🟡 Normal: 가까운 Sprint에 포함
- 🟢 Low: 여유될 때 처리
- 🔧 Tech Debt: 기술 부채 (동작하지만 개선 필요)

---

## 🟠 High

- [ ] 디자인 시스템 마이그레이션 — 구 녹색(#2e7d32) → Cal.com 모노크롬(DESIGN.md) 전환
  - 발견: .claude 동기화 + DESIGN.md 도입 (2026-04-07)
  - 대상 코드:
    - `tailwind.config.js` — colors 섹션 전체 교체
    - `src/shared/styles/theme.ts` — Cal.com 팔레트로 재작성
    - `src/shared/constants/colors.ts` — Cal.com 값으로 교체
    - `app.json` — splash backgroundColor `#2e7d32` → `#ffffff` (2곳)
    - `app/(tabs)/_layout.tsx` — tabBarActiveTintColor 변경
    - `app/(auth)/onboarding.tsx:67` — 하드코딩 `backgroundColor: '#f0f2f5'`
    - `app/(tabs)/home.tsx:16` — 하드코딩 `backgroundColor: '#f0f2f5'`
    - `app/(tabs)/profile.tsx:98,115` — 하드코딩 `backgroundColor: '#f0f2f5'` (2곳)
    - `app/(tabs)/my-clubs.tsx:7` — 하드코딩 `backgroundColor: '#f0f2f5'`
    - `app/(tabs)/notifications.tsx:7` — 하드코딩 `backgroundColor: '#f0f2f5'`
  - 참고: `bg-primary`, `text-primary` 등 Tailwind 클래스 사용 컴포넌트는 tailwind.config.js 변경 시 자동 반영
  - 비고: DESIGN.md(Cal.com 기반) 도입으로 기존 녹색 디자인 전면 교체 필요. 코드 변경 시 `/design-review` 커맨드로 준수 검증

- [ ] 테스트 자동화 기반 구축 — jest + @testing-library/react-native 설치, 설정, 첫 단위 테스트 작성
  - 발견: Sprint 1 리뷰 (2026-03-26)
  - 비고: Sprint 2부터 DB 연동 시작 → 테스트와 함께 개발 필요

## 🟡 Normal

- [ ] 카카오 로그인 키 등록 (Kakao Developers 앱 등록 필요) — 출시 전 필수
  - 발견: Sprint 1 리뷰 (2026-03-26)

## 🔧 Tech Debt

- [ ] NativeWind `contentContainerClassName` 웹 호환 이슈 — ScrollView에서 style로 우회 중
  - 발견: Sprint 1 리뷰 (2026-03-26)
  - 관련: `app/(auth)/onboarding.tsx`
- [ ] 온보딩 화면 레이아웃 일부 style 인라인 → NativeWind 웹 이슈 해결 후 className으로 전환
  - 발견: Sprint 1 리뷰 (2026-03-26)
  - 관련: `app/(auth)/onboarding.tsx`
