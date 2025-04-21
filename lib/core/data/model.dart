/// 모든 모델 클래스가 구현해야 하는 기본 인터페이스
/// E 타입은 엔티티 타입을 나타냅니다.
abstract class Model<E> {
  /// 모델을 엔티티로 변환
  E toEntity();

  /// 모델을 JSON으로 변환
  Map<String, dynamic> toJson();
}

/// 모델 팩토리 인터페이스
/// M 타입은 모델 타입, E 타입은 엔티티 타입을 나타냅니다.
abstract class ModelFactory<M extends Model<E>, E> {
  /// 엔티티에서 모델 생성
  M fromEntity(E entity);

  /// JSON에서 모델 생성
  M fromJson(Map<String, dynamic> json);
}
