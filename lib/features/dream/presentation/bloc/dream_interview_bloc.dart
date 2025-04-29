import 'package:bloc/bloc.dart';
import 'package:dream_catcher/core/error/failure.dart';
import 'package:dream_catcher/features/dream/domain/entities/dream_interview.dart';
import 'package:dream_catcher/features/dream/domain/use-cases/interview/add_message.dart';
import 'package:dream_catcher/features/dream/domain/use-cases/interview/complete_interview.dart';
import 'package:dream_catcher/features/dream/domain/use-cases/interview/convert_voice_to_text.dart';
import 'package:dream_catcher/features/dream/domain/use-cases/interview/get_current_interview.dart';
import 'package:dream_catcher/features/dream/domain/use-cases/interview/start_interview.dart';
import 'package:equatable/equatable.dart';

part 'dream_interview_event.dart';
part 'dream_interview_state.dart';

class DreamInterviewBloc
    extends Bloc<DreamInterviewEvent, DreamInterviewState> {
  final StartInterview startInterview;
  final AddMessage addMessage;
  final CompleteInterview completeInterview;
  final ConvertVoiceToText convertVoiceToText;
  final GetCurrentInterview getCurrentInterview;

  // 현재 인터뷰 상태 추적
  DreamInterview? _currentInterview;

  DreamInterviewBloc({
    required this.startInterview,
    required this.addMessage,
    required this.completeInterview,
    required this.convertVoiceToText,
    required this.getCurrentInterview,
  }) : super(const DreamInterviewInitial()) {
    on<StartInterviewEvent>(_onStartInterview);
    on<AddMessageEvent>(_onAddMessage);
    on<CompleteInterviewEvent>(_onCompleteInterview);
    on<ConvertVoiceToTextEvent>(_onConvertVoiceToText);
    on<GetCurrentInterviewEvent>(_onGetCurrentInterview);
  }

  Future<void> _onStartInterview(
      StartInterviewEvent event, Emitter<DreamInterviewState> emit) async {
    emit(const InitialLoadingState());
    final result = await startInterview();

    result.fold(
      (failure) =>
          emit(DreamInterviewError(message: _mapFailureToMessage(failure))),
      (interview) {
        _currentInterview = interview;
        emit(DreamInterviewLoaded(interview: interview));
      },
    );
  }

  Future<void> _onAddMessage(
      AddMessageEvent event, Emitter<DreamInterviewState> emit) async {
    if (_currentInterview == null) {
      emit(const DreamInterviewError(message: "현재 진행 중인 인터뷰가 없습니다."));
      return;
    }

    final optimisticInterview = _currentInterview!.copyWith(
      messages: [
        ..._currentInterview!.messages,
        DreamInterviewMessage(
          id: 'temp_message',
          speakerType: event.speakerType,
          content: event.content,
          timestamp: DateTime.now(),
        ),
      ],
    );

    emit(BotResponseLoadingState(interview: optimisticInterview));

    final result = await addMessage(AddMessageParams(
      interviewId: event.interviewId,
      speakerType: event.speakerType,
      content: event.content,
    ));
    result.fold(
      (failure) => emit(DreamInterviewError(
        message: _mapFailureToMessage(failure),
        interview: _currentInterview,
      )),
      (interview) {
        _currentInterview = interview;
        emit(DreamInterviewLoaded(interview: interview));
      },
    );
  }

  Future<void> _onCompleteInterview(
      CompleteInterviewEvent event, Emitter<DreamInterviewState> emit) async {
    emit(const InitialLoadingState());
    final result = await completeInterview(
        CompleteInterviewParams(interviewId: event.interviewId));

    emit(result.fold(
      (failure) => DreamInterviewError(
        message: _mapFailureToMessage(failure),
        interview: _currentInterview,
      ),
      (_) => const DreamInterviewCompleted(),
    ));
  }

  Future<void> _onConvertVoiceToText(
      ConvertVoiceToTextEvent event, Emitter<DreamInterviewState> emit) async {
    emit(VoiceToTextLoadingState(interview: _currentInterview));

    final result =
        await convertVoiceToText(AudioDataParams(audioData: event.audioData));

    emit(result.fold(
      (failure) => DreamInterviewError(
        message: _mapFailureToMessage(failure),
        interview: _currentInterview,
      ),
      (text) => VoiceToTextLoaded(text: text, interview: _currentInterview),
    ));
  }

  Future<void> _onGetCurrentInterview(
      GetCurrentInterviewEvent event, Emitter<DreamInterviewState> emit) async {
    emit(const InitialLoadingState());
    final result = await getCurrentInterview(
        InterviewIdParams(interviewId: event.interviewId));

    result.fold(
      (failure) => emit(DreamInterviewError(
        message: _mapFailureToMessage(failure),
        interview: _currentInterview,
      )),
      (interview) {
        _currentInterview = interview;
        emit(DreamInterviewLoaded(interview: interview));
      },
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure) {
      case ServerFailure _:
        final serverFailure = failure;
        return serverFailure.message ?? '서버 오류가 발생했습니다.';
      default:
        return '예상치 못한 오류가 발생했습니다.';
    }
  }
}
