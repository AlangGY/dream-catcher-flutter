import 'package:dream_catcher/core/data/model.dart';
import 'package:dream_catcher/features/dream/domain/entities/dream_interview.dart';
import 'package:equatable/equatable.dart';

class DreamInterviewModel extends Equatable implements Model<DreamInterview> {
  final String id;
  final List<DreamInterviewMessageModel> messages;
  final DateTime date;
  final bool isCompleted;
  final DateTime createdAt;
  final DateTime updatedAt;

  const DreamInterviewModel({
    required this.id,
    required this.messages,
    required this.date,
    required this.isCompleted,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props =>
      [id, messages, date.toString(), isCompleted, createdAt, updatedAt];

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'messages': messages.map((message) => message.toJson()).toList(),
      'status': isCompleted ? 'COMPLETED' : 'IN_PROGRESS',
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  @override
  DreamInterview toEntity() {
    return DreamInterview(
      id: id,
      messages: messages.map((message) => message.toEntity()).toList(),
      date: date,
      isCompleted: isCompleted,
    );
  }
}

class DreamInterviewMessageModel extends Equatable
    implements Model<DreamInterviewMessage> {
  final String id;
  final SpeakerType speakerType;
  final String content;
  final DateTime timestamp;

  const DreamInterviewMessageModel({
    required this.id,
    required this.speakerType,
    required this.content,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [id, speakerType, content, timestamp.toString()];

  @override
  Map<String, dynamic> toJson() {
    final speaker = speakerType == SpeakerType.me ? 'USER' : 'AI';
    return {
      'id': id,
      'speaker': speaker,
      'message': content,
      'sentAt': timestamp.toIso8601String(),
    };
  }

  @override
  DreamInterviewMessage toEntity() {
    return DreamInterviewMessage(
      id: id,
      speakerType: speakerType,
      content: content,
      timestamp: timestamp,
    );
  }
}

class DreamInterviewModelFactory
    implements ModelFactory<DreamInterviewModel, DreamInterview> {
  const DreamInterviewModelFactory();

  @override
  DreamInterviewModel fromEntity(DreamInterview entity) {
    return DreamInterviewModel(
      id: entity.id,
      messages: entity.messages
          .map((message) =>
              const DreamInterviewMessageModelFactory().fromEntity(message))
          .toList(),
      date: entity.date,
      isCompleted: entity.isCompleted,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  @override
  DreamInterviewModel fromJson(Map<String, dynamic> json) {
    return DreamInterviewModel(
      id: json['id'],
      messages: json['messages'] != null
          ? (json['messages'] as List)
              .map((messageJson) => const DreamInterviewMessageModelFactory()
                  .fromJson(messageJson as Map<String, dynamic>))
              .toList()
          : [],
      date: DateTime.parse(json['createdAt']),
      isCompleted: json['status'] == 'COMPLETED',
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

class DreamInterviewMessageModelFactory
    implements ModelFactory<DreamInterviewMessageModel, DreamInterviewMessage> {
  const DreamInterviewMessageModelFactory();

  @override
  DreamInterviewMessageModel fromEntity(DreamInterviewMessage entity) {
    return DreamInterviewMessageModel(
      id: entity.id,
      speakerType: entity.speakerType,
      content: entity.content,
      timestamp: entity.timestamp,
    );
  }

  @override
  DreamInterviewMessageModel fromJson(Map<String, dynamic> json) {
    final speakerType =
        json['speaker'] == 'USER' ? SpeakerType.me : SpeakerType.bot;
    return DreamInterviewMessageModel(
      id: json['id'],
      speakerType: speakerType,
      content: json['message'],
      timestamp: DateTime.parse(json['sentAt']),
    );
  }
}
