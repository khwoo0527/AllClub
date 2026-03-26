-- 종목 분류 시드 데이터
-- MVP는 테니스만 활성화, 나머지는 추후 확장 시 활성화
INSERT INTO sport_categories (name, icon, description, is_active, display_order)
VALUES
  ('테니스', '🎾', '테니스 동호회', true, 1);
  -- ('골프', '⛳', '골프 동호회', false, 2),
  -- ('축구', '⚽', '축구 동호회', false, 3),
  -- ('배드민턴', '🏸', '배드민턴 동호회', false, 4),
  -- ('탁구', '🏓', '탁구 동호회', false, 5);
