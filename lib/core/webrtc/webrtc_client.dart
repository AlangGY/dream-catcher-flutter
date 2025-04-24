import 'dart:async';

/// WebRTC 클라이언트 인터페이스
/// OpenAI 실시간 API와의 WebRTC 연결을 관리합니다.
abstract class WebRtcClient {
  /// WebRTC 연결 초기화
  Future<void> initialize();

  /// WebRTC 연결 시작
  Future<void> connect();

  /// WebRTC 연결 종료
  Future<void> disconnect();

  /// 오디오 스트림 시작
  Future<void> startAudioStream();

  /// 오디오 스트림 중지
  Future<void> stopAudioStream();

  /// WebRTC 이벤트 스트림
  Stream<WebRtcEvent> get eventStream;

  /// 응답 데이터 스트림
  Stream<String> get responseStream;

  /// 연결 상태 확인
  bool get isConnected;

  /// 오디오 스트림 활성화 상태 확인
  bool get isStreaming;

  /// 자원 해제
  Future<void> dispose();
}

/// WebRTC 이벤트 타입
enum WebRtcEventType {
  connecting,
  connected,
  disconnected,
  failed,
  streamStarted,
  streamStopped,
  messageReceived,
  error,
}

/// WebRTC 이벤트 클래스
class WebRtcEvent {
  final WebRtcEventType type;
  final dynamic data;

  WebRtcEvent(this.type, [this.data]);

  @override
  String toString() => 'WebRtcEvent(type: $type, data: $data)';
}
