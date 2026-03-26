import { supabase } from './client';

const CLUB_IMAGES_BUCKET = 'club-images';

/**
 * 동호회 대표 이미지 업로드
 */
export async function uploadClubImage(
  clubId: string,
  uri: string,
): Promise<string> {
  const ext = uri.split('.').pop()?.toLowerCase() ?? 'jpg';
  const fileName = `${clubId}/cover.${ext}`;

  // 웹: fetch로 blob 변환, 네이티브: uri 직접 사용
  const response = await fetch(uri);
  const blob = await response.blob();

  const { error } = await supabase.storage
    .from(CLUB_IMAGES_BUCKET)
    .upload(fileName, blob, {
      upsert: true,
      contentType: `image/${ext === 'jpg' ? 'jpeg' : ext}`,
    });

  if (error) throw new Error(`이미지 업로드 실패: ${error.message}`);

  const { data } = supabase.storage
    .from(CLUB_IMAGES_BUCKET)
    .getPublicUrl(fileName);

  return data.publicUrl;
}
