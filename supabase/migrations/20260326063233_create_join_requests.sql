-- 가입 신청 테이블
-- Sprint 3에서 가입 승인/거절 기능 구현 예정, Sprint 2에서는 스키마만 생성

CREATE TABLE join_requests (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  club_id UUID NOT NULL REFERENCES clubs(id) ON DELETE CASCADE,
  user_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  message TEXT,
  status TEXT NOT NULL DEFAULT 'pending'
    CHECK (status IN ('pending', 'approved', 'rejected')),
  reviewed_by UUID REFERENCES profiles(id),
  reviewed_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL
);

-- RLS 활성화
ALTER TABLE join_requests ENABLE ROW LEVEL SECURITY;

-- 본인 신청 내역 조회 가능
CREATE POLICY "join_requests_select_own" ON join_requests
  FOR SELECT USING (auth.uid() = user_id);

-- 동호회 owner/admin은 해당 동호회 신청 조회 가능
CREATE POLICY "join_requests_select_club_admin" ON join_requests
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM club_members
      WHERE club_members.club_id = join_requests.club_id
        AND club_members.user_id = auth.uid()
        AND club_members.role IN ('owner', 'admin')
    )
  );

-- 인증된 사용자가 본인 명의로 가입 신청 가능
CREATE POLICY "join_requests_insert_self" ON join_requests
  FOR INSERT WITH CHECK (auth.uid() = user_id);

-- 인덱스
CREATE INDEX idx_join_requests_club_status ON join_requests(club_id, status);
CREATE INDEX idx_join_requests_user_id ON join_requests(user_id);
