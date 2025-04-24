import 'dart:async';

import 'package:dream_catcher/core/webrtc/webrtc_client.dart';
import 'package:dream_catcher/core/webrtc/webrtc_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([
  MockSpec<WebRtcClient>(),
  MockSpec<MediaDevices>(),
  MockSpec<RTCPeerConnection>(),
])
import 'webrtc_service_test.mocks.dart';

void main() {
  late WebRtcService webRtcService;
  late MockWebRtcClient mockWebRtcClient;
  late MockMediaDevices mockMediaDevices;
  late MockRTCPeerConnection mockPeerConnection;
  const testUrl = 'https://test.openai.com';
  const testToken = 'test-token';

  setUp(() {
    mockWebRtcClient = MockWebRtcClient();
    mockMediaDevices = MockMediaDevices();
    mockPeerConnection = MockRTCPeerConnection();
    webRtcService = WebRtcService(
      client: mockWebRtcClient,
    );
  });

  tearDown(() async {
    await webRtcService.dispose();
  });

  group('WebRtcService 팩토리 메서드 테스트', () {
    test('withOpenAI 팩토리 메서드', () {
      final service = WebRtcService.withOpenAI(
        openaiUrl: testUrl,
        apiToken: testToken,
        mediaDevices: mockMediaDevices,
        peerConnection: mockPeerConnection,
      );

      expect(service, isA<WebRtcService>());
      expect(service.isInitialized, isFalse);
      expect(service.isConnected, isFalse);
      expect(service.isStreaming, isFalse);
    });
  });

  group('WebRtcService 초기화 테스트', () {
    test('초기화 전 상태 확인', () {
      expect(webRtcService.isInitialized, isFalse);
      when(mockWebRtcClient.isConnected).thenReturn(false);
      when(mockWebRtcClient.isStreaming).thenReturn(false);

      expect(webRtcService.isConnected, isFalse);
      expect(webRtcService.isStreaming, isFalse);
    });

    test('초기화 성공', () async {
      when(mockWebRtcClient.initialize()).thenAnswer((_) async {});

      await webRtcService.initialize();

      expect(webRtcService.isInitialized, isTrue);
      verify(mockWebRtcClient.initialize()).called(1);
    });

    test('중복 초기화 처리', () async {
      when(mockWebRtcClient.initialize()).thenAnswer((_) async {});

      await webRtcService.initialize();
      await webRtcService.initialize();

      verify(mockWebRtcClient.initialize()).called(1);
    });
  });

  group('WebRtcService 연결 테스트', () {
    setUp(() async {
      when(mockWebRtcClient.initialize()).thenAnswer((_) async {});
      await webRtcService.initialize();
    });

    test('연결 성공', () async {
      when(mockWebRtcClient.connect()).thenAnswer((_) async {});
      when(mockWebRtcClient.isConnected).thenReturn(true);

      await webRtcService.connect();

      verify(mockWebRtcClient.connect()).called(1);
      expect(webRtcService.isConnected, isTrue);
    });

    test('초기화되지 않은 상태에서 연결 시도', () async {
      webRtcService = WebRtcService(
        client: mockWebRtcClient,
      );

      expect(
        () => webRtcService.connect(),
        throwsException,
      );
    });
  });

  group('WebRtcService 스트리밍 테스트', () {
    setUp(() async {
      when(mockWebRtcClient.initialize()).thenAnswer((_) async {});
      await webRtcService.initialize();
    });

    test('스트리밍 시작', () async {
      when(mockWebRtcClient.startAudioStream()).thenAnswer((_) async {});
      when(mockWebRtcClient.isStreaming).thenReturn(true);

      await webRtcService.startAudioStream();

      verify(mockWebRtcClient.startAudioStream()).called(1);
      expect(webRtcService.isStreaming, isTrue);
    });

    test('스트리밍 중지', () async {
      when(mockWebRtcClient.stopAudioStream()).thenAnswer((_) async {});
      when(mockWebRtcClient.isStreaming).thenReturn(false);

      await webRtcService.stopAudioStream();

      verify(mockWebRtcClient.stopAudioStream()).called(1);
      expect(webRtcService.isStreaming, isFalse);
    });
  });

  group('WebRtcService 이벤트 스트림 테스트', () {
    setUp(() async {
      when(mockWebRtcClient.initialize()).thenAnswer((_) async {});
      await webRtcService.initialize();
    });

    test('이벤트 스트림 수신', () async {
      final testEvents = [
        WebRtcEvent(WebRtcEventType.connecting),
        WebRtcEvent(WebRtcEventType.connected),
      ];

      when(mockWebRtcClient.eventStream)
          .thenAnswer((_) => Stream.fromIterable(testEvents));

      expect(
        webRtcService.events,
        emitsInOrder(testEvents),
      );
    });

    test('응답 스트림 수신', () async {
      final testResponses = ['응답1', '응답2', '응답3'];

      when(mockWebRtcClient.responseStream)
          .thenAnswer((_) => Stream.fromIterable(testResponses));

      expect(
        webRtcService.responses,
        emitsInOrder(testResponses),
      );
    });
  });

  group('WebRtcService 자원 해제 테스트', () {
    setUp(() async {
      when(mockWebRtcClient.initialize()).thenAnswer((_) async {});
      await webRtcService.initialize();
    });

    test('자원 해제 성공', () async {
      when(mockWebRtcClient.dispose()).thenAnswer((_) async {});

      await webRtcService.dispose();

      verify(mockWebRtcClient.dispose()).called(1);
      expect(webRtcService.isInitialized, isFalse);
    });
  });
}
