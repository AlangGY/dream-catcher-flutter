import 'dart:async';

import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:webrtc_interface/webrtc_interface.dart' show Navigator;

import 'openai_realtime_api_service.dart';
import 'webrtc_client.dart';

/// OpenAI의 실시간 API와 통신하기 위한 WebRTC 클라이언트 구현체
class OpenAIWebRtcClient implements WebRtcClient {
  /// RTCPeerConnection 객체
  late final RTCPeerConnection _peerConnection;

  /// 로컬 오디오 스트림
  MediaStream? _localStream;

  /// 이벤트 컨트롤러
  final _eventController = StreamController<WebRtcEvent>.broadcast();

  /// 응답 데이터 컨트롤러
  final _responseController = StreamController<String>.broadcast();

  /// 연결 상태
  bool _isConnected = false;

  /// 스트리밍 상태
  bool _isStreaming = false;

  /// OpenAI Realtime API 서비스
  late final OpenAIRealtimeApiService _apiService;

  /// 데이터 채널
  RTCDataChannel? _dataChannel;

  /// 로깅 활성화 여부
  final bool enableLogging;

  final Navigator _navigator;

  OpenAIWebRtcClient({
    required this.enableLogging,
    required RTCPeerConnection peerConnection,
    required Navigator navigator,
    required OpenAIRealtimeApiService apiService,
  })  : _peerConnection = peerConnection,
        _navigator = navigator,
        _apiService = apiService;

  static Future<RTCPeerConnection> createDefaultPeerConnection() async {
    final configuration = <String, dynamic>{
      'iceServers': [
        {'urls': 'stun:stun.l.google.com:19302'},
      ],
    };
    return await createPeerConnection(configuration);
  }

  @override
  Future<void> initialize() async {
    _eventController.add(WebRtcEvent(WebRtcEventType.connecting));

    try {
      // 이벤트 핸들러 설정
      _setupPeerConnectionListeners();

      // 데이터 채널 생성
      _setupDataChannel();

      // 미디어 제약 조건 설정
      final mediaConstraints = {
        'audio': true,
        'video': false,
      };

      // 로컬 오디오 스트림 획득
      _localStream =
          await _navigator.mediaDevices.getUserMedia(mediaConstraints);
      _log('로컬 오디오 스트림 획득');

      // 오디오 트랙을 PeerConnection에 추가
      _localStream!.getAudioTracks().forEach((track) {
        _peerConnection.addTrack(track, _localStream!);
        _log('오디오 트랙 추가: ${track.id}');
      });
    } catch (e) {
      _log('초기화 오류: $e', isError: true);
      _eventController.add(WebRtcEvent(WebRtcEventType.error, e.toString()));
      rethrow;
    }
  }

  /// PeerConnection 이벤트 리스너 설정
  void _setupPeerConnectionListeners() {
    _peerConnection.onIceCandidate = (RTCIceCandidate candidate) {
      _log('ICE 후보 생성: ${candidate.candidate}');
      // ICE 후보 처리는 자동으로 이루어짐
      // OpenAI 실시간 API는 Trickle ICE를 지원하지 않으므로
      // SDP에 모든 ICE 후보가 포함되도록 처리
    };
    _peerConnection.onIceConnectionState = (RTCIceConnectionState state) {
      _log('ICE 연결 상태 변경: $state');
      switch (state) {
        case RTCIceConnectionState.RTCIceConnectionStateConnected:
          _isConnected = true;
          _eventController.add(WebRtcEvent(WebRtcEventType.connected));
          break;
        case RTCIceConnectionState.RTCIceConnectionStateDisconnected:
        case RTCIceConnectionState.RTCIceConnectionStateFailed:
          _isConnected = false;
          _eventController.add(WebRtcEvent(WebRtcEventType.disconnected));
          break;
        default:
          break;
      }
    };

    _peerConnection.onConnectionState = (RTCPeerConnectionState state) {
      _log('PeerConnection 상태 변경: $state');
    };

    _peerConnection.onTrack = (RTCTrackEvent event) {
      _log('원격 트랙 수신: ${event.track.kind}');
      if (event.track.kind == 'audio') {
        // 원격 오디오 트랙 처리
        _handleRemoteTrack(event.streams[0]);
      }
    };

    _peerConnection.onDataChannel = (RTCDataChannel channel) {
      _log('원격 데이터 채널 수신: ${channel.label}');
      _setupReceivedDataChannel(channel);
    };
  }

  /// 데이터 채널 설정
  void _setupDataChannel() {
    final dataChannelInit = RTCDataChannelInit();
    dataChannelInit.ordered = true;

    _peerConnection.createDataChannel('text', dataChannelInit).then((channel) {
      _dataChannel = channel;
      _log('데이터 채널 생성됨: ${channel.label}');
      _setupDataChannelListeners(channel);
    }).catchError((e) {
      _log('데이터 채널 생성 오류: $e', isError: true);
    });
  }

  /// 데이터 채널 리스너 설정
  void _setupDataChannelListeners(RTCDataChannel channel) {
    channel.onMessage = (RTCDataChannelMessage message) {
      _handleDataChannelMessage(message);
    };

    channel.onDataChannelState = (RTCDataChannelState state) {
      _log('데이터 채널 상태 변경: $state');
    };
  }

  /// 수신된 데이터 채널 설정
  void _setupReceivedDataChannel(RTCDataChannel channel) {
    _setupDataChannelListeners(channel);
  }

