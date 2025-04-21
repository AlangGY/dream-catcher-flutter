import 'dart:convert';

import 'package:dream_catcher/core/data/model.dart';
import 'package:dream_catcher/features/dream/data/models/dream_list_item_model.dart';
import 'package:dream_catcher/features/dream/domain/entities/dream_list.dart';
import 'package:dream_catcher/fixtures/fixture_reader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tDreamListItemModel = DreamListItemModel(
    id: 'dream001',
    title: '바다에서 수영하는 꿈',
    date: DateTime(2024, 3, 15),
    mood: '평화로움',
    color: const Color(0xff6fafcc),
    content: '오늘 꿈에서 넓고 푸른 바다에서 수영을 하고 있었다...',
  );

  final tDreamListItem = DreamListItem(
    id: 'dream001',
    title: '바다에서 수영하는 꿈',
    date: DateTime(2024, 3, 15),
    mood: '평화로움',
    color: const Color(0xff6fafcc),
    content: '오늘 꿈에서 넓고 푸른 바다에서 수영을 하고 있었다...',
  );

  test('should be a subclass of Model<DreamListItem>', () {
    // assert
    expect(tDreamListItemModel, isA<Model<DreamListItem>>());
  });

  group('fromJson', () {
    test('올바른 JSON에서 모델 생성', () {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('dream_list_item.json'));
      const factory = DreamListItemModelFactory();

      // act
      final result = factory.fromJson(jsonMap);

      // assert
      expect(result, equals(tDreamListItemModel));
    });
  });

  group('toJson', () {
    test('모델을 올바른 JSON으로 변환', () {
      // act
      final result = tDreamListItemModel.toJson();

      // assert
      final Map<String, dynamic> expectedJson = {
        'id': 'dream001',
        'title': '바다에서 수영하는 꿈',
        'date': '2024-03-15T00:00:00.000',
        'mood': '평화로움',
        'color': 4285509580, // 0xFF6699CC
        'content': '오늘 꿈에서 넓고 푸른 바다에서 수영을 하고 있었다...',
      };

      expect(result, equals(expectedJson));
    });
  });

  group('toEntity', () {
    test('모델을 올바른 엔티티로 변환', () {
      // act
      final result = tDreamListItemModel.toEntity();

      // assert
      expect(result, equals(tDreamListItem));
    });
  });

  group('fromEntity', () {
    test('엔티티에서 올바른 모델 생성', () {
      // arrange
      const factory = DreamListItemModelFactory();

      // act
      final result = factory.fromEntity(tDreamListItem);

      // assert
      expect(result, equals(tDreamListItemModel));
    });
  });
}
