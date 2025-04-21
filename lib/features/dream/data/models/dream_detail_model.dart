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
  final List<String> people;
  final int clearness;
  final int lucidity;
  final String symbolism;
  final String interpretation;

  const DreamDetailModel({
    required this.id,
    required this.title,
    required this.date,
    required this.mood,
    required this.color,
    required this.content,
    required this.tags,
    required this.people,
    required this.clearness,
    required this.lucidity,
    required this.symbolism,
    required this.interpretation,
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
        people,
        clearness,
        lucidity,
        symbolism,
        interpretation
      ];

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'date': date.toIso8601String(),
      'mood': mood,
      'color': color.value,
      'content': content,
      'tags': tags,
      'people': people,
      'clearness': clearness,
      'lucidity': lucidity,
      'symbolism': symbolism,
      'interpretation': interpretation,
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
      people: people,
      clearness: clearness,
      lucidity: lucidity,
      symbolism: symbolism,
      interpretation: interpretation,
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
      people: entity.people,
      clearness: entity.clearness,
      lucidity: entity.lucidity,
      symbolism: entity.symbolism,
      interpretation: entity.interpretation,
    );
  }

  @override
  DreamDetailModel fromJson(Map<String, dynamic> json) {
    return DreamDetailModel(
      id: json['id'],
      title: json['title'],
      date: DateTime.parse(json['date']),
      mood: json['mood'],
      color: Color(json['color']),
      content: json['content'],
      tags: List<String>.from(json['tags']),
      people: List<String>.from(json['people']),
      clearness: json['clearness'],
      lucidity: json['lucidity'],
      symbolism: json['symbolism'],
      interpretation: json['interpretation'],
    );
  }
}