  /// 데이터 채널 메시지 처리
  void _handleDataChannelMessage(RTCDataChannelMessage message) {
    if (message.isBinary) {
      _log('바이너리 메시지 수신 (처리되지 않음)');
      return;
    }

    try {
      final data = message.text;
      _log('텍스트 메시지 수신: $data');
      _responseController.add(data);
      _eventController.add(WebRtcEvent(WebRtcEventType.messageReceived, data));
    } catch (e) {
      _log('메시지 파싱 오류: $e', isError: true);
      _eventController.add(
          WebRtcEvent(WebRtcEventType.error, 'Failed to parse message: $e'));
    }
  }

  /// 원격 오디오 트랙 처리
  void _handleRemoteTrack(MediaStream stream) {
    _log('원격 스트림 처리: ${stream.id}');
    // 여기서 원격 오디오 스트림을 처리할 수 있음
    // 예: 스피커로 출력, 저장 등
  }

  @override
  Future<void> connect() async {
    _log('연결 시작');

    try {
      // SDP 제약 조건
      final offerOptions = {
        'offerToReceiveAudio': true,
        'offerToReceiveVideo': false,
      };

      // Offer 생성
      final offer = await _peerConnection.createOffer(offerOptions);
      _log('Offer SDP 생성됨');
      await _peerConnection.setLocalDescription(offer);
      _log('Local Description 설정됨');

      // 모든 ICE 후보가 수집될 때까지 대기
      // OpenAI WebRTC API는 Trickle ICE를 지원하지 않음
      _log('ICE 후보 수집 대기 중...');
      await Future.delayed(const Duration(seconds: 1));

      // 최종 SDP 가져오기
      final localDesc = await _peerConnection.getLocalDescription();
      if (localDesc == null || localDesc.sdp == null) {
        throw Exception('Failed to get local SDP');
      }
      _log('최종 Local SDP 획득');

      // OpenAI API에 Offer 전송 및 Answer 수신
      _log('OpenAI API에 Offer 전송 중...');
      final response = await _apiService.initiateWebRtcConnection(
        sdp: localDesc.sdp!,
      );
      _log('OpenAI API로부터 Answer 수신됨');

      // Answer SDP 파싱 및 설정
      final sdpAnswer = RTCSessionDescription(
        response.sdp,
        response.type,
      );

      _log('원격 Description 설정 중...');
      await _peerConnection.setRemoteDescription(sdpAnswer);
      _log('원격 Description 설정됨');
    } catch (e) {
      _log('연결 오류: $e', isError: true);
      _eventController.add(WebRtcEvent(WebRtcEventType.error, e.toString()));
      rethrow;
    }
  }

  @override
  Future<void> disconnect() async {
    _log('연결 종료 중...');
    await _peerConnection.close();
    _isConnected = false;
    _eventController.add(WebRtcEvent(WebRtcEventType.disconnected));
    _log('연결 종료됨');
  }

  @override
  Future<void> startAudioStream() async {
    if (!_isConnected) {
      throw Exception('WebRTC is not connected');
    }

    _log('오디오 스트림 시작 중...');
    if (_localStream != null) {
      _localStream!.getAudioTracks().forEach((track) {
        track.enabled = true;
        _log('오디오 트랙 활성화: ${track.id}');
      });

      _isStreaming = true;
      _eventController.add(WebRtcEvent(WebRtcEventType.streamStarted));
      _log('오디오 스트림 시작됨');
    }
  }

  @override
  Future<void> stopAudioStream() async {
    _log('오디오 스트림 중지 중...');
    if (_localStream != null) {
      _localStream!.getAudioTracks().forEach((track) {
        track.enabled = false;
        _log('오디오 트랙 비활성화: ${track.id}');
      });

      _isStreaming = false;
      _eventController.add(WebRtcEvent(WebRtcEventType.streamStopped));
      _log('오디오 스트림 중지됨');
    }
  }

  /// 데이터 채널을 통해 메시지 전송
  Future<void> sendMessage(String message) async {
    if (_dataChannel == null ||
        _dataChannel!.state != RTCDataChannelState.RTCDataChannelOpen) {
      throw Exception('Data channel is not open');
    }

    try {
      _log('메시지 전송 중: $message');
      _dataChannel!.send(RTCDataChannelMessage(message));
      _log('메시지 전송 성공');
    } catch (e) {
      _log('메시지 전송 오류: $e', isError: true);
      rethrow;
    }
  }

  @override
  Stream<WebRtcEvent> get eventStream => _eventController.stream;

  @override
  Stream<String> get responseStream => _responseController.stream;

  @override
  bool get isConnected => _isConnected;

  @override
  bool get isStreaming => _isStreaming;

  @override
  Future<void> dispose() async {
    _log('자원 해제 중...');
    await stopAudioStream();
    await disconnect();

    if (_dataChannel != null) {
      await _dataChannel!.close();
      _dataChannel = null;
    }

    _localStream?.getTracks().forEach((track) {
      track.stop();
      _log('오디오 트랙 중지: ${track.id}');
    });
    _localStream?.dispose();
    _localStream = null;

    _apiService.dispose();

    await _eventController.close();
    await _responseController.close();
    _log('자원 해제 완료');
  }

  /// 로깅 헬퍼 메소드
  void _log(String message, {bool isError = false}) {
    if (enableLogging) {
      final logPrefix =
          isError ? '🔴 [OpenAIWebRtcClient]' : '🟢 [OpenAIWebRtcClient]';
      // ignore: avoid_print
      print('$logPrefix $message');
    }
  }
}
