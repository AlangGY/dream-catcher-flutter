import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/use-cases/use_case.dart';
import '../entities/dream_list.dart';
import '../repositories/dream_repository.dart';

class FilterDreamsByDate
    implements UseCase<DreamList, FilterDreamsByDateParams> {
  final DreamRepository repository;

  FilterDreamsByDate(this.repository);

  @override
  Future<Either<Failure, DreamList>> call(
      FilterDreamsByDateParams params) async {
    return repository.filterDreamsByDate(params.startDate, params.endDate);
  }
}

class FilterDreamsByDateParams extends Equatable {
  final DateTime startDate;
  final DateTime endDate;

  const FilterDreamsByDateParams({
    required this.startDate,
    required this.endDate,
  });

  @override
  List<Object?> get props => [startDate, endDate];
}
