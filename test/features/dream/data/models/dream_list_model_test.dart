import 'dart:convert';

import 'package:dream_catcher/core/data/model.dart';
import 'package:dream_catcher/features/dream/data/models/dream_list_item_model.dart';
import 'package:dream_catcher/features/dream/data/models/dream_list_model.dart';
import 'package:dream_catcher/features/dream/domain/entities/dream_list.dart';
import 'package:dream_catcher/fixtures/fixture_reader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tDreamListItemModel1 = DreamListItemModel(
    id: 'dream001',
    title: '바다에서 수영하는 꿈',
    date: DateTime(2024, 3, 15),
    mood: '평화로움',
    color: const Color(0xFF6699CC),
    content: '오늘 꿈에서 넓고 푸른 바다에서 수영을 하고 있었다. 물은 따뜻하고 햇빛은 적당히 비추고 있었다...',
  );

  final tDreamListItemModel2 = DreamListItemModel(
    id: 'dream002',
    title: '높은 건물에서 날아가는 꿈',
    date: DateTime(2024, 3, 20),
    mood: '흥분됨',
    color: const Color(0xFFFF9800), // 4294938624
    content: '고층 빌딩 꼭대기에 서 있었다. 도시의 불빛이 아래에서 반짝이고 있었고, 밤하늘은 맑고 별이 가득했다...',
  );

  final tDreamListItemModel3 = DreamListItemModel(
    id: 'dream003',
    title: '시험을 준비하지 못한 꿈',
    date: DateTime(2024, 4, 5),
    mood: '불안함',
    color: const Color(0xFFE57373), // 4293467747
    content: '갑자기 내가 큰 강당에 있었다. 주변에는 모두 책상에 앉아 시험지를 풀고 있었다...',
  );

  final tDreamListModel = DreamListModel(
    dreams: [tDreamListItemModel1, tDreamListItemModel2, tDreamListItemModel3],
  );

  final tDreamListItem1 = tDreamListItemModel1.toEntity();
  final tDreamListItem2 = tDreamListItemModel2.toEntity();
  final tDreamListItem3 = tDreamListItemModel3.toEntity();
  final tDreamList =
      DreamList(dreams: [tDreamListItem1, tDreamListItem2, tDreamListItem3]);

  group('Model 인터페이스 구현 검증', () {
    test('should be a subclass of Model<DreamList>', () {
      // assert
      expect(tDreamListModel, isA<Model<DreamList>>());
    });
  });

  group('fromJson', () {
    test('올바른 JSON에서 모델 생성', () {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('dream_list.json'));
      const itemFactory = DreamListItemModelFactory();
      const factory = DreamListModelFactory(itemFactory: itemFactory);

      // act
      final result = factory.fromJson(jsonMap);

      // assert
      expect(result.dreams.length, equals(3));
      expect(result.dreams[0].title, equals('바다에서 수영하는 꿈'));
      expect(result.dreams[1].title, equals('높은 건물에서 날아가는 꿈'));
      expect(result.dreams[2].title, equals('시험을 준비하지 못한 꿈'));
    });
  });

  group('toJson', () {
    test('모델을 올바른 JSON으로 변환', () {
      // act
      final result = tDreamListModel.toJson();

      // assert
      expect(result.containsKey('dreams'), isTrue);
      expect(result['dreams'], isA<List>());
      expect(result['dreams'].length, 3);
      expect(result['dreams'][0]['title'], equals('바다에서 수영하는 꿈'));
      expect(result['dreams'][1]['title'], equals('높은 건물에서 날아가는 꿈'));
      expect(result['dreams'][2]['title'], equals('시험을 준비하지 못한 꿈'));
    });
  });

  group('toEntity', () {
    test('모델을 올바른 엔티티로 변환', () {
      // act
      final result = tDreamListModel.toEntity();

      // assert
      expect(result, equals(tDreamList));
      expect(result.dreams.length, equals(3));
      expect(result.dreams[0].title, equals('바다에서 수영하는 꿈'));
      expect(result.dreams[1].title, equals('높은 건물에서 날아가는 꿈'));
      expect(result.dreams[2].title, equals('시험을 준비하지 못한 꿈'));
    });
  });

  group('fromEntity', () {
    test('엔티티에서 올바른 모델 생성', () {
      // arrange
      const itemFactory = DreamListItemModelFactory();
      const factory = DreamListModelFactory(itemFactory: itemFactory);

      // act
      final result = factory.fromEntity(tDreamList);

      // assert
      expect(result.dreams.length, equals(3));
      expect(result.dreams[0].title, equals('바다에서 수영하는 꿈'));
      expect(result.dreams[1].title, equals('높은 건물에서 날아가는 꿈'));
      expect(result.dreams[2].title, equals('시험을 준비하지 못한 꿈'));
    });
  });
}
