// Mocks generated by Mockito 5.4.4 from annotations
// in dream_catcher/test/core/webrtc/openai_webrtc_client_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i14;

import 'package:dream_catcher/core/webrtc/openai_realtime_api_service.dart'
    as _i18;
import 'package:flutter_webrtc/flutter_webrtc.dart' as _i8;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i17;
import 'package:webrtc_interface/src/enums.dart' as _i10;
import 'package:webrtc_interface/src/media_stream.dart' as _i7;
import 'package:webrtc_interface/src/media_stream_track.dart' as _i12;
import 'package:webrtc_interface/src/mediadevices.dart' as _i9;
import 'package:webrtc_interface/src/navigator.dart' as _i19;
import 'package:webrtc_interface/src/rtc_data_channel.dart' as _i3;
import 'package:webrtc_interface/src/rtc_dtmf_sender.dart' as _i4;
import 'package:webrtc_interface/src/rtc_ice_candidate.dart' as _i11;
import 'package:webrtc_interface/src/rtc_rtp_receiver.dart' as _i15;
import 'package:webrtc_interface/src/rtc_rtp_sender.dart' as _i5;
import 'package:webrtc_interface/src/rtc_rtp_transceiver.dart' as _i6;
import 'package:webrtc_interface/src/rtc_session_description.dart' as _i2;
import 'package:webrtc_interface/src/rtc_stats_report.dart' as _i16;
import 'package:webrtc_interface/src/rtc_track_event.dart' as _i13;

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
    implements _i3.RTCDataChannel {
  _FakeRTCDataChannel_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeRTCDTMFSender_2 extends _i1.SmartFake implements _i4.RTCDTMFSender {
  _FakeRTCDTMFSender_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeRTCRtpSender_3 extends _i1.SmartFake implements _i5.RTCRtpSender {
  _FakeRTCRtpSender_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeRTCRtpTransceiver_4 extends _i1.SmartFake
    implements _i6.RTCRtpTransceiver {
  _FakeRTCRtpTransceiver_4(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeMediaStream_5 extends _i1.SmartFake implements _i7.MediaStream {
  _FakeMediaStream_5(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeMediaTrackSupportedConstraints_6 extends _i1.SmartFake
    implements _i8.MediaTrackSupportedConstraints {
  _FakeMediaTrackSupportedConstraints_6(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeMediaDeviceInfo_7 extends _i1.SmartFake
    implements _i8.MediaDeviceInfo {
  _FakeMediaDeviceInfo_7(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeMediaDevices_8 extends _i1.SmartFake implements _i9.MediaDevices {
  _FakeMediaDevices_8(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [RTCPeerConnection].
///
/// See the documentation for Mockito's code generation for more information.
class MockRTCPeerConnection extends _i1.Mock implements _i8.RTCPeerConnection {
  @override
  set onSignalingState(
          dynamic Function(_i10.RTCSignalingState)? _onSignalingState) =>
      super.noSuchMethod(
        Invocation.setter(
          #onSignalingState,
          _onSignalingState,
        ),
        returnValueForMissingStub: null,
      );

  @override
  set onConnectionState(
          dynamic Function(_i10.RTCPeerConnectionState)? _onConnectionState) =>
      super.noSuchMethod(
        Invocation.setter(
          #onConnectionState,
          _onConnectionState,
        ),
        returnValueForMissingStub: null,
      );

  @override
  set onIceGatheringState(
          dynamic Function(_i10.RTCIceGatheringState)? _onIceGatheringState) =>
      super.noSuchMethod(
        Invocation.setter(
          #onIceGatheringState,
          _onIceGatheringState,
        ),
        returnValueForMissingStub: null,
      );

  @override
  set onIceConnectionState(
          dynamic Function(_i10.RTCIceConnectionState)?
              _onIceConnectionState) =>
      super.noSuchMethod(
        Invocation.setter(
          #onIceConnectionState,
          _onIceConnectionState,
        ),
        returnValueForMissingStub: null,
      );

  @override
  set onIceCandidate(dynamic Function(_i11.RTCIceCandidate)? _onIceCandidate) =>
      super.noSuchMethod(
        Invocation.setter(
          #onIceCandidate,
          _onIceCandidate,
        ),
        returnValueForMissingStub: null,
      );

  @override
  set onAddStream(dynamic Function(_i7.MediaStream)? _onAddStream) =>
      super.noSuchMethod(
        Invocation.setter(
          #onAddStream,
          _onAddStream,
        ),
        returnValueForMissingStub: null,
      );

  @override
  set onRemoveStream(dynamic Function(_i7.MediaStream)? _onRemoveStream) =>
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
            _i7.MediaStream,
            _i12.MediaStreamTrack,
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
            _i7.MediaStream,
            _i12.MediaStreamTrack,
          )? _onRemoveTrack) =>
      super.noSuchMethod(
        Invocation.setter(
          #onRemoveTrack,
          _onRemoveTrack,
        ),
        returnValueForMissingStub: null,
      );

  @override
  set onDataChannel(dynamic Function(_i3.RTCDataChannel)? _onDataChannel) =>
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
  set onTrack(dynamic Function(_i13.RTCTrackEvent)? _onTrack) =>
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
  _i14.Future<List<_i5.RTCRtpSender>> get senders => (super.noSuchMethod(
        Invocation.getter(#senders),
        returnValue:
            _i14.Future<List<_i5.RTCRtpSender>>.value(<_i5.RTCRtpSender>[]),
        returnValueForMissingStub:
            _i14.Future<List<_i5.RTCRtpSender>>.value(<_i5.RTCRtpSender>[]),
      ) as _i14.Future<List<_i5.RTCRtpSender>>);

  @override
  _i14.Future<List<_i15.RTCRtpReceiver>> get receivers => (super.noSuchMethod(
        Invocation.getter(#receivers),
        returnValue: _i14.Future<List<_i15.RTCRtpReceiver>>.value(
            <_i15.RTCRtpReceiver>[]),
        returnValueForMissingStub: _i14.Future<List<_i15.RTCRtpReceiver>>.value(
            <_i15.RTCRtpReceiver>[]),
      ) as _i14.Future<List<_i15.RTCRtpReceiver>>);

  @override
  _i14.Future<List<_i6.RTCRtpTransceiver>> get transceivers =>
      (super.noSuchMethod(
        Invocation.getter(#transceivers),
        returnValue: _i14.Future<List<_i6.RTCRtpTransceiver>>.value(
            <_i6.RTCRtpTransceiver>[]),
        returnValueForMissingStub:
            _i14.Future<List<_i6.RTCRtpTransceiver>>.value(
                <_i6.RTCRtpTransceiver>[]),
      ) as _i14.Future<List<_i6.RTCRtpTransceiver>>);

  @override
  _i14.Future<_i10.RTCSignalingState?> getSignalingState() =>
      (super.noSuchMethod(
        Invocation.method(
          #getSignalingState,
          [],
        ),
        returnValue: _i14.Future<_i10.RTCSignalingState?>.value(),
        returnValueForMissingStub: _i14.Future<_i10.RTCSignalingState?>.value(),
      ) as _i14.Future<_i10.RTCSignalingState?>);

  @override
  _i14.Future<_i10.RTCIceGatheringState?> getIceGatheringState() =>
      (super.noSuchMethod(
        Invocation.method(
          #getIceGatheringState,
          [],
        ),
        returnValue: _i14.Future<_i10.RTCIceGatheringState?>.value(),
        returnValueForMissingStub:
            _i14.Future<_i10.RTCIceGatheringState?>.value(),
      ) as _i14.Future<_i10.RTCIceGatheringState?>);

  @override
  _i14.Future<_i10.RTCIceConnectionState?> getIceConnectionState() =>
      (super.noSuchMethod(
        Invocation.method(
          #getIceConnectionState,
          [],
        ),
        returnValue: _i14.Future<_i10.RTCIceConnectionState?>.value(),
        returnValueForMissingStub:
            _i14.Future<_i10.RTCIceConnectionState?>.value(),
      ) as _i14.Future<_i10.RTCIceConnectionState?>);

  @override
  _i14.Future<_i10.RTCPeerConnectionState?> getConnectionState() =>
      (super.noSuchMethod(
        Invocation.method(
          #getConnectionState,
          [],
        ),
        returnValue: _i14.Future<_i10.RTCPeerConnectionState?>.value(),
        returnValueForMissingStub:
            _i14.Future<_i10.RTCPeerConnectionState?>.value(),
      ) as _i14.Future<_i10.RTCPeerConnectionState?>);

  @override
  _i14.Future<void> dispose() => (super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValue: _i14.Future<void>.value(),
        returnValueForMissingStub: _i14.Future<void>.value(),
      ) as _i14.Future<void>);

  @override
  _i14.Future<void> setConfiguration(Map<String, dynamic>? configuration) =>
      (super.noSuchMethod(
        Invocation.method(
          #setConfiguration,
          [configuration],
        ),
        returnValue: _i14.Future<void>.value(),
        returnValueForMissingStub: _i14.Future<void>.value(),
      ) as _i14.Future<void>);

  @override
  _i14.Future<_i2.RTCSessionDescription> createOffer(
          [Map<String, dynamic>? constraints]) =>
      (super.noSuchMethod(
        Invocation.method(
          #createOffer,
          [constraints],
        ),
        returnValue: _i14.Future<_i2.RTCSessionDescription>.value(
            _FakeRTCSessionDescription_0(
          this,
          Invocation.method(
            #createOffer,
            [constraints],
          ),
        )),
        returnValueForMissingStub: _i14.Future<_i2.RTCSessionDescription>.value(
            _FakeRTCSessionDescription_0(
          this,
          Invocation.method(
            #createOffer,
            [constraints],
          ),
        )),
      ) as _i14.Future<_i2.RTCSessionDescription>);

  @override
  _i14.Future<_i2.RTCSessionDescription> createAnswer(
          [Map<String, dynamic>? constraints]) =>
      (super.noSuchMethod(
        Invocation.method(
          #createAnswer,
          [constraints],
        ),
        returnValue: _i14.Future<_i2.RTCSessionDescription>.value(
            _FakeRTCSessionDescription_0(
          this,
          Invocation.method(
            #createAnswer,
            [constraints],
          ),
        )),
        returnValueForMissingStub: _i14.Future<_i2.RTCSessionDescription>.value(
            _FakeRTCSessionDescription_0(
          this,
          Invocation.method(
            #createAnswer,
            [constraints],
          ),
        )),
      ) as _i14.Future<_i2.RTCSessionDescription>);

  @override
  _i14.Future<void> addStream(_i7.MediaStream? stream) => (super.noSuchMethod(
        Invocation.method(
          #addStream,
          [stream],
        ),
        returnValue: _i14.Future<void>.value(),
        returnValueForMissingStub: _i14.Future<void>.value(),
      ) as _i14.Future<void>);

  @override
  _i14.Future<void> removeStream(_i7.MediaStream? stream) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeStream,
          [stream],
        ),
        returnValue: _i14.Future<void>.value(),
        returnValueForMissingStub: _i14.Future<void>.value(),
      ) as _i14.Future<void>);

  @override
  _i14.Future<_i2.RTCSessionDescription?> getLocalDescription() =>
      (super.noSuchMethod(
        Invocation.method(
          #getLocalDescription,
          [],
        ),
        returnValue: _i14.Future<_i2.RTCSessionDescription?>.value(),
        returnValueForMissingStub:
            _i14.Future<_i2.RTCSessionDescription?>.value(),
      ) as _i14.Future<_i2.RTCSessionDescription?>);

  @override
  _i14.Future<void> setLocalDescription(
          _i2.RTCSessionDescription? description) =>
      (super.noSuchMethod(
        Invocation.method(
          #setLocalDescription,
          [description],
        ),
        returnValue: _i14.Future<void>.value(),
        returnValueForMissingStub: _i14.Future<void>.value(),
      ) as _i14.Future<void>);

  @override
  _i14.Future<_i2.RTCSessionDescription?> getRemoteDescription() =>
      (super.noSuchMethod(
        Invocation.method(
          #getRemoteDescription,
          [],
        ),
        returnValue: _i14.Future<_i2.RTCSessionDescription?>.value(),
        returnValueForMissingStub:
            _i14.Future<_i2.RTCSessionDescription?>.value(),
      ) as _i14.Future<_i2.RTCSessionDescription?>);

  @override
  _i14.Future<void> setRemoteDescription(
          _i2.RTCSessionDescription? description) =>
      (super.noSuchMethod(
        Invocation.method(
          #setRemoteDescription,
          [description],
        ),
        returnValue: _i14.Future<void>.value(),
        returnValueForMissingStub: _i14.Future<void>.value(),
      ) as _i14.Future<void>);

  @override
  _i14.Future<void> addCandidate(_i11.RTCIceCandidate? candidate) =>
      (super.noSuchMethod(
        Invocation.method(
          #addCandidate,
          [candidate],
        ),
        returnValue: _i14.Future<void>.value(),
        returnValueForMissingStub: _i14.Future<void>.value(),
      ) as _i14.Future<void>);

  @override
  _i14.Future<List<_i16.StatsReport>> getStats(
          [_i12.MediaStreamTrack? track]) =>
      (super.noSuchMethod(
        Invocation.method(
          #getStats,
          [track],
        ),
        returnValue:
            _i14.Future<List<_i16.StatsReport>>.value(<_i16.StatsReport>[]),
        returnValueForMissingStub:
            _i14.Future<List<_i16.StatsReport>>.value(<_i16.StatsReport>[]),
      ) as _i14.Future<List<_i16.StatsReport>>);

  @override
  List<_i7.MediaStream?> getLocalStreams() => (super.noSuchMethod(
        Invocation.method(
          #getLocalStreams,
          [],
        ),
        returnValue: <_i7.MediaStream?>[],
        returnValueForMissingStub: <_i7.MediaStream?>[],
      ) as List<_i7.MediaStream?>);

  @override
  List<_i7.MediaStream?> getRemoteStreams() => (super.noSuchMethod(
        Invocation.method(
          #getRemoteStreams,
          [],
        ),
        returnValue: <_i7.MediaStream?>[],
        returnValueForMissingStub: <_i7.MediaStream?>[],
      ) as List<_i7.MediaStream?>);

  @override
  _i14.Future<_i3.RTCDataChannel> createDataChannel(
    String? label,
    _i3.RTCDataChannelInit? dataChannelDict,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #createDataChannel,
          [
            label,
            dataChannelDict,
          ],
        ),
        returnValue:
            _i14.Future<_i3.RTCDataChannel>.value(_FakeRTCDataChannel_1(
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
            _i14.Future<_i3.RTCDataChannel>.value(_FakeRTCDataChannel_1(
          this,
          Invocation.method(
            #createDataChannel,
            [
              label,
              dataChannelDict,
            ],
          ),
        )),
      ) as _i14.Future<_i3.RTCDataChannel>);

  @override
  _i14.Future<void> restartIce() => (super.noSuchMethod(
        Invocation.method(
          #restartIce,
          [],
        ),
        returnValue: _i14.Future<void>.value(),
        returnValueForMissingStub: _i14.Future<void>.value(),
      ) as _i14.Future<void>);

  @override
  _i14.Future<void> close() => (super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValue: _i14.Future<void>.value(),
        returnValueForMissingStub: _i14.Future<void>.value(),
      ) as _i14.Future<void>);

  @override
  _i4.RTCDTMFSender createDtmfSender(_i12.MediaStreamTrack? track) =>
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
      ) as _i4.RTCDTMFSender);

  @override
  _i14.Future<List<_i5.RTCRtpSender>> getSenders() => (super.noSuchMethod(
        Invocation.method(
          #getSenders,
          [],
        ),
        returnValue:
            _i14.Future<List<_i5.RTCRtpSender>>.value(<_i5.RTCRtpSender>[]),
        returnValueForMissingStub:
            _i14.Future<List<_i5.RTCRtpSender>>.value(<_i5.RTCRtpSender>[]),
      ) as _i14.Future<List<_i5.RTCRtpSender>>);

  @override
  _i14.Future<List<_i15.RTCRtpReceiver>> getReceivers() => (super.noSuchMethod(
        Invocation.method(
          #getReceivers,
          [],
        ),
        returnValue: _i14.Future<List<_i15.RTCRtpReceiver>>.value(
            <_i15.RTCRtpReceiver>[]),
        returnValueForMissingStub: _i14.Future<List<_i15.RTCRtpReceiver>>.value(
            <_i15.RTCRtpReceiver>[]),
      ) as _i14.Future<List<_i15.RTCRtpReceiver>>);

  @override
  _i14.Future<List<_i6.RTCRtpTransceiver>> getTransceivers() =>
      (super.noSuchMethod(
        Invocation.method(
          #getTransceivers,
          [],
        ),
        returnValue: _i14.Future<List<_i6.RTCRtpTransceiver>>.value(
            <_i6.RTCRtpTransceiver>[]),
        returnValueForMissingStub:
            _i14.Future<List<_i6.RTCRtpTransceiver>>.value(
                <_i6.RTCRtpTransceiver>[]),
      ) as _i14.Future<List<_i6.RTCRtpTransceiver>>);

  @override
  _i14.Future<_i5.RTCRtpSender> addTrack(
    _i12.MediaStreamTrack? track, [
    _i7.MediaStream? stream,
  ]) =>
      (super.noSuchMethod(
        Invocation.method(
          #addTrack,
          [
            track,
            stream,
          ],
        ),
        returnValue: _i14.Future<_i5.RTCRtpSender>.value(_FakeRTCRtpSender_3(
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
            _i14.Future<_i5.RTCRtpSender>.value(_FakeRTCRtpSender_3(
          this,
          Invocation.method(
            #addTrack,
            [
              track,
              stream,
            ],
          ),
        )),
      ) as _i14.Future<_i5.RTCRtpSender>);

  @override
  _i14.Future<bool> removeTrack(_i5.RTCRtpSender? sender) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeTrack,
          [sender],
        ),
        returnValue: _i14.Future<bool>.value(false),
        returnValueForMissingStub: _i14.Future<bool>.value(false),
      ) as _i14.Future<bool>);

  @override
  _i14.Future<_i6.RTCRtpTransceiver> addTransceiver({
    _i12.MediaStreamTrack? track,
    _i10.RTCRtpMediaType? kind,
    _i6.RTCRtpTransceiverInit? init,
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
            _i14.Future<_i6.RTCRtpTransceiver>.value(_FakeRTCRtpTransceiver_4(
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
            _i14.Future<_i6.RTCRtpTransceiver>.value(_FakeRTCRtpTransceiver_4(
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
      ) as _i14.Future<_i6.RTCRtpTransceiver>);
}

/// A class which mocks [MediaStream].
///
/// See the documentation for Mockito's code generation for more information.
class MockMediaStream extends _i1.Mock implements _i7.MediaStream {
  @override
  set onAddTrack(dynamic Function(_i12.MediaStreamTrack)? _onAddTrack) =>
      super.noSuchMethod(
        Invocation.setter(
          #onAddTrack,
          _onAddTrack,
        ),
        returnValueForMissingStub: null,
      );

  @override
  set onRemoveTrack(dynamic Function(_i12.MediaStreamTrack)? _onRemoveTrack) =>
      super.noSuchMethod(
        Invocation.setter(
          #onRemoveTrack,
          _onRemoveTrack,
        ),
        returnValueForMissingStub: null,
      );

  @override
  String get id => (super.noSuchMethod(
        Invocation.getter(#id),
        returnValue: _i17.dummyValue<String>(
          this,
          Invocation.getter(#id),
        ),
        returnValueForMissingStub: _i17.dummyValue<String>(
          this,
          Invocation.getter(#id),
        ),
      ) as String);

  @override
  String get ownerTag => (super.noSuchMethod(
        Invocation.getter(#ownerTag),
        returnValue: _i17.dummyValue<String>(
          this,
          Invocation.getter(#ownerTag),
        ),
        returnValueForMissingStub: _i17.dummyValue<String>(
          this,
          Invocation.getter(#ownerTag),
        ),
      ) as String);

  @override
  _i14.Future<void> getMediaTracks() => (super.noSuchMethod(
        Invocation.method(
          #getMediaTracks,
          [],
        ),
        returnValue: _i14.Future<void>.value(),
        returnValueForMissingStub: _i14.Future<void>.value(),
      ) as _i14.Future<void>);

  @override
  _i14.Future<void> addTrack(
    _i12.MediaStreamTrack? track, {
    bool? addToNative = true,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #addTrack,
          [track],
          {#addToNative: addToNative},
        ),
        returnValue: _i14.Future<void>.value(),
        returnValueForMissingStub: _i14.Future<void>.value(),
      ) as _i14.Future<void>);

  @override
  _i14.Future<void> removeTrack(
    _i12.MediaStreamTrack? track, {
    bool? removeFromNative = true,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeTrack,
          [track],
          {#removeFromNative: removeFromNative},
        ),
        returnValue: _i14.Future<void>.value(),
        returnValueForMissingStub: _i14.Future<void>.value(),
      ) as _i14.Future<void>);

  @override
  List<_i12.MediaStreamTrack> getTracks() => (super.noSuchMethod(
        Invocation.method(
          #getTracks,
          [],
        ),
        returnValue: <_i12.MediaStreamTrack>[],
        returnValueForMissingStub: <_i12.MediaStreamTrack>[],
      ) as List<_i12.MediaStreamTrack>);

  @override
  List<_i12.MediaStreamTrack> getAudioTracks() => (super.noSuchMethod(
        Invocation.method(
          #getAudioTracks,
          [],
        ),
        returnValue: <_i12.MediaStreamTrack>[],
        returnValueForMissingStub: <_i12.MediaStreamTrack>[],
      ) as List<_i12.MediaStreamTrack>);

  @override
  List<_i12.MediaStreamTrack> getVideoTracks() => (super.noSuchMethod(
        Invocation.method(
          #getVideoTracks,
          [],
        ),
        returnValue: <_i12.MediaStreamTrack>[],
        returnValueForMissingStub: <_i12.MediaStreamTrack>[],
      ) as List<_i12.MediaStreamTrack>);

  @override
  _i12.MediaStreamTrack? getTrackById(String? trackId) => (super.noSuchMethod(
        Invocation.method(
          #getTrackById,
          [trackId],
        ),
        returnValueForMissingStub: null,
      ) as _i12.MediaStreamTrack?);

  @override
  _i14.Future<_i7.MediaStream> clone() => (super.noSuchMethod(
        Invocation.method(
          #clone,
          [],
        ),
        returnValue: _i14.Future<_i7.MediaStream>.value(_FakeMediaStream_5(
          this,
          Invocation.method(
            #clone,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i14.Future<_i7.MediaStream>.value(_FakeMediaStream_5(
          this,
          Invocation.method(
            #clone,
            [],
          ),
        )),
      ) as _i14.Future<_i7.MediaStream>);

  @override
  _i14.Future<void> dispose() => (super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValue: _i14.Future<void>.value(),
        returnValueForMissingStub: _i14.Future<void>.value(),
      ) as _i14.Future<void>);
}

/// A class which mocks [RTCDataChannel].
///
/// See the documentation for Mockito's code generation for more information.
class MockRTCDataChannel extends _i1.Mock implements _i3.RTCDataChannel {
  @override
  set onDataChannelState(
          dynamic Function(_i10.RTCDataChannelState)? _onDataChannelState) =>
      super.noSuchMethod(
        Invocation.setter(
          #onDataChannelState,
          _onDataChannelState,
        ),
        returnValueForMissingStub: null,
      );

  @override
  set onMessage(dynamic Function(_i3.RTCDataChannelMessage)? _onMessage) =>
      super.noSuchMethod(
        Invocation.setter(
          #onMessage,
          _onMessage,
        ),
        returnValueForMissingStub: null,
      );

  @override
  set onBufferedAmountChange(
          dynamic Function(
            int,
            int,
          )? _onBufferedAmountChange) =>
      super.noSuchMethod(
        Invocation.setter(
          #onBufferedAmountChange,
          _onBufferedAmountChange,
        ),
        returnValueForMissingStub: null,
      );

  @override
  set onBufferedAmountLow(dynamic Function(int)? _onBufferedAmountLow) =>
      super.noSuchMethod(
        Invocation.setter(
          #onBufferedAmountLow,
          _onBufferedAmountLow,
        ),
        returnValueForMissingStub: null,
      );

  @override
  set bufferedAmountLowThreshold(int? _bufferedAmountLowThreshold) =>
      super.noSuchMethod(
        Invocation.setter(
          #bufferedAmountLowThreshold,
          _bufferedAmountLowThreshold,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i14.Stream<_i10.RTCDataChannelState> get stateChangeStream =>
      (super.noSuchMethod(
        Invocation.getter(#stateChangeStream),
        returnValue: _i14.Stream<_i10.RTCDataChannelState>.empty(),
        returnValueForMissingStub:
            _i14.Stream<_i10.RTCDataChannelState>.empty(),
      ) as _i14.Stream<_i10.RTCDataChannelState>);

  @override
  set stateChangeStream(
          _i14.Stream<_i10.RTCDataChannelState>? _stateChangeStream) =>
      super.noSuchMethod(
        Invocation.setter(
          #stateChangeStream,
          _stateChangeStream,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i14.Stream<_i3.RTCDataChannelMessage> get messageStream =>
      (super.noSuchMethod(
        Invocation.getter(#messageStream),
        returnValue: _i14.Stream<_i3.RTCDataChannelMessage>.empty(),
        returnValueForMissingStub:
            _i14.Stream<_i3.RTCDataChannelMessage>.empty(),
      ) as _i14.Stream<_i3.RTCDataChannelMessage>);

  @override
  set messageStream(_i14.Stream<_i3.RTCDataChannelMessage>? _messageStream) =>
      super.noSuchMethod(
        Invocation.setter(
          #messageStream,
          _messageStream,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i14.Future<int> getBufferedAmount() => (super.noSuchMethod(
        Invocation.method(
          #getBufferedAmount,
          [],
        ),
        returnValue: _i14.Future<int>.value(0),
        returnValueForMissingStub: _i14.Future<int>.value(0),
      ) as _i14.Future<int>);

  @override
  _i14.Future<void> send(_i3.RTCDataChannelMessage? message) =>
      (super.noSuchMethod(
        Invocation.method(
          #send,
          [message],
        ),
        returnValue: _i14.Future<void>.value(),
        returnValueForMissingStub: _i14.Future<void>.value(),
      ) as _i14.Future<void>);

  @override
  _i14.Future<void> close() => (super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValue: _i14.Future<void>.value(),
        returnValueForMissingStub: _i14.Future<void>.value(),
      ) as _i14.Future<void>);
}

/// A class which mocks [OpenAIRealtimeApiService].
///
/// See the documentation for Mockito's code generation for more information.
class MockOpenAIRealtimeApiService extends _i1.Mock
    implements _i18.OpenAIRealtimeApiService {
  @override
  _i14.Future<_i2.RTCSessionDescription> initiateWebRtcConnection(
          {required String? sdp}) =>
      (super.noSuchMethod(
        Invocation.method(
          #initiateWebRtcConnection,
          [],
          {#sdp: sdp},
        ),
        returnValue: _i14.Future<_i2.RTCSessionDescription>.value(
            _FakeRTCSessionDescription_0(
          this,
          Invocation.method(
            #initiateWebRtcConnection,
            [],
            {#sdp: sdp},
          ),
        )),
        returnValueForMissingStub: _i14.Future<_i2.RTCSessionDescription>.value(
            _FakeRTCSessionDescription_0(
          this,
          Invocation.method(
            #initiateWebRtcConnection,
            [],
            {#sdp: sdp},
          ),
        )),
      ) as _i14.Future<_i2.RTCSessionDescription>);

  @override
  void dispose() => super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [MediaDevices].
///
/// See the documentation for Mockito's code generation for more information.
class MockMediaDevices extends _i1.Mock implements _i9.MediaDevices {
  @override
  set ondevicechange(dynamic Function(dynamic)? _ondevicechange) =>
      super.noSuchMethod(
        Invocation.setter(
          #ondevicechange,
          _ondevicechange,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i14.Future<_i7.MediaStream> getUserMedia(
          Map<String, dynamic>? mediaConstraints) =>
      (super.noSuchMethod(
        Invocation.method(
          #getUserMedia,
          [mediaConstraints],
        ),
        returnValue: _i14.Future<_i7.MediaStream>.value(_FakeMediaStream_5(
          this,
          Invocation.method(
            #getUserMedia,
            [mediaConstraints],
          ),
        )),
        returnValueForMissingStub:
            _i14.Future<_i7.MediaStream>.value(_FakeMediaStream_5(
          this,
          Invocation.method(
            #getUserMedia,
            [mediaConstraints],
          ),
        )),
      ) as _i14.Future<_i7.MediaStream>);

  @override
  _i14.Future<_i7.MediaStream> getDisplayMedia(
          Map<String, dynamic>? mediaConstraints) =>
      (super.noSuchMethod(
        Invocation.method(
          #getDisplayMedia,
          [mediaConstraints],
        ),
        returnValue: _i14.Future<_i7.MediaStream>.value(_FakeMediaStream_5(
          this,
          Invocation.method(
            #getDisplayMedia,
            [mediaConstraints],
          ),
        )),
        returnValueForMissingStub:
            _i14.Future<_i7.MediaStream>.value(_FakeMediaStream_5(
          this,
          Invocation.method(
            #getDisplayMedia,
            [mediaConstraints],
          ),
        )),
      ) as _i14.Future<_i7.MediaStream>);

  @override
  _i14.Future<List<dynamic>> getSources() => (super.noSuchMethod(
        Invocation.method(
          #getSources,
          [],
        ),
        returnValue: _i14.Future<List<dynamic>>.value(<dynamic>[]),
        returnValueForMissingStub:
            _i14.Future<List<dynamic>>.value(<dynamic>[]),
      ) as _i14.Future<List<dynamic>>);

  @override
  _i14.Future<List<_i8.MediaDeviceInfo>> enumerateDevices() =>
      (super.noSuchMethod(
        Invocation.method(
          #enumerateDevices,
          [],
        ),
        returnValue: _i14.Future<List<_i8.MediaDeviceInfo>>.value(
            <_i8.MediaDeviceInfo>[]),
        returnValueForMissingStub: _i14.Future<List<_i8.MediaDeviceInfo>>.value(
            <_i8.MediaDeviceInfo>[]),
      ) as _i14.Future<List<_i8.MediaDeviceInfo>>);

  @override
  _i8.MediaTrackSupportedConstraints getSupportedConstraints() =>
      (super.noSuchMethod(
        Invocation.method(
          #getSupportedConstraints,
          [],
        ),
        returnValue: _FakeMediaTrackSupportedConstraints_6(
          this,
          Invocation.method(
            #getSupportedConstraints,
            [],
          ),
        ),
        returnValueForMissingStub: _FakeMediaTrackSupportedConstraints_6(
          this,
          Invocation.method(
            #getSupportedConstraints,
            [],
          ),
        ),
      ) as _i8.MediaTrackSupportedConstraints);

  @override
  _i14.Future<_i8.MediaDeviceInfo> selectAudioOutput(
          [_i8.AudioOutputOptions? options]) =>
      (super.noSuchMethod(
        Invocation.method(
          #selectAudioOutput,
          [options],
        ),
        returnValue:
            _i14.Future<_i8.MediaDeviceInfo>.value(_FakeMediaDeviceInfo_7(
          this,
          Invocation.method(
            #selectAudioOutput,
            [options],
          ),
        )),
        returnValueForMissingStub:
            _i14.Future<_i8.MediaDeviceInfo>.value(_FakeMediaDeviceInfo_7(
          this,
          Invocation.method(
            #selectAudioOutput,
            [options],
          ),
        )),
      ) as _i14.Future<_i8.MediaDeviceInfo>);
}

/// A class which mocks [Navigator].
///
/// See the documentation for Mockito's code generation for more information.
class MockNavigator extends _i1.Mock implements _i19.Navigator {
  @override
  _i9.MediaDevices get mediaDevices => (super.noSuchMethod(
        Invocation.getter(#mediaDevices),
        returnValue: _FakeMediaDevices_8(
          this,
          Invocation.getter(#mediaDevices),
        ),
        returnValueForMissingStub: _FakeMediaDevices_8(
          this,
          Invocation.getter(#mediaDevices),
        ),
      ) as _i9.MediaDevices);

  @override
  _i14.Future<_i7.MediaStream> getUserMedia(
          Map<String, dynamic>? mediaConstraints) =>
      (super.noSuchMethod(
        Invocation.method(
          #getUserMedia,
          [mediaConstraints],
        ),
        returnValue: _i14.Future<_i7.MediaStream>.value(_FakeMediaStream_5(
          this,
          Invocation.method(
            #getUserMedia,
            [mediaConstraints],
          ),
        )),
        returnValueForMissingStub:
            _i14.Future<_i7.MediaStream>.value(_FakeMediaStream_5(
          this,
          Invocation.method(
            #getUserMedia,
            [mediaConstraints],
          ),
        )),
      ) as _i14.Future<_i7.MediaStream>);

  @override
  _i14.Future<_i7.MediaStream> getDisplayMedia(
          Map<String, dynamic>? mediaConstraints) =>
      (super.noSuchMethod(
        Invocation.method(
          #getDisplayMedia,
          [mediaConstraints],
        ),
        returnValue: _i14.Future<_i7.MediaStream>.value(_FakeMediaStream_5(
          this,
          Invocation.method(
            #getDisplayMedia,
            [mediaConstraints],
          ),
        )),
        returnValueForMissingStub:
            _i14.Future<_i7.MediaStream>.value(_FakeMediaStream_5(
          this,
          Invocation.method(
            #getDisplayMedia,
            [mediaConstraints],
          ),
        )),
      ) as _i14.Future<_i7.MediaStream>);

  @override
  _i14.Future<List<dynamic>> getSources() => (super.noSuchMethod(
        Invocation.method(
          #getSources,
          [],
        ),
        returnValue: _i14.Future<List<dynamic>>.value(<dynamic>[]),
        returnValueForMissingStub:
            _i14.Future<List<dynamic>>.value(<dynamic>[]),
      ) as _i14.Future<List<dynamic>>);
}
