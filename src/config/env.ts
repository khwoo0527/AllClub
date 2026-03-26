// Expo는 process.env.EXPO_PUBLIC_* 를 빌드 시 정적으로 치환한다.
// 동적 접근(process.env[key])은 치환되지 않으므로 반드시 직접 참조해야 한다.
export const env = {
  supabaseUrl: process.env.EXPO_PUBLIC_SUPABASE_URL ?? '',
  supabaseAnonKey: process.env.EXPO_PUBLIC_SUPABASE_ANON_KEY ?? '',
} as const;
