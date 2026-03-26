-- 종목 분류 테이블 (다종목 확장용)
-- MVP는 테니스만 사용하지만, 구조적으로 확장 가능하도록 설계

CREATE TABLE sport_categories (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name TEXT NOT NULL UNIQUE,
  icon TEXT,
  description TEXT,
  is_active BOOLEAN DEFAULT true NOT NULL,
  display_order INTEGER DEFAULT 0 NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL
);

-- RLS 활성화
ALTER TABLE sport_categories ENABLE ROW LEVEL SECURITY;

-- 누구나 종목 목록 조회 가능
CREATE POLICY "sport_categories_select_all" ON sport_categories
  FOR SELECT USING (true);
