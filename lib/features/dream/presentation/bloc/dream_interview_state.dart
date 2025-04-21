part of 'dream_interview_bloc.dart';

abstract class DreamInterviewState extends Equatable {
  final DreamInterview? interview;

  const DreamInterviewState({this.interview});

  @override
  List<Object?> get props => [interview];
}

class DreamInterviewInitial extends DreamInterviewState {
  const DreamInterviewInitial() : super(interview: null);
}

// 로딩 상태 세분화
class InitialLoadingState extends DreamInterviewState {
  const InitialLoadingState() : super(interview: null);
}

class BotResponseLoadingState extends DreamInterviewState {
  const BotResponseLoadingState({required DreamInterview interview})
      : super(interview: interview);
}

class VoiceToTextLoadingState extends DreamInterviewState {
  const VoiceToTextLoadingState({super.interview});
}

class DreamInterviewLoaded extends DreamInterviewState {
  const DreamInterviewLoaded({required DreamInterview interview})
      : super(interview: interview);
}

class DreamInterviewBotResponseLoaded extends DreamInterviewState {
  final String response;

  const DreamInterviewBotResponseLoaded({
    required this.response,
    required DreamInterview interview,
  }) : super(interview: interview);

  @override
  List<Object?> get props => [response, interview];
}

class DreamInterviewCompleted extends DreamInterviewState {
  const DreamInterviewCompleted() : super(interview: null);
}

class VoiceToTextLoaded extends DreamInterviewState {
  final String text;

  const VoiceToTextLoaded({
    required this.text,
    super.interview,
  });

  @override
  List<Object?> get props => [text, interview];
}

class DreamInterviewError extends DreamInterviewState {
  final String message;

  const DreamInterviewError({
    required this.message,
    super.interview,
  });

  @override
  List<Object?> get props => [message, interview];
}
