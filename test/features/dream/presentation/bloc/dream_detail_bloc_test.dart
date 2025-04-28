import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:dream_catcher/core/error/failure.dart';
import 'package:dream_catcher/features/dream/domain/entities/dream_detail.dart';
import 'package:dream_catcher/features/dream/domain/use-cases/get_dream.dart';
import 'package:dream_catcher/features/dream/presentation/bloc/dream_detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<GetDream>()])
import 'dream_detail_bloc_test.mocks.dart';

void main() {
  late DreamDetailBloc bloc;
  late MockGetDream mockGetDream;

  setUp(() {
    mockGetDream = MockGetDream();
    bloc = DreamDetailBloc(getDream: mockGetDream);
  });

  tearDown(() {
    bloc.close();
  });

  const tDreamId = 'dream001';
  final tDreamDetail = DreamDetail(
    id: tDreamId,
    title: '바다에서 수영하는 꿈',
    date: DateTime(2024, 3, 15),
    mood: '평화로움',
    color: const Color(0xFF6699CC),
    content: '오늘 꿈에서 넓고 푸른 바다에서 수영을 하고 있었다.',
    tags: const ['바다', '수영', '물고기', '평화'],
    interpretation:
        '바다는 내면의 감정과 무의식을 상징한다고 하는데, 푸른 바다에서 자유롭게 수영하는 꿈은 현재 내 마음이 평화롭고 안정되어 있음을 의미하는 것 같다.',
    suggestedActions: const [
      "바다에서 수영하는 꿈은 현재 내 마음이 평화롭고 안정되어 있음을 의미하는 것 같다.",
      "바다에서 수영하는 꿈은 현재 내 마음이 평화롭고 안정되어 있음을 의미하는 것 같다.",
      "바다에서 수영하는 꿈은 현재 내 마음이 평화롭고 안정되어 있음을 의미하는 것 같다."
    ],
    createdAt: DateTime(2024, 3, 15),
    updatedAt: DateTime(2024, 3, 15),
  );

  test('초기 상태는 DreamDetailInitial이어야 함', () {
    expect(bloc.state, equals(DreamDetailInitial()));
  });

  group('LoadDreamEvent', () {
    blocTest<DreamDetailBloc, DreamDetailState>(
      '꿈 정보를 성공적으로 불러오면 [DreamDetailLoading, DreamDetailLoaded] 상태를 출력해야 함',
      build: () {
        when(mockGetDream(any)).thenAnswer((_) async => Right(tDreamDetail));
        return bloc;
      },
      act: (bloc) => bloc.add(const LoadDreamEvent(dreamId: tDreamId)),
      expect: () => [
        DreamDetailLoading(),
        DreamDetailLoaded(dream: tDreamDetail),
      ],
      verify: (bloc) {
        verify(mockGetDream(const GetDreamParams(dreamId: tDreamId)));
      },
    );

    const tErrorMessage = '서버 오류가 발생했습니다';
    const tServerFailure = ServerFailure(message: tErrorMessage);
    blocTest<DreamDetailBloc, DreamDetailState>(
      '꿈 정보를 불러오는데 실패하면 [DreamDetailLoading, DreamDetailError] 상태를 출력해야 함',
      build: () {
        when(mockGetDream(any))
            .thenAnswer((_) async => const Left(tServerFailure));
        return bloc;
      },
      act: (bloc) => bloc.add(const LoadDreamEvent(dreamId: tDreamId)),
      expect: () => [
        DreamDetailLoading(),
        DreamDetailError(message: tServerFailure.toString()),
      ],
      verify: (bloc) {
        verify(mockGetDream(const GetDreamParams(dreamId: tDreamId)));
      },
    );
  });
}
