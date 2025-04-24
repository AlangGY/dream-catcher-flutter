import 'dart:async';

import 'package:dream_catcher/core/webrtc/openai_realtime_api_service.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

import 'openai_webrtc_client.dart';
import 'webrtc_client.dart';

/// WebRTC 서비스
/// 앱에서 WebRTC 기능을 사용하기 위한 서비스 클래스
class WebRtcService {
  /// WebRTC 클라이언트 인스턴스
  final WebRtcClient _client;

  /// WebRTC 초기화 상태
  bool _isInitialized = false;

  /// 생성자
  WebRtcService({
    required WebRtcClient client,
  }) : _client = client;

  /// OpenAI WebRTC 클라이언트를 사용하는 팩토리 메서드
  factory WebRtcService.withOpenAI({
    required String openaiUrl,
    required String apiToken,
    required MediaDevices mediaDevices,
    required RTCPeerConnection peerConnection,
  }) {
    return WebRtcService(
      client: OpenAIWebRtcClient(
        enableLogging: true,
        apiService: OpenAIRealtimeApiService(apiKey: apiToken),
        navigator: navigator,
        peerConnection: peerConnection,
      ),
    );
  }

  /// WebRTC 클라이언트 초기화
  Future<void> initialize() async {
    if (_isInitialized) return;

    await _client.initialize();
    _isInitialized = true;
  }

  /// WebRTC 연결 시작
  Future<void> connect() async {
    _ensureInitialized();
    await _client.connect();
  }

  /// WebRTC 연결 종료
  Future<void> disconnect() async {
    await _client.disconnect();
  }

  /// 오디오 스트리밍 시작
  Future<void> startAudioStream() async {
    _ensureInitialized();
    await _client.startAudioStream();
  }

  /// 오디오 스트리밍 중지
  Future<void> stopAudioStream() async {
    await _client.stopAudioStream();
  }

  /// WebRTC 이벤트 스트림 제공
  Stream<WebRtcEvent> get events {
    _ensureInitialized();
    return _client.eventStream;
  }

  /// 응답 텍스트 스트림 제공
  Stream<String> get responses {
    _ensureInitialized();
    return _client.responseStream;
  }

  /// 연결 상태 확인
  bool get isConnected => _client.isConnected;

  /// 스트리밍 상태 확인
  bool get isStreaming => _client.isStreaming;

  /// 초기화 상태 확인
  bool get isInitialized => _isInitialized;

  /// 초기화 상태 확인 헬퍼 메소드
  void _ensureInitialized() {
    if (!_isInitialized) {
      throw Exception('WebRTC service not initialized');
    }
  }

  /// 자원 해제
  Future<void> dispose() async {
    await _client.dispose();
    _isInitialized = false;
  }
}
