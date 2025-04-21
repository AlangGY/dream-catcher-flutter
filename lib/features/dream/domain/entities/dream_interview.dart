import 'package:equatable/equatable.dart';

class DreamInterview extends Equatable {
  final String id;
  final List<DreamInterviewMessage> messages;
  final DateTime date;
  final bool isCompleted;

  const DreamInterview({
    required this.id,
    required this.messages,
    required this.date,
    this.isCompleted = false,
  });

  DreamInterview copyWith({
    String? id,
    List<DreamInterviewMessage>? messages,
    DateTime? date,
    bool? isCompleted,
  }) {
    return DreamInterview(
      id: id ?? this.id,
      messages: messages ?? this.messages,
      date: date ?? this.date,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  List<Object?> get props => [id, messages, date, isCompleted];
}

enum SpeakerType {
  me, // "나"
  bot, // "봇"
}

class DreamInterviewMessage extends Equatable {
  final String id;
  final SpeakerType speakerType;
  final String content;
  final DateTime timestamp;

  const DreamInterviewMessage({
    required this.id,
    required this.speakerType,
    required this.content,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [id, speakerType, content, timestamp];
}
