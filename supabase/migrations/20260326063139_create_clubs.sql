-- 동호회 테이블
-- owner_id는 profiles 참조, sport_category_id는 sport_categories 참조

CREATE TABLE clubs (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name TEXT NOT NULL,
  description TEXT,
  owner_id UUID NOT NULL REFERENCES profiles(id),
  sport_category_id UUID NOT NULL REFERENCES sport_categories(id),
  region TEXT,
  city TEXT,
  district TEXT,
  club_type TEXT NOT NULL DEFAULT 'regular'
    CHECK (club_type IN ('regular', 'lightning', 'league')),
  max_members INTEGER NOT NULL DEFAULT 50,
  is_public BOOLEAN NOT NULL DEFAULT true,
  is_recruiting BOOLEAN NOT NULL DEFAULT true,
  tags TEXT[],
  cover_image_url TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL,
  updated_at TIMESTAMPTZ DEFAULT NOW() NOT NULL
);

-- 이름 길이 제약
ALTER TABLE clubs ADD CONSTRAINT club_name_length
  CHECK (char_length(name) >= 2 AND char_length(name) <= 30);

-- RLS 활성화
ALTER TABLE clubs ENABLE ROW LEVEL SECURITY;

-- 공개 동호회는 누구나 조회 가능
CREATE POLICY "clubs_select_public" ON clubs
  FOR SELECT USING (is_public = true);

-- 인증된 사용자가 본인을 owner로 동호회 생성 가능
CREATE POLICY "clubs_insert_authenticated" ON clubs
  FOR INSERT WITH CHECK (auth.uid() = owner_id);

-- owner만 동호회 정보 수정 가능
CREATE POLICY "clubs_update_owner" ON clubs
  FOR UPDATE USING (auth.uid() = owner_id)
  WITH CHECK (auth.uid() = owner_id);

-- 인덱스
CREATE INDEX idx_clubs_sport_category_id ON clubs(sport_category_id);
CREATE INDEX idx_clubs_owner_id ON clubs(owner_id);
CREATE INDEX idx_clubs_region ON clubs(region);
CREATE INDEX idx_clubs_is_public_recruiting ON clubs(is_public, is_recruiting);

-- updated_at 자동 갱신 트리거 (update_updated_at 함수는 profiles 마이그레이션에서 생성됨)
CREATE TRIGGER set_clubs_updated_at
  BEFORE UPDATE ON clubs
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at();
