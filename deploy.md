# 배포 기록

## 2026-03-26 — Sprint 1 Vercel 배포

- **플랫폼**: Vercel (Expo Web Export)
- **URL**: https://crewup-eight.vercel.app
- **빌드 명령**: `npx expo export --platform web`
- **출력 디렉토리**: `dist`
- **환경 변수**: `EXPO_PUBLIC_SUPABASE_URL`, `EXPO_PUBLIC_SUPABASE_ANON_KEY` (Vercel Settings)
- **백엔드**: Supabase Cloud (`ozzahhbhexhwzpezucbm.supabase.co`)
- **인증**: Google OAuth (PC + 모바일 테스트 완료)
- **상태**: 정상 동작 확인 (PC 브라우저 + 모바일 브라우저)

### 배포 중 발견된 이슈
| 이슈 | 원인 | 해결 |
|------|------|------|
| 사이트 접속 시 파일 다운로드 | vercel.json 미설정 | SPA rewrites 설정 추가 |
| 백지 화면 | 환경 변수 미주입 | Vercel Settings에 env vars 추가 |
| 환경 변수 빌드 시 치환 안 됨 | `process.env[key]` 동적 접근 | `process.env.EXPO_PUBLIC_*` 정적 참조로 변경 |
| DNS 에러 | Supabase URL `.com` → `.co` 오타 | Vercel env var 값 수정 |
