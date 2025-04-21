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
    title: '바다에서 수영하는 꿈',
    date: DateTime(2024, 3, 15),
    mood: '평화로움',
    color: const Color(0xFF6699CC),
    content: '오늘 꿈에서 넓고 푸른 바다에서 수영을 하고 있었다...',
  );

  final tDreamListItemModel2 = DreamListItemModel(
    title: '하늘을 나는 꿈',
    date: DateTime(2024, 3, 12),
    mood: '신남',
    color: const Color(0xFF66CCCC),
    content: '높은 건물 위에서 갑자기 하늘로 날아오르는 꿈을 꾸었다...',
  );

  final tDreamListModel = DreamListModel(
    dreams: [tDreamListItemModel1, tDreamListItemModel2],
  );

  final tDreamListItem1 = tDreamListItemModel1.toEntity();
  final tDreamListItem2 = tDreamListItemModel2.toEntity();
  final tDreamList = DreamList(dreams: [tDreamListItem1, tDreamListItem2]);

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
      expect(result.dreams.length, equals(2));
      expect(result.dreams[0].title, equals('바다에서 수영하는 꿈'));
      expect(result.dreams[1].title, equals('하늘을 나는 꿈'));
    });
  });

  group('toJson', () {
    test('모델을 올바른 JSON으로 변환', () {
      // act
      final result = tDreamListModel.toJson();

      // assert
      expect(result.containsKey('dreams'), isTrue);
      expect(result['dreams'], isA<List>());
      expect(result['dreams'].length, 2);
      expect(result['dreams'][0]['title'], equals('바다에서 수영하는 꿈'));
      expect(result['dreams'][1]['title'], equals('하늘을 나는 꿈'));
    });
  });

  group('toEntity', () {
    test('모델을 올바른 엔티티로 변환', () {
      // act
      final result = tDreamListModel.toEntity();

      // assert
      expect(result, equals(tDreamList));
      expect(result.dreams.length, equals(2));
      expect(result.dreams[0].title, equals('바다에서 수영하는 꿈'));
      expect(result.dreams[1].title, equals('하늘을 나는 꿈'));
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
      expect(result.dreams.length, equals(2));
      expect(result.dreams[0].title, equals('바다에서 수영하는 꿈'));
      expect(result.dreams[1].title, equals('하늘을 나는 꿈'));
    });
  });
}
