import React from 'react';
import { View, Text } from 'react-native';
import { Image } from 'expo-image';
import { Card, Badge } from '@/shared/components';
import { COLORS } from '@/shared/constants';
import type { ClubWithDetails } from '../types';

interface ClubCardProps {
  club: ClubWithDetails;
  onPress: () => void;
}

export const ClubCard = React.memo(function ClubCard({ club, onPress }: ClubCardProps) {
  return (
    <Card onPress={onPress} className="bg-white rounded-xl border border-gray-200 p-0 overflow-hidden">
      {/* 대표 이미지 */}
      {club.cover_image_url ? (
        <Image
          source={{ uri: club.cover_image_url }}
          style={{ width: '100%', height: 140, borderTopLeftRadius: 12, borderTopRightRadius: 12 }}
          contentFit="cover"
        />
      ) : (
        <View
          style={{
            width: '100%',
            height: 100,
            backgroundColor: COLORS.PRIMARY_LIGHT,
            borderTopLeftRadius: 12,
            borderTopRightRadius: 12,
            alignItems: 'center',
            justifyContent: 'center',
          }}
        >
          <Text style={{ fontSize: 32 }}>🎾</Text>
        </View>
      )}

      {/* 내용 */}
      <View style={{ padding: 16 }}>
        <Text style={{ fontSize: 16, fontWeight: 'bold', color: COLORS.TEXT_PRIMARY, marginBottom: 4 }}>
          {club.name}
        </Text>
        {club.description ? (
          <Text
            style={{ fontSize: 14, color: COLORS.TEXT_SECONDARY, marginBottom: 12 }}
            numberOfLines={2}
          >
            {club.description}
          </Text>
        ) : (
          <View style={{ marginBottom: 12 }} />
        )}
        <View style={{ flexDirection: 'row', alignItems: 'center', gap: 12, marginBottom: 12 }}>
          <Text style={{ fontSize: 12, color: COLORS.TEXT_HINT }}>
            👥 {club.member_count}명
          </Text>
          {club.region && (
            <Text style={{ fontSize: 12, color: COLORS.TEXT_HINT }}>
              📍 {club.region}{club.city ? ` ${club.city}` : ''}
            </Text>
          )}
        </View>
        <View style={{ flexDirection: 'row', gap: 8 }}>
          {club.is_recruiting && <Badge text="모집중" variant="success" />}
        </View>
      </View>
    </Card>
  );
});
