// Mocks generated by Mockito 5.4.4 from annotations
// in dream_catcher/test/features/dream/presentation/bloc/dream_detail_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:dartz/dartz.dart' as _i3;
import 'package:dream_catcher/core/error/failure.dart' as _i6;
import 'package:dream_catcher/features/dream/domain/entities/dream_detail.dart'
    as _i7;
import 'package:dream_catcher/features/dream/domain/repositories/dream_repository.dart'
    as _i2;
import 'package:dream_catcher/features/dream/domain/use-cases/get_dream.dart'
    as _i4;
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

class _FakeDreamRepository_0 extends _i1.SmartFake
    implements _i2.DreamRepository {
  _FakeDreamRepository_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeEither_1<L, R> extends _i1.SmartFake implements _i3.Either<L, R> {
  _FakeEither_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [GetDream].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetDream extends _i1.Mock implements _i4.GetDream {
  @override
  _i2.DreamRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeDreamRepository_0(
          this,
          Invocation.getter(#repository),
        ),
        returnValueForMissingStub: _FakeDreamRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.DreamRepository);

  @override
  _i5.Future<_i3.Either<_i6.Failure, _i7.DreamDetail>> call(
          _i4.GetDreamParams? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [params],
        ),
        returnValue: _i5.Future<_i3.Either<_i6.Failure, _i7.DreamDetail>>.value(
            _FakeEither_1<_i6.Failure, _i7.DreamDetail>(
          this,
          Invocation.method(
            #call,
            [params],
          ),
        )),
        returnValueForMissingStub:
            _i5.Future<_i3.Either<_i6.Failure, _i7.DreamDetail>>.value(
                _FakeEither_1<_i6.Failure, _i7.DreamDetail>(
          this,
          Invocation.method(
            #call,
            [params],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, _i7.DreamDetail>>);
}
