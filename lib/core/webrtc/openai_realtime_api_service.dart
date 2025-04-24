import 'dart:async';

import 'package:dream_catcher/core/webrtc/models/index.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:http/http.dart' as http;

/// OpenAI Realtime API 서비스
/// WebRTC 연결을 위한 OpenAI API와의 통신을 담당
class OpenAIRealtimeApiService {
  /// OpenAI API 베이스 URL
  static const String _baseUrl = 'https://api.openai.com/v1';

  /// WebRTC 엔드포인트
  static const String _webrtcEndpoint = '/realtime';

  final String _ephemeralKey;

  /// 선택한 모델
  final String _model;

  /// HTTP 클라이언트
  final http.Client _httpClient;

  /// 생성자
  OpenAIRealtimeApiService({
    required String apiKey,
    String model = 'gpt-4o-mini-realtime-preview-2024-12-17',
    http.Client? httpClient,
  })  : _ephemeralKey = apiKey,
        _model = model,
        _httpClient = httpClient ?? http.Client();

  /// WebRTC 연결을 위한 API 요청
  /// [sdp]: SDP (Session Description Protocol) 정보
  Future<RTCSessionDescription> initiateWebRtcConnection({
    required String sdp,
  }) async {
    final request = OpenAIRealtimeRequest(
      model: _model,
      sdp: sdp,
    );

    final url = Uri.parse('$_baseUrl$_webrtcEndpoint?model=$_model');

    try {
      final response = await _httpClient.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_ephemeralKey',
        },
        body: request.sdp,
      );

      if (response.statusCode != 200) {
        throw Exception(
          'API 요청 실패: 상태 코드 ${response.statusCode}, 응답: ${response.body}',
        );
      }

      final responseSdp = response.body;

      return RTCSessionDescription(
        responseSdp,
        'answer',
      );
    } catch (e) {
      throw Exception('OpenAI Realtime API 통신 중 오류 발생: $e');
    }
  }

  /// 자원 해제
  void dispose() {
    _httpClient.close();
  }
}
