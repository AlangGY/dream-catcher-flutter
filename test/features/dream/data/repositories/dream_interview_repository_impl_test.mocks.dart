// Mocks generated by Mockito 5.4.4 from annotations
// in dream_catcher/test/features/dream/data/repositories/dream_interview_repository_impl_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:dream_catcher/features/dream/data/data-sources/dream_interview_data_source.dart'
    as _i3;
import 'package:dream_catcher/features/dream/data/models/dream_interview_model.dart'
    as _i2;
import 'package:dream_catcher/features/dream/domain/entities/dream_interview.dart'
    as _i5;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i6;

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

class _FakeDreamInterviewModel_0 extends _i1.SmartFake
    implements _i2.DreamInterviewModel {
  _FakeDreamInterviewModel_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeDreamInterviewMessageModel_1 extends _i1.SmartFake
    implements _i2.DreamInterviewMessageModel {
  _FakeDreamInterviewMessageModel_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [DreamInterviewDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockDreamInterviewDataSource extends _i1.Mock
    implements _i3.DreamInterviewDataSource {
  @override
  _i4.Future<_i2.DreamInterviewModel> startInterview() => (super.noSuchMethod(
        Invocation.method(
          #startInterview,
          [],
        ),
        returnValue: _i4.Future<_i2.DreamInterviewModel>.value(
            _FakeDreamInterviewModel_0(
          this,
          Invocation.method(
            #startInterview,
            [],
          ),
        )),
        returnValueForMissingStub: _i4.Future<_i2.DreamInterviewModel>.value(
            _FakeDreamInterviewModel_0(
          this,
          Invocation.method(
            #startInterview,
            [],
          ),
        )),
      ) as _i4.Future<_i2.DreamInterviewModel>);

  @override
  _i4.Future<_i2.DreamInterviewModel> answerMessage(
    String? interviewId,
    _i5.SpeakerType? speakerType,
    String? content,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #answerMessage,
          [
            interviewId,
            speakerType,
            content,
          ],
        ),
        returnValue: _i4.Future<_i2.DreamInterviewModel>.value(
            _FakeDreamInterviewModel_0(
          this,
          Invocation.method(
            #answerMessage,
            [
              interviewId,
              speakerType,
              content,
            ],
          ),
        )),
        returnValueForMissingStub: _i4.Future<_i2.DreamInterviewModel>.value(
            _FakeDreamInterviewModel_0(
          this,
          Invocation.method(
            #answerMessage,
            [
              interviewId,
              speakerType,
              content,
            ],
          ),
        )),
      ) as _i4.Future<_i2.DreamInterviewModel>);

  @override
  _i4.Future<void> completeInterview(String? interviewId) =>
      (super.noSuchMethod(
        Invocation.method(
          #completeInterview,
          [interviewId],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<String> convertVoiceToText(List<int>? audioData) =>
      (super.noSuchMethod(
        Invocation.method(
          #convertVoiceToText,
          [audioData],
        ),
        returnValue: _i4.Future<String>.value(_i6.dummyValue<String>(
          this,
          Invocation.method(
            #convertVoiceToText,
            [audioData],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<String>.value(_i6.dummyValue<String>(
          this,
          Invocation.method(
            #convertVoiceToText,
            [audioData],
          ),
        )),
      ) as _i4.Future<String>);

  @override
  _i4.Future<_i2.DreamInterviewModel> getCurrentInterview(
          String? interviewId) =>
      (super.noSuchMethod(
        Invocation.method(
          #getCurrentInterview,
          [interviewId],
        ),
        returnValue: _i4.Future<_i2.DreamInterviewModel>.value(
            _FakeDreamInterviewModel_0(
          this,
          Invocation.method(
            #getCurrentInterview,
            [interviewId],
          ),
        )),
        returnValueForMissingStub: _i4.Future<_i2.DreamInterviewModel>.value(
            _FakeDreamInterviewModel_0(
          this,
          Invocation.method(
            #getCurrentInterview,
            [interviewId],
          ),
        )),
      ) as _i4.Future<_i2.DreamInterviewModel>);
}

/// A class which mocks [DreamInterviewMessageModelFactory].
///
/// See the documentation for Mockito's code generation for more information.
class MockDreamInterviewMessageModelFactory extends _i1.Mock
    implements _i2.DreamInterviewMessageModelFactory {
  @override
  _i2.DreamInterviewMessageModel fromEntity(
          _i5.DreamInterviewMessage? entity) =>
      (super.noSuchMethod(
        Invocation.method(
          #fromEntity,
          [entity],
        ),
        returnValue: _FakeDreamInterviewMessageModel_1(
          this,
          Invocation.method(
            #fromEntity,
            [entity],
          ),
        ),
        returnValueForMissingStub: _FakeDreamInterviewMessageModel_1(
          this,
          Invocation.method(
            #fromEntity,
            [entity],
          ),
        ),
      ) as _i2.DreamInterviewMessageModel);

  @override
  _i2.DreamInterviewMessageModel fromJson(Map<String, dynamic>? json) =>
      (super.noSuchMethod(
        Invocation.method(
          #fromJson,
          [json],
        ),
        returnValue: _FakeDreamInterviewMessageModel_1(
          this,
          Invocation.method(
            #fromJson,
            [json],
          ),
        ),
        returnValueForMissingStub: _FakeDreamInterviewMessageModel_1(
          this,
          Invocation.method(
            #fromJson,
            [json],
          ),
        ),
      ) as _i2.DreamInterviewMessageModel);
}
