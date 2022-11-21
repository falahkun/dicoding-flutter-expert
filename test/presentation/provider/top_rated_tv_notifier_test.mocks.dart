// Mocks generated by Mockito 5.3.2 from annotations
// in ditonton/test/presentation/provider/top_rated_tv_notifier_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:dartz/dartz.dart' as _i3;
import 'package:ditonton/common/failure.dart' as _i6;
import 'package:ditonton/domain/entities/tv.dart' as _i7;
import 'package:ditonton/domain/entities/tv_detail.dart' as _i8;
import 'package:ditonton/domain/repositories/tv_repository.dart' as _i2;
import 'package:ditonton/domain/usecases/tv_usecase.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeTvRepository_0 extends _i1.SmartFake implements _i2.TvRepository {
  _FakeTvRepository_0(
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

/// A class which mocks [TvUseCaseImpl].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvUseCaseImpl extends _i1.Mock implements _i4.TvUseCaseImpl {
  MockTvUseCaseImpl() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TvRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeTvRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.TvRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i7.Tv>>> getNowPlayingTv() =>
      (super.noSuchMethod(
        Invocation.method(
          #getNowPlayingTv,
          [],
        ),
        returnValue: _i5.Future<_i3.Either<_i6.Failure, List<_i7.Tv>>>.value(
            _FakeEither_1<_i6.Failure, List<_i7.Tv>>(
          this,
          Invocation.method(
            #getNowPlayingTv,
            [],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, List<_i7.Tv>>>);
  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i7.Tv>>> getPopularTv() =>
      (super.noSuchMethod(
        Invocation.method(
          #getPopularTv,
          [],
        ),
        returnValue: _i5.Future<_i3.Either<_i6.Failure, List<_i7.Tv>>>.value(
            _FakeEither_1<_i6.Failure, List<_i7.Tv>>(
          this,
          Invocation.method(
            #getPopularTv,
            [],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, List<_i7.Tv>>>);
  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i7.Tv>>> getTopRatedTv() =>
      (super.noSuchMethod(
        Invocation.method(
          #getTopRatedTv,
          [],
        ),
        returnValue: _i5.Future<_i3.Either<_i6.Failure, List<_i7.Tv>>>.value(
            _FakeEither_1<_i6.Failure, List<_i7.Tv>>(
          this,
          Invocation.method(
            #getTopRatedTv,
            [],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, List<_i7.Tv>>>);
  @override
  _i5.Future<_i3.Either<_i6.Failure, _i8.TvDetail>> getTvDetail(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getTvDetail,
          [id],
        ),
        returnValue: _i5.Future<_i3.Either<_i6.Failure, _i8.TvDetail>>.value(
            _FakeEither_1<_i6.Failure, _i8.TvDetail>(
          this,
          Invocation.method(
            #getTvDetail,
            [id],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, _i8.TvDetail>>);
  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i7.Tv>>> getTvRecommendations(
          int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getTvRecommendations,
          [id],
        ),
        returnValue: _i5.Future<_i3.Either<_i6.Failure, List<_i7.Tv>>>.value(
            _FakeEither_1<_i6.Failure, List<_i7.Tv>>(
          this,
          Invocation.method(
            #getTvRecommendations,
            [id],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, List<_i7.Tv>>>);
  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i7.Tv>>> getWatchlistTv() =>
      (super.noSuchMethod(
        Invocation.method(
          #getWatchlistTv,
          [],
        ),
        returnValue: _i5.Future<_i3.Either<_i6.Failure, List<_i7.Tv>>>.value(
            _FakeEither_1<_i6.Failure, List<_i7.Tv>>(
          this,
          Invocation.method(
            #getWatchlistTv,
            [],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, List<_i7.Tv>>>);
  @override
  _i5.Future<bool> isAddedToWatchlist(int? id) => (super.noSuchMethod(
        Invocation.method(
          #isAddedToWatchlist,
          [id],
        ),
        returnValue: _i5.Future<bool>.value(false),
      ) as _i5.Future<bool>);
  @override
  _i5.Future<_i3.Either<_i6.Failure, String>> removeTvWatchlist(
          _i8.TvDetail? tvDetail) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeTvWatchlist,
          [tvDetail],
        ),
        returnValue: _i5.Future<_i3.Either<_i6.Failure, String>>.value(
            _FakeEither_1<_i6.Failure, String>(
          this,
          Invocation.method(
            #removeTvWatchlist,
            [tvDetail],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, String>>);
  @override
  _i5.Future<_i3.Either<_i6.Failure, String>> saveTvWatchlist(
          _i8.TvDetail? tvDetail) =>
      (super.noSuchMethod(
        Invocation.method(
          #saveTvWatchlist,
          [tvDetail],
        ),
        returnValue: _i5.Future<_i3.Either<_i6.Failure, String>>.value(
            _FakeEither_1<_i6.Failure, String>(
          this,
          Invocation.method(
            #saveTvWatchlist,
            [tvDetail],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, String>>);
  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i7.Tv>>> searchTv(String? query) =>
      (super.noSuchMethod(
        Invocation.method(
          #searchTv,
          [query],
        ),
        returnValue: _i5.Future<_i3.Either<_i6.Failure, List<_i7.Tv>>>.value(
            _FakeEither_1<_i6.Failure, List<_i7.Tv>>(
          this,
          Invocation.method(
            #searchTv,
            [query],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, List<_i7.Tv>>>);
}
