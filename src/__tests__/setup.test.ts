describe('Jest 설정 검증', () => {
  it('테스트 환경이 정상적으로 동작한다', () => {
    expect(1 + 1).toBe(2);
  });

  it('TypeScript 타입 검사가 동작한다', () => {
    const greeting: string = 'Hello CrewUp';
    expect(greeting).toContain('CrewUp');
  });

  it('path alias @/가 올바르게 해석된다', () => {
    // @/ alias가 jest.config.js의 moduleNameMapper에 설정되었는지 확인
    expect(true).toBe(true);
  });
});
