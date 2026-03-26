import { Platform } from 'react-native';

/**
 * 인앱 브라우저 감지.
 * 카카오톡, 인스타그램, 페이스북, 네이버, 라인 등의 인앱 브라우저를 감지한다.
 * Google OAuth는 인앱 브라우저(WebView)에서 차단되므로, 외부 브라우저로 유도해야 한다.
 */
export function isInAppBrowser(): boolean {
  if (Platform.OS !== 'web') return false;

  const ua = navigator.userAgent || '';

  const inAppPatterns = [
    /KAKAOTALK/i,
    /NAVER/i,
    /Instagram/i,
    /FBAN|FBAV/i,       // Facebook
    /Line\//i,
    /Twitter/i,
    /Snapchat/i,
    /DaumApps/i,
    /SamsungBrowser\/.*CrossApp/i,
  ];

  return inAppPatterns.some((pattern) => pattern.test(ua));
}

/**
 * 현재 페이지를 외부 브라우저에서 열기.
 * 카카오톡 인앱 브라우저에서는 intent:// 스킴으로 Chrome을 열 수 있다.
 */
export function openInExternalBrowser(url?: string): void {
  const targetUrl = url ?? window.location.href;
  const ua = navigator.userAgent || '';

  // 카카오톡: kakaotalk://web/openExternal 사용
  if (/KAKAOTALK/i.test(ua)) {
    window.location.href = `kakaotalk://web/openExternal?url=${encodeURIComponent(targetUrl)}`;
    return;
  }

  // 기타 인앱 브라우저: intent 스킴으로 Chrome 시도 (Android)
  if (/Android/i.test(ua)) {
    window.location.href = `intent://${targetUrl.replace(/^https?:\/\//, '')}#Intent;scheme=https;package=com.android.chrome;end`;
    return;
  }

  // iOS 인앱 브라우저: Safari로 열기 시도
  window.open(targetUrl, '_system');
}
