import 'package:dream_catcher/core/webrtc/openai_realtime_api_service.dart';
import 'package:dream_catcher/core/webrtc/openai_webrtc_client.dart';
import 'package:dream_catcher/core/webrtc/webrtc_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart' hide MediaDevices;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:webrtc_interface/webrtc_interface.dart'
    show MediaDevices, Navigator;

@GenerateNiceMocks([
  MockSpec<RTCPeerConnection>(),
  MockSpec<MediaStream>(),
  MockSpec<RTCDataChannel>(),
  MockSpec<OpenAIRealtimeApiService>(),
  MockSpec<MediaDevices>(),
  MockSpec<Navigator>(),
])
import 'openai_webrtc_client_test.mocks.dart';

void main() {
  late OpenAIWebRtcClient client;
  late MockRTCPeerConnection mockPeerConnection;
  late MockMediaStream mockLocalStream;
  late MockRTCDataChannel mockDataChannel;
  late MockOpenAIRealtimeApiService mockApiService;
  late MockNavigator mockNavigator;
  late MockMediaDevices mockMediaDevices;

  const testUrl = 'https://test.openai.com';
  const testToken = 'test-token';

  setUp(() async {
    mockPeerConnection = MockRTCPeerConnection();
    mockLocalStream = MockMediaStream();
    mockDataChannel = MockRTCDataChannel();
    mockApiService = MockOpenAIRealtimeApiService();
    mockNavigator = MockNavigator();
    mockMediaDevices = MockMediaDevices();

    // PeerConnection 이벤트 핸들러를 저장할 변수들
    Function(RTCIceCandidate)? storedOnIceCandidate;
    Function(RTCIceConnectionState)? storedOnIceConnectionState;
    Function(RTCPeerConnectionState)? storedOnConnectionState;
    Function(RTCTrackEvent)? storedOnTrack;
    Function(RTCDataChannel)? storedOnDataChannel;

    // 데이터 채널 이벤트 핸들러를 저장할 변수들
    Function(RTCDataChannelMessage)? storedOnMessage;
    Function(RTCDataChannelState)? storedOnDataChannelState;

    // 이벤트 핸들러 getter/setter 모킹
    when(mockPeerConnection.onIceCandidate)
        .thenAnswer((_) => storedOnIceCandidate);
    when(mockPeerConnection.onIceConnectionState)
        .thenAnswer((_) => storedOnIceConnectionState);
    when(mockPeerConnection.onConnectionState)
        .thenAnswer((_) => storedOnConnectionState);
    when(mockPeerConnection.onTrack).thenAnswer((_) => storedOnTrack);
    when(mockPeerConnection.onDataChannel)
        .thenAnswer((_) => storedOnDataChannel);

    when(mockPeerConnection.onIceCandidate = any).thenAnswer((invocation) {
      storedOnIceCandidate = invocation.positionalArguments[0];
    });
    when(mockPeerConnection.onIceConnectionState = any)
        .thenAnswer((invocation) {
      storedOnIceConnectionState = invocation.positionalArguments[0];
    });
    when(mockPeerConnection.onConnectionState = any).thenAnswer((invocation) {
      storedOnConnectionState = invocation.positionalArguments[0];
    });
    when(mockPeerConnection.onTrack = any).thenAnswer((invocation) {
      storedOnTrack = invocation.positionalArguments[0];
    });
    when(mockPeerConnection.onDataChannel = any).thenAnswer((invocation) {
      storedOnDataChannel = invocation.positionalArguments[0];
    });

    // 데이터 채널 이벤트 핸들러 getter/setter 모킹
    when(mockDataChannel.onMessage).thenAnswer((_) => storedOnMessage);
    when(mockDataChannel.onDataChannelState)
        .thenAnswer((_) => storedOnDataChannelState);

    when(mockDataChannel.onMessage = any).thenAnswer((invocation) {
      storedOnMessage = invocation.positionalArguments[0];
    });
    when(mockDataChannel.onDataChannelState = any).thenAnswer((invocation) {
      storedOnDataChannelState = invocation.positionalArguments[0];
    });

    when(mockNavigator.mediaDevices).thenReturn(mockMediaDevices);
    when(mockMediaDevices.getUserMedia(any))
        .thenAnswer((_) async => mockLocalStream);
    when(mockLocalStream.getAudioTracks()).thenReturn([]);
    when(mockPeerConnection.createDataChannel(any, any))
        .thenAnswer((_) async => mockDataChannel);
    when(mockDataChannel.label).thenReturn('text');
    when(mockDataChannel.state)
        .thenReturn(RTCDataChannelState.RTCDataChannelOpen);

    client = OpenAIWebRtcClient(
      enableLogging: true,
      apiService: mockApiService,
      navigator: mockNavigator,
      peerConnection: mockPeerConnection,
    );
  });

  group('OpenAIWebRtcClient 초기화 테스트', () {
    test('초기화 성공', () async {
      when(mockPeerConnection.getLocalDescription())
          .thenAnswer((_) async => null);

      await client.initialize();

      expect(client.isConnected, isFalse);
      expect(client.isStreaming, isFalse);
    });

    test('초기화 실패 - 미디어 접근 거부', () async {
      when(mockMediaDevices.getUserMedia(any))
          .thenThrow(Exception('미디어 접근이 거부되었습니다.'));

      expect(
        () => client.initialize(),
        throwsException,
      );
    });
  });

  group('OpenAIWebRtcClient 연결 테스트', () {
    late RTCSessionDescription mockOffer;
    late RTCSessionDescription mockAnswer;

    setUp(() async {
      await client.initialize();

      mockOffer = RTCSessionDescription('offer', 'offer');
      mockAnswer = RTCSessionDescription('answer', 'answer');

      when(mockPeerConnection.createOffer(any))
          .thenAnswer((_) async => mockOffer);
      when(mockPeerConnection.setLocalDescription(mockOffer))
          .thenAnswer((_) async {});
      when(mockPeerConnection.getLocalDescription())
          .thenAnswer((_) async => mockOffer);
      when(mockApiService.initiateWebRtcConnection(sdp: anyNamed('sdp')))
          .thenAnswer((_) async => mockAnswer);
      when(mockPeerConnection.setRemoteDescription(mockAnswer))
          .thenAnswer((_) async {});
    });

    test('연결 성공', () async {
      final events = <WebRtcEventType>[];
      client.eventStream.listen((event) {
        events.add(event.type);
      });

      await client.connect();

      verify(mockPeerConnection.createOffer(any)).called(1);
      verify(mockPeerConnection.setLocalDescription(mockOffer)).called(1);
      verify(mockPeerConnection.setRemoteDescription(any)).called(1);

      // 연결 상태 변경 시뮬레이션
      mockPeerConnection.onIceConnectionState!(
          RTCIceConnectionState.RTCIceConnectionStateConnected);

      // 이벤트가 처리될 때까지 대기
      await Future.delayed(const Duration(milliseconds: 100));

      expect(client.isConnected, isTrue);
      expect(events, contains(WebRtcEventType.connected));
    });

    test('연결 실패 - Offer 생성 실패', () async {
      when(mockPeerConnection.createOffer(any))
          .thenThrow(Exception('Offer 생성 실패'));

      expect(() => client.connect(), throwsException);
    });
  });

  group('OpenAIWebRtcClient 스트리밍 테스트', () {
    setUp(() async {
      await client.initialize();

      final mockOffer = RTCSessionDescription('offer', 'offer');
      final mockAnswer = RTCSessionDescription('answer', 'answer');

      when(mockPeerConnection.createOffer(any))
          .thenAnswer((_) async => mockOffer);
      when(mockPeerConnection.setLocalDescription(mockOffer))
          .thenAnswer((_) async {});
      when(mockPeerConnection.getLocalDescription())
          .thenAnswer((_) async => mockOffer);
      when(mockApiService.initiateWebRtcConnection(sdp: anyNamed('sdp')))
          .thenAnswer((_) async => mockAnswer);
      when(mockPeerConnection.setRemoteDescription(mockAnswer))
          .thenAnswer((_) async {});

      await client.connect();

      // 연결 상태 변경 시뮬레이션
      mockPeerConnection.onIceConnectionState!(
          RTCIceConnectionState.RTCIceConnectionStateConnected);
    });

    test('스트리밍 시작', () async {
      await client.startAudioStream();
      expect(client.isStreaming, isTrue);
    });

    test('스트리밍 중지', () async {
      await client.startAudioStream();
      await client.stopAudioStream();
      expect(client.isStreaming, isFalse);
    });
  });

  group('OpenAIWebRtcClient 이벤트 테스트', () {
    setUp(() async {
      await client.initialize();

      final mockOffer = RTCSessionDescription('offer', 'offer');
      final mockAnswer = RTCSessionDescription('answer', 'answer');

      when(mockPeerConnection.createOffer(any))
          .thenAnswer((_) async => mockOffer);
      when(mockPeerConnection.setLocalDescription(mockOffer))
          .thenAnswer((_) async {});
      when(mockPeerConnection.getLocalDescription())
          .thenAnswer((_) async => mockOffer);
      when(mockApiService.initiateWebRtcConnection(sdp: anyNamed('sdp')))
          .thenAnswer((_) async => mockAnswer);
      when(mockPeerConnection.setRemoteDescription(mockAnswer))
          .thenAnswer((_) async {});

      await client.connect();
    });

    test('연결 상태 이벤트', () async {
      final events = <WebRtcEventType>[];
      client.eventStream.listen((event) {
        events.add(event.type);
      });

      // 이벤트 리스너가 등록될 때까지 대기
      await Future.delayed(const Duration(milliseconds: 100));

      // ICE 연결 상태 변경 시뮬레이션
      mockPeerConnection.onIceConnectionState!(
          RTCIceConnectionState.RTCIceConnectionStateConnected);

      // 이벤트가 처리될 때까지 대기
      await Future.delayed(const Duration(milliseconds: 100));

      expect(events, contains(WebRtcEventType.connected));
    });

    test('메시지 수신 이벤트', () async {
      const testMessage = '테스트 메시지';
      final events = <WebRtcEvent>[];

      client.eventStream.listen((event) {
        events.add(event);
      });

      // 이벤트 리스너가 등록될 때까지 대기
      await Future.delayed(const Duration(milliseconds: 100));

      // 데이터 채널 메시지 수신 시뮬레이션
      mockDataChannel.onMessage!(RTCDataChannelMessage(testMessage));

      // 이벤트가 처리될 때까지 대기
      await Future.delayed(const Duration(milliseconds: 100));

      expect(
        events,
        contains(
          predicate<WebRtcEvent>(
            (e) =>
                e.type == WebRtcEventType.messageReceived &&
                e.data == testMessage,
          ),
        ),
      );
    });
  });

  group('OpenAIWebRtcClient 자원 해제 테스트', () {
    setUp(() async {
      when(mockPeerConnection.close()).thenAnswer((_) async {});
      when(mockLocalStream.dispose()).thenAnswer((_) async {});
      when(mockDataChannel.close()).thenAnswer((_) async {});

      await client.dispose();

      verify(mockPeerConnection.close()).called(1);
      verify(mockLocalStream.dispose()).called(1);
      verify(mockDataChannel.close()).called(1);
    });
  });
}
