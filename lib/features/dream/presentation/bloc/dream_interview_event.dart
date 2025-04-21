part of 'dream_interview_bloc.dart';

abstract class DreamInterviewEvent extends Equatable {
  const DreamInterviewEvent();

  @override
  List<Object?> get props => [];
}

class StartInterviewEvent extends DreamInterviewEvent {
  const StartInterviewEvent();
}

class AddMessageEvent extends DreamInterviewEvent {
  final String interviewId;
  final SpeakerType speakerType;
  final String content;

  const AddMessageEvent({
    required this.interviewId,
    required this.speakerType,
    required this.content,
  });

  @override
  List<Object?> get props => [interviewId, speakerType, content];
}

class GetBotResponseEvent extends DreamInterviewEvent {
  final String interviewId;
  final List<DreamInterviewMessage> previousMessages;

  const GetBotResponseEvent({
    required this.interviewId,
    required this.previousMessages,
  });

  @override
  List<Object?> get props => [interviewId, previousMessages];
}

class CompleteInterviewEvent extends DreamInterviewEvent {
  final String interviewId;

  const CompleteInterviewEvent({
    required this.interviewId,
  });

  @override
  List<Object?> get props => [interviewId];
}

class ConvertVoiceToTextEvent extends DreamInterviewEvent {
  final List<int> audioData;

  const ConvertVoiceToTextEvent({
    required this.audioData,
  });

  @override
  List<Object?> get props => [audioData];
}

class GetCurrentInterviewEvent extends DreamInterviewEvent {
  final String interviewId;

  const GetCurrentInterviewEvent({
    required this.interviewId,
  });

  @override
  List<Object?> get props => [interviewId];
}
