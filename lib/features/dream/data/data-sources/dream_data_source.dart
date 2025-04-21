import 'package:dream_catcher/features/dream/data/models/dream_detail_model.dart';
import 'package:dream_catcher/features/dream/data/models/dream_list_model.dart';

abstract class DreamDataSource {
  Future<DreamListModel> getDreams();
  Future<DreamDetailModel> getDream(String dreamId);
  Future<void> saveDream(DreamDetailModel dream);
  Future<void> updateDream(DreamDetailModel dream);
  Future<void> deleteDream(String dreamId);
  Future<DreamListModel> searchDreams(String query);
  Future<DreamListModel> filterDreamsByMood(String mood);
  Future<DreamListModel> filterDreamsByDate(
      DateTime startDate, DateTime endDate);
}
