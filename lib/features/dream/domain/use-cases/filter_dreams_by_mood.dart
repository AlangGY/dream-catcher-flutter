import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/use-cases/use_case.dart';
import '../entities/dream_list.dart';
import '../repositories/dream_repository.dart';

class FilterDreamsByMood
    implements UseCase<DreamList, FilterDreamsByMoodParams> {
  final DreamRepository repository;

  FilterDreamsByMood(this.repository);

  @override
  Future<Either<Failure, DreamList>> call(
      FilterDreamsByMoodParams params) async {
    return repository.filterDreamsByMood(params.mood);
  }
}

class FilterDreamsByMoodParams extends Equatable {
  final String mood;

  const FilterDreamsByMoodParams({required this.mood});

  @override
  List<Object?> get props => [mood];
}
