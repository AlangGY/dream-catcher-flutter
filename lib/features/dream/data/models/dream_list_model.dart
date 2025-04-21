import 'package:dream_catcher/core/data/model.dart';
import 'package:dream_catcher/features/dream/data/models/dream_list_item_model.dart';
import 'package:dream_catcher/features/dream/domain/entities/dream_list.dart';
import 'package:equatable/equatable.dart';

class DreamListModel extends Equatable implements Model<DreamList> {
  final List<DreamListItemModel> dreams;

  const DreamListModel({required this.dreams});

  @override
  List<Object?> get props => [...dreams.map((dream) => dream.props)];

  @override
  Map<String, dynamic> toJson() {
    return {
      'dreams': dreams.map((item) => item.toJson()).toList(),
    };
  }

  @override
  DreamList toEntity() {
    return DreamList(
      dreams: dreams.map((dream) => dream.toEntity()).toList(),
    );
  }
}

class DreamListModelFactory implements ModelFactory<DreamListModel, DreamList> {
  final DreamListItemModelFactory _itemFactory;

  const DreamListModelFactory({
    DreamListItemModelFactory? itemFactory,
  }) : _itemFactory = itemFactory ?? const DreamListItemModelFactory();

  @override
  DreamListModel fromEntity(DreamList entity) {
    return DreamListModel(
      dreams:
          entity.dreams.map((dream) => _itemFactory.fromEntity(dream)).toList(),
    );
  }

  @override
  DreamListModel fromJson(Map<String, dynamic> json) {
    return DreamListModel(
      dreams: (json['dreams'] as List)
          .map((item) => _itemFactory.fromJson(item))
          .toList(),
    );
  }
}
