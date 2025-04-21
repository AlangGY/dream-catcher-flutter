import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class DreamList extends Equatable {
  final List<DreamListItem> dreams;

  const DreamList({required this.dreams});

  @override
  List<Object?> get props => [...dreams.map((dream) => dream.props)];

  static DreamList sample() {
    return DreamList(dreams: [
      DreamListItem(
        id: 'dream001',
        title: '바다에서 수영하는 꿈',
        date: DateTime(2024, 3, 15),
        mood: '평화로움',
        color: const Color(0xFF6699CC),
        content: '오늘 꿈에서 넓고 푸른 바다에서 수영을 하고 있었다. 물은 따뜻하고 햇빛은 적당히 비추고 있었다...',
      ),
      DreamListItem(
        id: 'dream002',
        title: '높은 건물에서 날아가는 꿈',
        date: DateTime(2024, 3, 20),
        mood: '흥분됨',
        color: const Color(0xFFFF9800),
        content: '고층 빌딩 꼭대기에 서 있었다. 도시의 불빛이 아래에서 반짝이고 있었고, 밤하늘은 맑고 별이 가득했다...',
      ),
      DreamListItem(
        id: 'dream003',
        title: '시험을 준비하지 못한 꿈',
        date: DateTime(2024, 4, 5),
        mood: '불안함',
        color: const Color(0xFFE57373),
        content: '갑자기 내가 큰 강당에 있었다. 주변에는 모두 책상에 앉아 시험지를 풀고 있었다...',
      ),
      DreamListItem(
        id: 'dream004',
        title: '옛 친구들과의 만남',
        date: DateTime(2023, 5, 5),
        mood: '그리움',
        color: const Color(0xFF9966CC),
        content: '오랜만에 초등학교 친구들과 함께 놀고 있었다...',
      ),
      DreamListItem(
        id: 'dream005',
        title: '새로운 집으로 이사',
        date: DateTime(2023, 5, 1),
        mood: '설렘',
        color: const Color(0xFF66CC99),
        content: '넓고 아름다운 집으로 이사하는 꿈이었다...',
      ),
      DreamListItem(
        id: 'dream006',
        title: '미지의 도시에서 길 잃음',
        date: DateTime(2023, 4, 27),
        mood: '혼란스러움',
        color: const Color(0xFFCC9966),
        content: '한 번도 가본 적 없는 도시에서 길을 잃고 헤매고 있었다...',
      ),
      DreamListItem(
        id: 'dream007',
        title: '공연장에서의 무대',
        date: DateTime(2023, 4, 23),
        mood: '긴장됨',
        color: const Color(0xFFCC66CC),
        content: '많은 관객들 앞에서 공연을 하는 꿈이었다...',
      ),
    ]);
  }
}

class DreamListItem extends Equatable {
  final String id;
  final String title;
  final DateTime date;
  final String mood;
  final Color color;
  final String content;

  const DreamListItem({
    required this.id,
    required this.title,
    required this.date,
    required this.mood,
    required this.color,
    required this.content,
  });

  @override
  List<Object?> get props => [id, title, date.toString(), mood, color, content];
}
