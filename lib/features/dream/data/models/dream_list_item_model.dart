import 'package:dream_catcher/core/data/model.dart';
import 'package:dream_catcher/features/dream/domain/entities/dream_list.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class DreamListItemModel extends Equatable implements Model<DreamListItem> {
  final String id;
  final String title;
  final DateTime date;
  final String mood;
  final Color color;
  final String content;

  const DreamListItemModel({
    required this.id,
    required this.title,
    required this.date,
    required this.mood,
    required this.color,
    required this.content,
  });

  @override
  List<Object?> get props =>
      [title, date.toString(), mood, color.value, content];

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'date': date.toIso8601String(),
      'mood': mood,
      'color': color.value,
      'content': content,
    };
  }

  @override
  DreamListItem toEntity() {
    return DreamListItem(
      id: id,
      title: title,
      date: date,
      mood: mood,
      color: color,
      content: content,
    );
  }
}

class DreamListItemModelFactory
    implements ModelFactory<DreamListItemModel, DreamListItem> {
  const DreamListItemModelFactory();

  @override
  DreamListItemModel fromEntity(DreamListItem entity) {
    return DreamListItemModel(
      title: entity.title,
      date: entity.date,
      mood: entity.mood,
      color: entity.color,
      content: entity.content,
      id: entity.id,
    );
  }

  @override
  DreamListItemModel fromJson(Map<String, dynamic> json) {
    return DreamListItemModel(
      id: json['id'],
      title: json['title'],
      date: DateTime.parse(json['date']),
      mood: json['mood'],
      color: Color(json['color']),
      content: json['content'],
    );
  }
}
