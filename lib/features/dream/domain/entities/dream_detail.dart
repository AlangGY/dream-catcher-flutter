import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class DreamDetail extends Equatable {
  final String id;
  final String title;
  final DateTime date;
  final String mood;
  final Color color;
  final String content;
  final List<String> tags;
  final String interpretation;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int clarity;
  final int vividness;

  const DreamDetail({
    required this.id,
    required this.title,
    required this.date,
    required this.mood,
    required this.color,
    required this.content,
    required this.tags,
    required this.interpretation,
    required this.createdAt,
    required this.updatedAt,
    required this.clarity,
    required this.vividness,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        date,
        mood,
        color,
        content,
        tags,
        interpretation,
        clarity,
        vividness,
      ];

  // 임시 데이터 생성을 위한 팩토리 메서드
  factory DreamDetail.sample() {
    return DreamDetail(
      id: '1',
      title: '바다에서 수영하는 꿈',
      date: DateTime(2023, 5, 15),
      mood: '평화로움',
      color: const Color(0xFF6699CC),
      content: '오늘 꿈에서 넓고 푸른 바다에서 수영을 하고 있었다. 물은 따뜻하고 햇빛은 적당히 비추고 있었다. '
          '물 속에서는 다양한 물고기들이 나와 함께 수영을 하며 즐겁게 놀았다. 특히 무지개 빛깔의 물고기가 계속 내 주변을 맴돌았는데, '
          '그 물고기와 대화를 나누는 느낌이었다. 그 물고기가 나에게 앞으로의 일에 대해 이야기를 해주는 것 같았지만 구체적인 내용은 기억나지 않는다. '
          '바다 깊은 곳까지 들어갔지만 숨이 막히지 않고 자유롭게 호흡할 수 있었다.',
      tags: const ['바다', '수영', '물고기', '평화', '자유'],
      interpretation:
          '바다는 내면의 감정과 무의식을 상징한다고 하는데, 푸른 바다에서 자유롭게 수영하는 꿈은 현재 내 마음이 평화롭고 '
          '안정되어 있음을 의미하는 것 같다. 물고기와의 소통은 내 무의식과 대화를 나누는 것으로 해석할 수 있을 것 같다.',
      createdAt: DateTime(2023, 5, 15),
      updatedAt: DateTime(2023, 5, 15),
      clarity: 5,
      vividness: 5,
    );
  }
}
