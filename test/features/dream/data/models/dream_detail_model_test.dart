import 'dart:convert';

import 'package:dream_catcher/features/dream/data/models/dream_detail_model.dart';
import 'package:dream_catcher/features/dream/domain/entities/dream_detail.dart';
import 'package:dream_catcher/fixtures/fixture_reader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tDreamDetailModel = DreamDetailModel(
    id: 'dream001',
    title: '바다에서 수영하는 꿈',
    date: DateTime.parse("2024-03-15T00:00:00.000Z"),
    mood: '평화로움',
    color: const Color(0xff6fafcc),
    content:
        '오늘 꿈에서 넓고 푸른 바다에서 수영을 하고 있었다. 물은 따뜻하고 햇빛은 적당히 비추고 있었다. 물 속에서는 다양한 물고기들이 나와 함께 수영을 하며 즐겁게 놀았다. 특히 무지개 빛깔의 물고기가 계속 내 주변을 맴돌았는데, 그 물고기와 대화를 나누는 느낌이었다.',
    tags: ['바다', '수영', '물고기', '평화'],
    people: ['없음'],
    clearness: 4,
    lucidity: 2,
    symbolism: '자유, 평화, 새로운 시작',
    interpretation:
        '바다는 내면의 감정과 무의식을 상징한다고 하는데, 푸른 바다에서 자유롭게 수영하는 꿈은 현재 내 마음이 평화롭고 안정되어 있음을 의미하는 것 같다.',
  );

  group('fromJson', () {
    test('JSON 데이터로부터 DreamDetailModel 객체를 올바르게 생성해야 함', () {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('dream_detail.json'));

      // act
      final result = const DreamDetailModelFactory().fromJson(jsonMap);

      // assert
      expect(result, equals(tDreamDetailModel));
    });
  });

  group('toJson', () {
    test('DreamDetailModel 객체를 JSON 데이터로 올바르게 변환해야 함', () {
      // act
      final result = tDreamDetailModel.toJson();

      // assert
      final expectedMap = {
        'id': 'dream001',
        'title': '바다에서 수영하는 꿈',
        'date': '2024-03-15T00:00:00.000',
        'mood': '평화로움',
        'color': 'ff6fafcc',
        'content':
            '오늘 꿈에서 넓고 푸른 바다에서 수영을 하고 있었다. 물은 따뜻하고 햇빛은 적당히 비추고 있었다. 물 속에서는 다양한 물고기들이 나와 함께 수영을 하며 즐겁게 놀았다. 특히 무지개 빛깔의 물고기가 계속 내 주변을 맴돌았는데, 그 물고기와 대화를 나누는 느낌이었다.',
        'tags': ['바다', '수영', '물고기', '평화'],
        'people': ['없음'],
        'clearness': 4,
        'lucidity': 2,
        'symbolism': '자유, 평화, 새로운 시작',
        'interpretation':
            '바다는 내면의 감정과 무의식을 상징한다고 하는데, 푸른 바다에서 자유롭게 수영하는 꿈은 현재 내 마음이 평화롭고 안정되어 있음을 의미하는 것 같다.',
      };
      expect(result, expectedMap);
    });
  });

  group('toEntity', () {
    test('DreamDetailModel 객체를 DreamDetail 엔티티로 올바르게 변환해야 함', () {
      // act
      final result = tDreamDetailModel.toEntity();

      // assert
      expect(result, isA<DreamDetail>());
      expect(result.id, tDreamDetailModel.id);
      expect(result.title, tDreamDetailModel.title);
      expect(result.date, tDreamDetailModel.date);
      expect(result.mood, tDreamDetailModel.mood);
      expect(result.color.value, tDreamDetailModel.color.value);
      expect(result.content, tDreamDetailModel.content);
      expect(result.tags, tDreamDetailModel.tags);
      expect(result.people, tDreamDetailModel.people);
      expect(result.clearness, tDreamDetailModel.clearness);
      expect(result.lucidity, tDreamDetailModel.lucidity);
      expect(result.symbolism, tDreamDetailModel.symbolism);
      expect(result.interpretation, tDreamDetailModel.interpretation);
    });
  });
}
