// Mocks generated by Mockito 5.4.4 from annotations
// in dream_catcher/test/core/webrtc/webrtc_service_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:dream_catcher/core/webrtc/webrtc_client.dart' as _i3;
import 'package:flutter_webrtc/flutter_webrtc.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeRTCSessionDescription_0 extends _i1.SmartFake
    implements _i2.RTCSessionDescription {
  _FakeRTCSessionDescription_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeRTCDataChannel_1 extends _i1.SmartFake
    implements _i2.RTCDataChannel {
  _FakeRTCDataChannel_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeRTCDTMFSender_2 extends _i1.SmartFake implements _i2.RTCDTMFSender {
  _FakeRTCDTMFSender_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeRTCRtpSender_3 extends _i1.SmartFake implements _i2.RTCRtpSender {
  _FakeRTCRtpSender_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeRTCRtpTransceiver_4 extends _i1.SmartFake
    implements _i2.RTCRtpTransceiver {
  _FakeRTCRtpTransceiver_4(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [WebRtcClient].
///
/// See the documentation for Mockito's code generation for more information.
class MockWebRtcClient extends _i1.Mock implements _i3.WebRtcClient {
  @override
  _i4.Stream<_i3.WebRtcEvent> get eventStream => (super.noSuchMethod(
        Invocation.getter(#eventStream),
        returnValue: _i4.Stream<_i3.WebRtcEvent>.empty(),
        returnValueForMissingStub: _i4.Stream<_i3.WebRtcEvent>.empty(),
      ) as _i4.Stream<_i3.WebRtcEvent>);

  @override
  _i4.Stream<String> get responseStream => (super.noSuchMethod(
        Invocation.getter(#responseStream),
        returnValue: _i4.Stream<String>.empty(),
        returnValueForMissingStub: _i4.Stream<String>.empty(),
      ) as _i4.Stream<String>);

  @override
  bool get isConnected => (super.noSuchMethod(
        Invocation.getter(#isConnected),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);

  @override
  bool get isStreaming => (super.noSuchMethod(
        Invocation.getter(#isStreaming),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);

  @override
  _i4.Future<void> initialize() => (super.noSuchMethod(
        Invocation.method(
          #initialize,
          [],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<void> connect() => (super.noSuchMethod(
        Invocation.method(
          #connect,
          [],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<void> disconnect() => (super.noSuchMethod(
        Invocation.method(
          #disconnect,
          [],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<void> startAudioStream() => (super.noSuchMethod(
        Invocation.method(
          #startAudioStream,
          [],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<void> stopAudioStream() => (super.noSuchMethod(
        Invocation.method(
          #stopAudioStream,
          [],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<void> dispose() => (super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
}

/// A class which mocks [MediaDevices].
///
/// See the documentation for Mockito's code generation for more information.
class MockMediaDevices extends _i1.Mock implements _i2.MediaDevices {}

/// A class which mocks [RTCPeerConnection].
///
/// See the documentation for Mockito's code generation for more information.
class MockRTCPeerConnection extends _i1.Mock implements _i2.RTCPeerConnection {
  @override
  set onSignalingState(
          dynamic Function(_i2.RTCSignalingState)? _onSignalingState) =>
      super.noSuchMethod(
        Invocation.setter(
          #onSignalingState,
          _onSignalingState,
        ),
        returnValueForMissingStub: null,
      );

  @override
  set onConnectionState(
          dynamic Function(_i2.RTCPeerConnectionState)? _onConnectionState) =>
      super.noSuchMethod(
        Invocation.setter(
          #onConnectionState,
          _onConnectionState,
        ),
        returnValueForMissingStub: null,
      );

  @override
  set onIceGatheringState(
          dynamic Function(_i2.RTCIceGatheringState)? _onIceGatheringState) =>
      super.noSuchMethod(
        Invocation.setter(
          #onIceGatheringState,
          _onIceGatheringState,
        ),
        returnValueForMissingStub: null,
      );

  @override
  set onIceConnectionState(
          dynamic Function(_i2.RTCIceConnectionState)? _onIceConnectionState) =>
      super.noSuchMethod(
        Invocation.setter(
          #onIceConnectionState,
          _onIceConnectionState,
        ),
        returnValueForMissingStub: null,
      );

  @override
  set onIceCandidate(dynamic Function(_i2.RTCIceCandidate)? _onIceCandidate) =>
      super.noSuchMethod(
        Invocation.setter(
          #onIceCandidate,
          _onIceCandidate,
        ),
        returnValueForMissingStub: null,
      );

  @override
  set onAddStream(dynamic Function(_i2.MediaStream)? _onAddStream) =>
      super.noSuchMethod(
        Invocation.setter(
          #onAddStream,
          _onAddStream,
        ),
        returnValueForMissingStub: null,
      );

  @override
  set onRemoveStream(dynamic Function(_i2.MediaStream)? _onRemoveStream) =>
      super.noSuchMethod(
        Invocation.setter(
          #onRemoveStream,
          _onRemoveStream,
        ),
        returnValueForMissingStub: null,
      );

  @override
  set onAddTrack(
          dynamic Function(
            _i2.MediaStream,
            _i2.MediaStreamTrack,
          )? _onAddTrack) =>
      super.noSuchMethod(
        Invocation.setter(
          #onAddTrack,
          _onAddTrack,
        ),
        returnValueForMissingStub: null,
      );

  @override
  set onRemoveTrack(
          dynamic Function(
            _i2.MediaStream,
            _i2.MediaStreamTrack,
          )? _onRemoveTrack) =>
      super.noSuchMethod(
        Invocation.setter(
          #onRemoveTrack,
          _onRemoveTrack,
        ),
        returnValueForMissingStub: null,
      );

  @override
  set onDataChannel(dynamic Function(_i2.RTCDataChannel)? _onDataChannel) =>
      super.noSuchMethod(
        Invocation.setter(
          #onDataChannel,
          _onDataChannel,
        ),
        returnValueForMissingStub: null,
      );

  @override
  set onRenegotiationNeeded(dynamic Function()? _onRenegotiationNeeded) =>
      super.noSuchMethod(
        Invocation.setter(
          #onRenegotiationNeeded,
          _onRenegotiationNeeded,
        ),
        returnValueForMissingStub: null,
      );

  @override
  set onTrack(dynamic Function(_i2.RTCTrackEvent)? _onTrack) =>
      super.noSuchMethod(
        Invocation.setter(
          #onTrack,
          _onTrack,
        ),
        returnValueForMissingStub: null,
      );

  @override
  Map<String, dynamic> get getConfiguration => (super.noSuchMethod(
        Invocation.getter(#getConfiguration),
        returnValue: <String, dynamic>{},
        returnValueForMissingStub: <String, dynamic>{},
      ) as Map<String, dynamic>);

  @override
  _i4.Future<List<_i2.RTCRtpSender>> get senders => (super.noSuchMethod(
        Invocation.getter(#senders),
        returnValue:
            _i4.Future<List<_i2.RTCRtpSender>>.value(<_i2.RTCRtpSender>[]),
        returnValueForMissingStub:
            _i4.Future<List<_i2.RTCRtpSender>>.value(<_i2.RTCRtpSender>[]),
      ) as _i4.Future<List<_i2.RTCRtpSender>>);

  @override
  _i4.Future<List<_i2.RTCRtpReceiver>> get receivers => (super.noSuchMethod(
        Invocation.getter(#receivers),
        returnValue:
            _i4.Future<List<_i2.RTCRtpReceiver>>.value(<_i2.RTCRtpReceiver>[]),
        returnValueForMissingStub:
            _i4.Future<List<_i2.RTCRtpReceiver>>.value(<_i2.RTCRtpReceiver>[]),
      ) as _i4.Future<List<_i2.RTCRtpReceiver>>);

  @override
  _i4.Future<List<_i2.RTCRtpTransceiver>> get transceivers =>
      (super.noSuchMethod(
        Invocation.getter(#transceivers),
        returnValue: _i4.Future<List<_i2.RTCRtpTransceiver>>.value(
            <_i2.RTCRtpTransceiver>[]),
        returnValueForMissingStub:
            _i4.Future<List<_i2.RTCRtpTransceiver>>.value(
                <_i2.RTCRtpTransceiver>[]),
      ) as _i4.Future<List<_i2.RTCRtpTransceiver>>);

  @override
  _i4.Future<_i2.RTCSignalingState?> getSignalingState() => (super.noSuchMethod(
        Invocation.method(
          #getSignalingState,
          [],
        ),
        returnValue: _i4.Future<_i2.RTCSignalingState?>.value(),
        returnValueForMissingStub: _i4.Future<_i2.RTCSignalingState?>.value(),
      ) as _i4.Future<_i2.RTCSignalingState?>);

  @override
  _i4.Future<_i2.RTCIceGatheringState?> getIceGatheringState() =>
      (super.noSuchMethod(
        Invocation.method(
          #getIceGatheringState,
          [],
        ),
        returnValue: _i4.Future<_i2.RTCIceGatheringState?>.value(),
        returnValueForMissingStub:
            _i4.Future<_i2.RTCIceGatheringState?>.value(),
      ) as _i4.Future<_i2.RTCIceGatheringState?>);

  @override
  _i4.Future<_i2.RTCIceConnectionState?> getIceConnectionState() =>
      (super.noSuchMethod(
        Invocation.method(
          #getIceConnectionState,
          [],
        ),
        returnValue: _i4.Future<_i2.RTCIceConnectionState?>.value(),
        returnValueForMissingStub:
            _i4.Future<_i2.RTCIceConnectionState?>.value(),
      ) as _i4.Future<_i2.RTCIceConnectionState?>);

  @override
  _i4.Future<_i2.RTCPeerConnectionState?> getConnectionState() =>
      (super.noSuchMethod(
        Invocation.method(
          #getConnectionState,
          [],
        ),
        returnValue: _i4.Future<_i2.RTCPeerConnectionState?>.value(),
        returnValueForMissingStub:
            _i4.Future<_i2.RTCPeerConnectionState?>.value(),
      ) as _i4.Future<_i2.RTCPeerConnectionState?>);

  @override
  _i4.Future<void> dispose() => (super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<void> setConfiguration(Map<String, dynamic>? configuration) =>
      (super.noSuchMethod(
        Invocation.method(
          #setConfiguration,
          [configuration],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<_i2.RTCSessionDescription> createOffer(
          [Map<String, dynamic>? constraints]) =>
      (super.noSuchMethod(
        Invocation.method(
          #createOffer,
          [constraints],
        ),
        returnValue: _i4.Future<_i2.RTCSessionDescription>.value(
            _FakeRTCSessionDescription_0(
          this,
          Invocation.method(
            #createOffer,
            [constraints],
          ),
        )),
        returnValueForMissingStub: _i4.Future<_i2.RTCSessionDescription>.value(
            _FakeRTCSessionDescription_0(
          this,
          Invocation.method(
            #createOffer,
            [constraints],
          ),
        )),
      ) as _i4.Future<_i2.RTCSessionDescription>);

  @override
  _i4.Future<_i2.RTCSessionDescription> createAnswer(
          [Map<String, dynamic>? constraints]) =>
      (super.noSuchMethod(
        Invocation.method(
          #createAnswer,
          [constraints],
        ),
        returnValue: _i4.Future<_i2.RTCSessionDescription>.value(
            _FakeRTCSessionDescription_0(
          this,
          Invocation.method(
            #createAnswer,
            [constraints],
          ),
        )),
        returnValueForMissingStub: _i4.Future<_i2.RTCSessionDescription>.value(
            _FakeRTCSessionDescription_0(
          this,
          Invocation.method(
            #createAnswer,
            [constraints],
          ),
        )),
      ) as _i4.Future<_i2.RTCSessionDescription>);

  @override
  _i4.Future<void> addStream(_i2.MediaStream? stream) => (super.noSuchMethod(
        Invocation.method(
          #addStream,
          [stream],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<void> removeStream(_i2.MediaStream? stream) => (super.noSuchMethod(
        Invocation.method(
          #removeStream,
          [stream],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<_i2.RTCSessionDescription?> getLocalDescription() =>
      (super.noSuchMethod(
        Invocation.method(
          #getLocalDescription,
          [],
        ),
        returnValue: _i4.Future<_i2.RTCSessionDescription?>.value(),
        returnValueForMissingStub:
            _i4.Future<_i2.RTCSessionDescription?>.value(),
      ) as _i4.Future<_i2.RTCSessionDescription?>);

  @override
  _i4.Future<void> setLocalDescription(
          _i2.RTCSessionDescription? description) =>
      (super.noSuchMethod(
        Invocation.method(
          #setLocalDescription,
          [description],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<_i2.RTCSessionDescription?> getRemoteDescription() =>
      (super.noSuchMethod(
        Invocation.method(
          #getRemoteDescription,
          [],
        ),
        returnValue: _i4.Future<_i2.RTCSessionDescription?>.value(),
        returnValueForMissingStub:
            _i4.Future<_i2.RTCSessionDescription?>.value(),
      ) as _i4.Future<_i2.RTCSessionDescription?>);

  @override
  _i4.Future<void> setRemoteDescription(
          _i2.RTCSessionDescription? description) =>
      (super.noSuchMethod(
        Invocation.method(
          #setRemoteDescription,
          [description],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<void> addCandidate(_i2.RTCIceCandidate? candidate) =>
      (super.noSuchMethod(
        Invocation.method(
          #addCandidate,
          [candidate],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<List<_i2.StatsReport>> getStats([_i2.MediaStreamTrack? track]) =>
      (super.noSuchMethod(
        Invocation.method(
          #getStats,
          [track],
        ),
        returnValue:
            _i4.Future<List<_i2.StatsReport>>.value(<_i2.StatsReport>[]),
        returnValueForMissingStub:
            _i4.Future<List<_i2.StatsReport>>.value(<_i2.StatsReport>[]),
      ) as _i4.Future<List<_i2.StatsReport>>);

  @override
  List<_i2.MediaStream?> getLocalStreams() => (super.noSuchMethod(
        Invocation.method(
          #getLocalStreams,
          [],
        ),
        returnValue: <_i2.MediaStream?>[],
        returnValueForMissingStub: <_i2.MediaStream?>[],
      ) as List<_i2.MediaStream?>);

  @override
  List<_i2.MediaStream?> getRemoteStreams() => (super.noSuchMethod(
        Invocation.method(
          #getRemoteStreams,
          [],
        ),
        returnValue: <_i2.MediaStream?>[],
        returnValueForMissingStub: <_i2.MediaStream?>[],
      ) as List<_i2.MediaStream?>);

  @override
  _i4.Future<_i2.RTCDataChannel> createDataChannel(
    String? label,
    _i2.RTCDataChannelInit? dataChannelDict,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #createDataChannel,
          [
            label,
            dataChannelDict,
          ],
        ),
        returnValue: _i4.Future<_i2.RTCDataChannel>.value(_FakeRTCDataChannel_1(
          this,
          Invocation.method(
            #createDataChannel,
            [
              label,
              dataChannelDict,
            ],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.RTCDataChannel>.value(_FakeRTCDataChannel_1(
          this,
          Invocation.method(
            #createDataChannel,
            [
              label,
              dataChannelDict,
            ],
          ),
        )),
      ) as _i4.Future<_i2.RTCDataChannel>);

  @override
  _i4.Future<void> restartIce() => (super.noSuchMethod(
        Invocation.method(
          #restartIce,
          [],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<void> close() => (super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i2.RTCDTMFSender createDtmfSender(_i2.MediaStreamTrack? track) =>
      (super.noSuchMethod(
        Invocation.method(
          #createDtmfSender,
          [track],
        ),
        returnValue: _FakeRTCDTMFSender_2(
          this,
          Invocation.method(
            #createDtmfSender,
            [track],
          ),
        ),
        returnValueForMissingStub: _FakeRTCDTMFSender_2(
          this,
          Invocation.method(
            #createDtmfSender,
            [track],
          ),
        ),
      ) as _i2.RTCDTMFSender);

  @override
  _i4.Future<List<_i2.RTCRtpSender>> getSenders() => (super.noSuchMethod(
        Invocation.method(
          #getSenders,
          [],
        ),
        returnValue:
            _i4.Future<List<_i2.RTCRtpSender>>.value(<_i2.RTCRtpSender>[]),
        returnValueForMissingStub:
            _i4.Future<List<_i2.RTCRtpSender>>.value(<_i2.RTCRtpSender>[]),
      ) as _i4.Future<List<_i2.RTCRtpSender>>);

  @override
  _i4.Future<List<_i2.RTCRtpReceiver>> getReceivers() => (super.noSuchMethod(
        Invocation.method(
          #getReceivers,
          [],
        ),
        returnValue:
            _i4.Future<List<_i2.RTCRtpReceiver>>.value(<_i2.RTCRtpReceiver>[]),
        returnValueForMissingStub:
            _i4.Future<List<_i2.RTCRtpReceiver>>.value(<_i2.RTCRtpReceiver>[]),
      ) as _i4.Future<List<_i2.RTCRtpReceiver>>);

  @override
  _i4.Future<List<_i2.RTCRtpTransceiver>> getTransceivers() =>
      (super.noSuchMethod(
        Invocation.method(
          #getTransceivers,
          [],
        ),
        returnValue: _i4.Future<List<_i2.RTCRtpTransceiver>>.value(
            <_i2.RTCRtpTransceiver>[]),
        returnValueForMissingStub:
            _i4.Future<List<_i2.RTCRtpTransceiver>>.value(
                <_i2.RTCRtpTransceiver>[]),
      ) as _i4.Future<List<_i2.RTCRtpTransceiver>>);

  @override
  _i4.Future<_i2.RTCRtpSender> addTrack(
    _i2.MediaStreamTrack? track, [
    _i2.MediaStream? stream,
  ]) =>
      (super.noSuchMethod(
        Invocation.method(
          #addTrack,
          [
            track,
            stream,
          ],
        ),
        returnValue: _i4.Future<_i2.RTCRtpSender>.value(_FakeRTCRtpSender_3(
          this,
          Invocation.method(
            #addTrack,
            [
              track,
              stream,
            ],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.RTCRtpSender>.value(_FakeRTCRtpSender_3(
          this,
          Invocation.method(
            #addTrack,
            [
              track,
              stream,
            ],
          ),
        )),
      ) as _i4.Future<_i2.RTCRtpSender>);

  @override
  _i4.Future<bool> removeTrack(_i2.RTCRtpSender? sender) => (super.noSuchMethod(
        Invocation.method(
          #removeTrack,
          [sender],
        ),
        returnValue: _i4.Future<bool>.value(false),
        returnValueForMissingStub: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);

  @override
  _i4.Future<_i2.RTCRtpTransceiver> addTransceiver({
    _i2.MediaStreamTrack? track,
    _i2.RTCRtpMediaType? kind,
    _i2.RTCRtpTransceiverInit? init,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #addTransceiver,
          [],
          {
            #track: track,
            #kind: kind,
            #init: init,
          },
        ),
        returnValue:
            _i4.Future<_i2.RTCRtpTransceiver>.value(_FakeRTCRtpTransceiver_4(
          this,
          Invocation.method(
            #addTransceiver,
            [],
            {
              #track: track,
              #kind: kind,
              #init: init,
            },
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.RTCRtpTransceiver>.value(_FakeRTCRtpTransceiver_4(
          this,
          Invocation.method(
            #addTransceiver,
            [],
            {
              #track: track,
              #kind: kind,
              #init: init,
            },
          ),
        )),
      ) as _i4.Future<_i2.RTCRtpTransceiver>);
}
