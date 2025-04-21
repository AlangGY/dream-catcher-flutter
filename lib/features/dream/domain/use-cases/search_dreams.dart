import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/use-cases/use_case.dart';
import '../entities/dream_list.dart';
import '../repositories/dream_repository.dart';

class SearchDreams implements UseCase<DreamList, SearchDreamsParams> {
  final DreamRepository repository;

  SearchDreams(this.repository);

  @override
  Future<Either<Failure, DreamList>> call(SearchDreamsParams params) async {
    return repository.searchDreams(params.query);
  }
}

class SearchDreamsParams extends Equatable {
  final String query;

  const SearchDreamsParams({required this.query});

  @override
  List<Object?> get props => [query];
}
