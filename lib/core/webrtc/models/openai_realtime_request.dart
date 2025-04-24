import 'dart:convert';

/// OpenAI Realtime API 요청 모델
class OpenAIRealtimeRequest {
  /// 모델 ID
  final String model;

  /// SDP (Session Description Protocol) 정보
  final String sdp;

  /// 선택적 추가 파라미터
  final Map<String, dynamic>? options;

  /// 생성자
  const OpenAIRealtimeRequest({
    required this.model,
    required this.sdp,
    this.options,
  });

  /// JSON 직렬화
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      'model': model,
      'sdp': sdp,
    };

    if (options != null) {
      map.addAll(options!);
    }

    return map;
  }

  /// JSON 문자열로 변환
  String toJsonString() {
    return jsonEncode(toJson());
  }
}
