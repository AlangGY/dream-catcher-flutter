import 'dart:convert';

import 'package:dream_catcher/features/dream/data/models/dream_interview_model.dart';
import 'package:dream_catcher/features/dream/domain/entities/dream_interview.dart';
import 'package:dream_catcher/fixtures/fixture_reader.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // 테스트용 메시지 모델 생성
  final DateTime botMessageTime = DateTime.parse("2024-03-15T10:25:00.000Z");
  final DateTime userMessageTime = DateTime.parse("2024-03-15T10:30:00.000Z");

  final DreamInterviewMessageModel tBotMessage = DreamInterviewMessageModel(
    id: 'msg1',
    speakerType: SpeakerType.bot,
    content: '안녕하세요. 꿈 기록을 도와드릴 AI 인터뷰어입니다. 최근에 기억나는, 인상깊었던 꿈에 대해 이야기해 주세요.',
    timestamp: botMessageTime,
  );

  final DreamInterviewMessageModel tUserMessage = DreamInterviewMessageModel(
    id: 'msg2',
    speakerType: SpeakerType.me,
    content: '저는 바다에서 수영하는 꿈을 꾸었어요. 파란 바다였고 물고기들과 함께 헤엄치고 있었습니다.',
    timestamp: userMessageTime,
  );

  // 테스트용 인터뷰 모델 생성
  final DreamInterviewModel tInterviewModel = DreamInterviewModel(
    id: 'interview123',
    messages: [tBotMessage, tUserMessage],
    date: botMessageTime,
    isCompleted: false,
    createdAt: botMessageTime,
    updatedAt: botMessageTime,
  );

  group('DreamInterviewMessageModel 테스트', () {
    test('toJson 메서드는 DreamInterviewMessageModel을 JSON으로 변환해야 함', () {
      // act
      final botJson = tBotMessage.toJson();
      final userJson = tUserMessage.toJson();

      // assert
      expect(botJson, {
        'id': 'msg1',
        'speaker': 'AI',
        'message':
            '안녕하세요. 꿈 기록을 도와드릴 AI 인터뷰어입니다. 최근에 기억나는, 인상깊었던 꿈에 대해 이야기해 주세요.',
        'sentAt': botMessageTime.toIso8601String(),
      });

      expect(userJson, {
        'id': 'msg2',
        'speaker': 'USER',
        'message': '저는 바다에서 수영하는 꿈을 꾸었어요. 파란 바다였고 물고기들과 함께 헤엄치고 있었습니다.',
        'sentAt': userMessageTime.toIso8601String(),
      });
    });

    test('fromJson 메서드는 JSON을 DreamInterviewMessageModel로 변환해야 함', () {
      // arrange
      final botJsonMap = {
        'id': 'msg1',
        'speaker': 'AI',
        'message':
            '안녕하세요. 꿈 기록을 도와드릴 AI 인터뷰어입니다. 최근에 기억나는, 인상깊었던 꿈에 대해 이야기해 주세요.',
        'sentAt': botMessageTime.toIso8601String(),
      };

      final userJsonMap = {
        'id': 'msg2',
        'speaker': 'USER',
        'message': '저는 바다에서 수영하는 꿈을 꾸었어요. 파란 바다였고 물고기들과 함께 헤엄치고 있었습니다.',
        'sentAt': userMessageTime.toIso8601String(),
      };

      // act
      final botResult =
          const DreamInterviewMessageModelFactory().fromJson(botJsonMap);
      final userResult =
          const DreamInterviewMessageModelFactory().fromJson(userJsonMap);

      // assert
      expect(botResult, tBotMessage);
      expect(userResult, tUserMessage);
    });

    test(
        'toEntity 메서드는 DreamInterviewMessageModel을 DreamInterviewMessage로 변환해야 함',
        () {
      // act
      final botEntity = tBotMessage.toEntity();
      final userEntity = tUserMessage.toEntity();

      // assert
      expect(botEntity, isA<DreamInterviewMessage>());
      expect(botEntity.id, tBotMessage.id);
      expect(botEntity.speakerType, tBotMessage.speakerType);
      expect(botEntity.content, tBotMessage.content);
      expect(botEntity.timestamp, tBotMessage.timestamp);

      expect(userEntity, isA<DreamInterviewMessage>());
      expect(userEntity.id, tUserMessage.id);
      expect(userEntity.speakerType, tUserMessage.speakerType);
      expect(userEntity.content, tUserMessage.content);
      expect(userEntity.timestamp, tUserMessage.timestamp);
    });
  });

  group('DreamInterviewModel 테스트', () {
    test('fromJson 메서드는 JSON을 DreamInterviewModel로 변환해야 함', () {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('dream_interview.json'));

      // act
      final result = const DreamInterviewModelFactory().fromJson(jsonMap);

      // assert
      expect(result, tInterviewModel);
    });

    test('toJson 메서드는 DreamInterviewModel을 JSON으로 변환해야 함', () {
      // act
      final result = tInterviewModel.toJson();

      // assert
      final Map<String, dynamic> expectedJson =
          json.decode(fixture('dream_interview.json'));
      expect(result, expectedJson);
    });

    test('toEntity 메서드는 DreamInterviewModel을 DreamInterview로 변환해야 함', () {
      // act
      final result = tInterviewModel.toEntity();

      // assert
      expect(result, isA<DreamInterview>());
      expect(result.id, tInterviewModel.id);
      expect(result.date, tInterviewModel.date);
      expect(result.isCompleted, tInterviewModel.isCompleted);
      expect(result.messages.length, tInterviewModel.messages.length);

      // 메시지 내용 확인
      for (int i = 0; i < result.messages.length; i++) {
        expect(result.messages[i].id, tInterviewModel.messages[i].id);
        expect(result.messages[i].speakerType,
            tInterviewModel.messages[i].speakerType);
        expect(result.messages[i].content, tInterviewModel.messages[i].content);
        expect(result.messages[i].timestamp,
            tInterviewModel.messages[i].timestamp);
      }
    });
  });
}
