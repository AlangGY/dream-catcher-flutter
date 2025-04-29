import 'package:dream_catcher/core/data/model.dart';
import 'package:dream_catcher/features/dream/domain/entities/dream_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class DreamDetailModel extends Equatable implements Model<DreamDetail> {
  final String id;
  final String title;
  final DateTime date;
  final String mood;
  final Color color;
  final String content;
  final List<String> tags;
  final String interpretation;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int clarity;
  final int vividness;

  const DreamDetailModel({
    required this.id,
    required this.title,
    required this.date,
    required this.mood,
    required this.color,
    required this.content,
    required this.tags,
    required this.interpretation,
    required this.createdAt,
    required this.updatedAt,
    required this.clarity,
    required this.vividness,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        date.toString(),
        mood,
        color.toString(),
        content,
        tags,
        interpretation,
        clarity,
        vividness,
      ];

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'date': date.toIso8601String(),
      'mood': mood,
      'color': "#${color.value.toRadixString(16).substring(2).padLeft(6, '0')}",
      'content': content,
      "analysis": {
        "interpretation": interpretation,
        "keywords": tags,
        "clarity": clarity,
        "vividness": vividness,
      },
      "createdAt": date.toIso8601String(),
      "updatedAt": date.toIso8601String(),
    };
  }

  @override
  DreamDetail toEntity() {
    return DreamDetail(
      id: id,
      title: title,
      date: date,
      mood: mood,
      color: color,
      content: content,
      tags: tags,
      interpretation: interpretation,
      createdAt: createdAt,
      updatedAt: updatedAt,
      clarity: clarity,
      vividness: vividness,
    );
  }
}

class DreamDetailModelFactory
    implements ModelFactory<DreamDetailModel, DreamDetail> {
  const DreamDetailModelFactory();

  @override
  DreamDetailModel fromEntity(DreamDetail entity) {
    return DreamDetailModel(
      id: entity.id,
      title: entity.title,
      date: entity.date,
      mood: entity.mood,
      color: entity.color,
      content: entity.content,
      tags: entity.tags,
      interpretation: entity.interpretation,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      clarity: entity.clarity,
      vividness: entity.vividness,
    );
  }

  @override
  DreamDetailModel fromJson(Map<String, dynamic> json) {
    return DreamDetailModel(
      id: json['id'],
      title: json['title'],
      date: DateTime.parse(json['date']),
      mood: json['mood'],
      color: Color(
        int.parse(json['color'].toString().replaceAll('#', ''), radix: 16),
      ).withAlpha(255),
      content: json['content'],
      tags: json['analysis'] != null
          ? List<String>.from(json['analysis']['keywords'])
          : [],
      interpretation:
          json['analysis'] != null ? json['analysis']['interpretation'] : '',
      clarity: json['analysis'] != null ? json['analysis']['clarity'] : 0,
      vividness: json['analysis'] != null ? json['analysis']['vividness'] : 0,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
