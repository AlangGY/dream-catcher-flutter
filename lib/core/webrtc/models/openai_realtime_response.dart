/// OpenAI Realtime API 응답 모델
class OpenAIRealtimeResponse {
  /// SDP (Session Description Protocol) 정보
  final String sdp;

  /// SDP 타입 (answer)
  final String type;

  /// 생성자
  const OpenAIRealtimeResponse({
    required this.sdp,
    required this.type,
  });

  /// JSON에서 객체 생성
  factory OpenAIRealtimeResponse.fromJson(Map<String, dynamic> json) {
    return OpenAIRealtimeResponse(
      sdp: json['sdp'] as String,
      type: json['type'] as String,
    );
  }

  /// 객체를 Map으로 변환
  Map<String, dynamic> toJson() {
    return {
      'sdp': sdp,
      'type': type,
    };
  }
}
