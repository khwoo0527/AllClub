import { Platform, Alert } from 'react-native';

/**
 * 크로스플랫폼 알림 — 네이티브에서는 Alert.alert, 웹에서는 window.alert
 */
export function showAlert(title: string, message?: string): void {
  if (Platform.OS === 'web') {
    window.alert(message ? `${title}\n${message}` : title);
  } else {
    Alert.alert(title, message);
  }
}
