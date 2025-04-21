import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/dream_detail.dart';
import '../entities/dream_list.dart';

abstract class DreamRepository {
  Future<Either<Failure, DreamList>> getDreams();
  Future<Either<Failure, DreamDetail>> getDream(String dreamId);
  Future<Either<Failure, Unit>> saveDream(DreamDetail dream);
  Future<Either<Failure, Unit>> updateDream(DreamDetail dream);
  Future<Either<Failure, Unit>> deleteDream(String dreamId);
  Future<Either<Failure, DreamList>> searchDreams(String query);
  Future<Either<Failure, DreamList>> filterDreamsByMood(String mood);
  Future<Either<Failure, DreamList>> filterDreamsByDate(
      DateTime startDate, DateTime endDate);
}
