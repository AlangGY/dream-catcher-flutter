import 'package:dream_catcher/features/dream/data/repositories/dream_repository_impl.dart';
import 'package:dream_catcher/features/dream/domain/use-cases/delete_dream.dart';
import 'package:dream_catcher/features/dream/domain/use-cases/filter_dreams_by_date.dart';
import 'package:dream_catcher/features/dream/domain/use-cases/filter_dreams_by_mood.dart';
import 'package:dream_catcher/features/dream/domain/use-cases/get_dreams.dart';
import 'package:dream_catcher/features/dream/domain/use-cases/save_dream.dart';
import 'package:dream_catcher/features/dream/domain/use-cases/search_dreams.dart';
import 'package:dream_catcher/features/dream/domain/use-cases/update_dream.dart';
import 'package:dream_catcher/features/dream/presentation/bloc/dream_list_bloc.dart';
import 'package:get_it/get_it.dart';

/// DreamListBloc을 생성하고 의존성을 주입해주는 팩토리 클래스
class DreamListBlocFactory {
  /// GetIt을 사용하는 경우
  static DreamListBloc create() {
    final GetIt locator = GetIt.instance;

    return DreamListBloc(
      getDreams: locator<GetDreams>(),
      saveDream: locator<SaveDream>(),
      updateDream: locator<UpdateDream>(),
      deleteDream: locator<DeleteDream>(),
      searchDreams: locator<SearchDreams>(),
      filterDreamsByMood: locator<FilterDreamsByMood>(),
      filterDreamsByDate: locator<FilterDreamsByDate>(),
    );
  }

  /// 직접 의존성을 생성하여 주입하는 경우
  static DreamListBloc createWithRepository(DreamRepositoryImpl repository) {
    return DreamListBloc(
      getDreams: GetDreams(repository),
      saveDream: SaveDream(repository),
      updateDream: UpdateDream(repository),
      deleteDream: DeleteDream(repository),
      searchDreams: SearchDreams(repository),
      filterDreamsByMood: FilterDreamsByMood(repository),
      filterDreamsByDate: FilterDreamsByDate(repository),
    );
  }
}
