import 'dart:convert';

import 'package:dream_catcher/features/dream/data/data-sources/dream_data_source.dart';
import 'package:dream_catcher/features/dream/data/models/dream_detail_model.dart';
import 'package:dream_catcher/features/dream/data/models/dream_list_item_model.dart';
import 'package:dream_catcher/features/dream/data/models/dream_list_model.dart';
import 'package:flutter/services.dart' show rootBundle;

class DreamMockDataSource implements DreamDataSource {
  static const dreamListFactory = DreamListModelFactory();
  static const dreamDetailFactory = DreamDetailModelFactory();
  late DreamListModel _dreams;

  Future<void> _loadDreams() async {
    final jsonString =
        await rootBundle.loadString('lib/fixtures/dream_list.json');
    _dreams = dreamListFactory.fromJson(json.decode(jsonString));
  }

  Future<void> init() async {
    await _loadDreams();
  }

  @override
  Future<DreamListModel> getDreams() async {
    await Future.delayed(const Duration(milliseconds: 500)); // 실제 네트워크 지연 시뮬레이션
    return _dreams;
  }

  @override
  Future<DreamDetailModel> getDream(String dreamId) async {
    await Future.delayed(const Duration(milliseconds: 500)); // 실제 네트워크 지연 시뮬레이션

    final jsonString =
        await rootBundle.loadString('lib/fixtures/dream_detail_$dreamId.json');
    return dreamDetailFactory.fromJson(json.decode(jsonString));
  }

  @override
  Future<void> saveDream(DreamDetailModel dream) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final dreamListItem = DreamListItemModel(
        id: dream.id,
        title: dream.title,
        date: dream.date,
        mood: dream.mood,
        color: dream.color,
        content: dream.content);
    _dreams.dreams.add(dreamListItem);
  }

  @override
  Future<void> updateDream(DreamDetailModel dream) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _dreams.dreams.indexWhere((d) => d.title == dream.title);
    if (index != -1) {
      final dreamListItem = DreamListItemModel(
          id: dream.id,
          title: dream.title,
          date: dream.date,
          mood: dream.mood,
          color: dream.color,
          content: dream.content);
      _dreams.dreams[index] = dreamListItem;
    }
  }

  @override
  Future<void> deleteDream(String dreamId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _dreams.dreams.removeWhere((dream) => dream.title == dreamId);
  }

  @override
  Future<DreamListModel> searchDreams(String query) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final filteredDreams = _dreams.dreams.where((dream) {
      return dream.title.toLowerCase().contains(query.toLowerCase()) ||
          dream.content.toLowerCase().contains(query.toLowerCase());
    }).toList();
    return DreamListModel(dreams: filteredDreams);
  }

  @override
  Future<DreamListModel> filterDreamsByMood(String mood) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final filteredDreams =
        _dreams.dreams.where((dream) => dream.mood == mood).toList();
    return DreamListModel(dreams: filteredDreams);
  }

  @override
  Future<DreamListModel> filterDreamsByDate(
      DateTime startDate, DateTime endDate) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final filteredDreams = _dreams.dreams.where((dream) {
      return dream.date.isAfter(startDate.subtract(const Duration(days: 1))) &&
          dream.date.isBefore(endDate.add(const Duration(days: 1)));
    }).toList();
    return DreamListModel(dreams: filteredDreams);
  }
}
