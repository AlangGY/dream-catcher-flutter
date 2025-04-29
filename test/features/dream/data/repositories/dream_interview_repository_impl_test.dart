import 'package:dartz/dartz.dart';
import 'package:dream_catcher/core/error/failure.dart';
import 'package:dream_catcher/features/dream/data/data-sources/dream_interview_data_source.dart';
import 'package:dream_catcher/features/dream/data/models/dream_interview_model.dart';
import 'package:dream_catcher/features/dream/data/repositories/dream_interview_repository_impl.dart';
import 'package:dream_catcher/features/dream/domain/entities/dream_interview.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([
  MockSpec<DreamInterviewDataSource>(),
  MockSpec<DreamInterviewMessageModelFactory>(),
])
import 'dream_interview_repository_impl_test.mocks.dart';

void main() {
  late DreamInterviewRepositoryImpl repository;
  late MockDreamInterviewDataSource mockDataSource;
  late MockDreamInterviewMessageModelFactory mockMessageModelFactory;

  setUp(() {
    mockDataSource = MockDreamInterviewDataSource();
    mockMessageModelFactory = MockDreamInterviewMessageModelFactory();

    repository = DreamInterviewRepositoryImpl(
      dataSource: mockDataSource,
      messageFactory: mockMessageModelFactory,
    );
  });

  group('startInterview', () {
    final tInterviewModel = DreamInterviewModel(
      id: 'interview1',
      messages: const [],
      date: DateTime(2024, 1, 1),
      isCompleted: false,
    );

    final tInterview = DreamInterview(
      id: 'interview1',
      messages: const [],
      date: DateTime(2024, 1, 1),
      isCompleted: false,
    );

    test(
      '인터뷰를 성공적으로 시작하면 DreamInterview를 반환해야 한다',
      () async {
        // arrange
        when(mockDataSource.startInterview())
            .thenAnswer((_) async => tInterviewModel);

        // act
        final result = await repository.startInterview();

        // assert
        expect(result, Right(tInterview));
        verify(mockDataSource.startInterview());
        verifyNoMoreInteractions(mockDataSource);
      },
    );

    test(
      '인터뷰 시작 중 예외가 발생하면 ServerFailure를 반환해야 한다',
      () async {
        // arrange
        when(mockDataSource.startInterview()).thenThrow(Exception());

        // act
        final result = await repository.startInterview();

        // assert
        expect(result, isA<Left<Failure, DreamInterview>>());
        verify(mockDataSource.startInterview());
        verifyNoMoreInteractions(mockDataSource);
      },
    );
  });

  group('addMessage', () {
    const tInterviewId = 'interview1';
    const tSpeakerType = SpeakerType.me;
    const tContent = '안녕하세요';

    final tInterviewModel = DreamInterviewModel(
      id: tInterviewId,
      messages: const [],
      date: DateTime(2024, 1, 1),
      isCompleted: false,
    );

    final tInterview = DreamInterview(
      id: tInterviewId,
      messages: const [],
      date: DateTime(2024, 1, 1),
      isCompleted: false,
    );

    test(
      '메시지를 성공적으로 추가하면 업데이트된 DreamInterview를 반환해야 한다',
      () async {
        // arrange
        when(mockDataSource.answerMessage(tInterviewId, tSpeakerType, tContent))
            .thenAnswer((_) async => tInterviewModel);

        // act
        final result = await repository.answerMessage(
            tInterviewId, tSpeakerType, tContent);

        // assert
        expect(result, Right(tInterview));
        verify(
            mockDataSource.answerMessage(tInterviewId, tSpeakerType, tContent));
        verifyNoMoreInteractions(mockDataSource);
      },
    );

    test(
      '메시지 추가 중 예외가 발생하면 ServerFailure를 반환해야 한다',
      () async {
        // arrange
        when(mockDataSource.answerMessage(tInterviewId, tSpeakerType, tContent))
            .thenThrow(Exception());

        // act
        final result = await repository.answerMessage(
            tInterviewId, tSpeakerType, tContent);

        // assert
        expect(result, isA<Left<Failure, DreamInterview>>());
        verify(
            mockDataSource.answerMessage(tInterviewId, tSpeakerType, tContent));
        verifyNoMoreInteractions(mockDataSource);
      },
    );
  });

  group('completeInterview', () {
    const tInterviewId = 'interview1';

    test(
      '인터뷰를 성공적으로 완료하면 Unit을 반환해야 한다',
      () async {
        // arrange
        when(mockDataSource.completeInterview(tInterviewId))
            .thenAnswer((_) async => {});

        // act
        final result = await repository.completeInterview(tInterviewId);

        // assert
        expect(result, const Right(unit));
        verify(mockDataSource.completeInterview(tInterviewId));
        verifyNoMoreInteractions(mockDataSource);
      },
    );

    test(
      '인터뷰 완료 중 예외가 발생하면 ServerFailure를 반환해야 한다',
      () async {
        // arrange
        when(mockDataSource.completeInterview(tInterviewId))
            .thenThrow(Exception());

        // act
        final result = await repository.completeInterview(tInterviewId);

        // assert
        expect(result, isA<Left<Failure, Unit>>());
        verify(mockDataSource.completeInterview(tInterviewId));
        verifyNoMoreInteractions(mockDataSource);
      },
    );
  });

  group('getCurrentInterview', () {
    const tInterviewId = 'interview1';
    final tInterviewModel = DreamInterviewModel(
      id: tInterviewId,
      messages: const [],
      date: DateTime(2024, 1, 1),
      isCompleted: false,
    );

    final tInterview = DreamInterview(
      id: tInterviewId,
      messages: const [],
      date: DateTime(2024, 1, 1),
      isCompleted: false,
    );

    test(
      '진행 중인 인터뷰를 성공적으로 가져오면 DreamInterview를 반환해야 한다',
      () async {
        // arrange
        when(mockDataSource.getCurrentInterview(tInterviewId))
            .thenAnswer((_) async => tInterviewModel);

        // act
        final result = await repository.getCurrentInterview(tInterviewId);

        // assert
        expect(result, Right(tInterview));
        verify(mockDataSource.getCurrentInterview(tInterviewId));
        verifyNoMoreInteractions(mockDataSource);
      },
    );

    test(
      '진행 중인 인터뷰 가져오기 중 예외가 발생하면 ServerFailure를 반환해야 한다',
      () async {
        // arrange
        when(mockDataSource.getCurrentInterview(tInterviewId))
            .thenThrow(Exception());

        // act
        final result = await repository.getCurrentInterview(tInterviewId);

        // assert
        expect(result, isA<Left<Failure, DreamInterview>>());
        verify(mockDataSource.getCurrentInterview(tInterviewId));
        verifyNoMoreInteractions(mockDataSource);
      },
    );
  });

  group('convertVoiceToText', () {
    final tAudioData = [1, 2, 3, 4, 5];
    const tText = '안녕하세요';

    test(
      '음성을 성공적으로 텍스트로 변환하면 텍스트 문자열을 반환해야 한다',
      () async {
        // arrange
        when(mockDataSource.convertVoiceToText(tAudioData))
            .thenAnswer((_) async => tText);

        // act
        final result = await repository.convertVoiceToText(tAudioData);

        // assert
        expect(result, const Right(tText));
        verify(mockDataSource.convertVoiceToText(tAudioData));
        verifyNoMoreInteractions(mockDataSource);
      },
    );

    test(
      '음성-텍스트 변환 중 예외가 발생하면 ServerFailure를 반환해야 한다',
      () async {
        // arrange
        when(mockDataSource.convertVoiceToText(tAudioData))
            .thenThrow(Exception());

        // act
        final result = await repository.convertVoiceToText(tAudioData);

        // assert
        expect(result, isA<Left<Failure, String>>());
        verify(mockDataSource.convertVoiceToText(tAudioData));
        verifyNoMoreInteractions(mockDataSource);
      },
    );
  });
}
