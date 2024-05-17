import 'package:thousand_melochey/core/imports/imports.dart';

part 'api_result.freezed.dart';

@freezed
class ApiResult<T> with _$ApiResult<T> {
  const factory ApiResult.success({required T data}) = Success<T>;

  const factory ApiResult.failure(
      {required NetworkExceptions error,
      required int statusCode,
      T? data}) = Failure<T>;
}
