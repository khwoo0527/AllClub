-- 동호회 멤버 테이블
-- 한 유저가 여러 동호회에 가입 가능, 동호회당 유저는 유니크

CREATE TABLE club_members (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  club_id UUID NOT NULL REFERENCES clubs(id) ON DELETE CASCADE,
  user_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  role TEXT NOT NULL DEFAULT 'member'
    CHECK (role IN ('owner', 'admin', 'member')),
  status TEXT NOT NULL DEFAULT 'active'
    CHECK (status IN ('active', 'inactive', 'banned')),
  joined_at TIMESTAMPTZ DEFAULT NOW() NOT NULL,
  attendance_count INTEGER NOT NULL DEFAULT 0,
  attendance_rate DECIMAL,
  UNIQUE(club_id, user_id)
);

-- RLS 활성화
ALTER TABLE club_members ENABLE ROW LEVEL SECURITY;

-- 동호회 멤버는 같은 동호회 멤버 목록 조회 가능
CREATE POLICY "club_members_select_same_club" ON club_members
  FOR SELECT USING (
    club_id IN (
      SELECT cm.club_id FROM club_members cm
      WHERE cm.user_id = auth.uid()
    )
  );

-- 공개 동호회의 멤버 수 조회를 위해 누구나 count 가능
-- (위 정책으로 커버 안 되는 경우 — 비멤버가 동호회 상세 볼 때)
CREATE POLICY "club_members_select_public_club" ON club_members
  FOR SELECT USING (
    club_id IN (
      SELECT c.id FROM clubs c WHERE c.is_public = true
    )
  );

-- 인증된 사용자가 본인을 멤버로 등록 가능 (동호회 생성 시 owner 자동 등록)
CREATE POLICY "club_members_insert_self" ON club_members
  FOR INSERT WITH CHECK (auth.uid() = user_id);

-- 인덱스
CREATE INDEX idx_club_members_user_id ON club_members(user_id);
CREATE INDEX idx_club_members_club_status ON club_members(club_id, status);
