import 'package:dartz/dartz.dart';
import 'package:dream_catcher/features/dream/data/data-sources/dream_data_source.dart';
import 'package:dream_catcher/features/dream/data/models/dream_detail_model.dart';
import 'package:dream_catcher/features/dream/domain/entities/dream_detail.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/dream_list.dart';
import '../../domain/repositories/dream_repository.dart';
import '../models/dream_list_item_model.dart';
import '../models/dream_list_model.dart';

class DreamRepositoryImpl implements DreamRepository {
  final DreamDataSource dataSource;
  final DreamListModelFactory _listFactory;
  final DreamListItemModelFactory _itemFactory;
  final DreamDetailModelFactory _detailFactory;

  DreamRepositoryImpl({
    required this.dataSource,
    DreamListModelFactory? listFactory,
    DreamListItemModelFactory? itemFactory,
    DreamDetailModelFactory? detailFactory,
  })  : _listFactory = listFactory ?? const DreamListModelFactory(),
        _itemFactory = itemFactory ?? const DreamListItemModelFactory(),
        _detailFactory = detailFactory ?? const DreamDetailModelFactory();

  @override
  Future<Either<Failure, DreamList>> getDreams() async {
    try {
      final result = await dataSource.getDreams();
      return Right(result.toEntity());
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, DreamDetail>> getDream(String dreamId) async {
    try {
      final result = await dataSource.getDream(dreamId);
      return Right(result.toEntity());
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> saveDream(DreamDetail dream) async {
    try {
      await dataSource.saveDream(_detailFactory.fromEntity(dream));
      return const Right(unit);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateDream(DreamDetail dream) async {
    try {
      await dataSource.updateDream(_detailFactory.fromEntity(dream));
      return const Right(unit);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteDream(String dreamId) async {
    try {
      await dataSource.deleteDream(dreamId);
      return const Right(unit);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, DreamList>> searchDreams(String query) async {
    try {
      final result = await dataSource.searchDreams(query);
      return Right(result.toEntity());
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, DreamList>> filterDreamsByMood(String mood) async {
    try {
      final result = await dataSource.filterDreamsByMood(mood);
      return Right(result.toEntity());
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, DreamList>> filterDreamsByDate(
      DateTime startDate, DateTime endDate) async {
    try {
      final result = await dataSource.filterDreamsByDate(startDate, endDate);
      return Right(result.toEntity());
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
