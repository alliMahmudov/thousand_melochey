// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'categories_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CategoriesState {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isLoadingPaginationProducts => throw _privateConstructorUsedError;
  bool get isLoadMore => throw _privateConstructorUsedError;
  CategoriesResponse? get categories => throw _privateConstructorUsedError;
  CategoryProductsResponse? get categoryProducts =>
      throw _privateConstructorUsedError;
  ProductsResponse? get products => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CategoriesStateCopyWith<CategoriesState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CategoriesStateCopyWith<$Res> {
  factory $CategoriesStateCopyWith(
          CategoriesState value, $Res Function(CategoriesState) then) =
      _$CategoriesStateCopyWithImpl<$Res, CategoriesState>;
  @useResult
  $Res call(
      {bool isLoading,
      bool isLoadingPaginationProducts,
      bool isLoadMore,
      CategoriesResponse? categories,
      CategoryProductsResponse? categoryProducts,
      ProductsResponse? products});
}

/// @nodoc
class _$CategoriesStateCopyWithImpl<$Res, $Val extends CategoriesState>
    implements $CategoriesStateCopyWith<$Res> {
  _$CategoriesStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isLoadingPaginationProducts = null,
    Object? isLoadMore = null,
    Object? categories = freezed,
    Object? categoryProducts = freezed,
    Object? products = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingPaginationProducts: null == isLoadingPaginationProducts
          ? _value.isLoadingPaginationProducts
          : isLoadingPaginationProducts // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadMore: null == isLoadMore
          ? _value.isLoadMore
          : isLoadMore // ignore: cast_nullable_to_non_nullable
              as bool,
      categories: freezed == categories
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as CategoriesResponse?,
      categoryProducts: freezed == categoryProducts
          ? _value.categoryProducts
          : categoryProducts // ignore: cast_nullable_to_non_nullable
              as CategoryProductsResponse?,
      products: freezed == products
          ? _value.products
          : products // ignore: cast_nullable_to_non_nullable
              as ProductsResponse?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CategoriesStateImplCopyWith<$Res>
    implements $CategoriesStateCopyWith<$Res> {
  factory _$$CategoriesStateImplCopyWith(_$CategoriesStateImpl value,
          $Res Function(_$CategoriesStateImpl) then) =
      __$$CategoriesStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      bool isLoadingPaginationProducts,
      bool isLoadMore,
      CategoriesResponse? categories,
      CategoryProductsResponse? categoryProducts,
      ProductsResponse? products});
}

/// @nodoc
class __$$CategoriesStateImplCopyWithImpl<$Res>
    extends _$CategoriesStateCopyWithImpl<$Res, _$CategoriesStateImpl>
    implements _$$CategoriesStateImplCopyWith<$Res> {
  __$$CategoriesStateImplCopyWithImpl(
      _$CategoriesStateImpl _value, $Res Function(_$CategoriesStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isLoadingPaginationProducts = null,
    Object? isLoadMore = null,
    Object? categories = freezed,
    Object? categoryProducts = freezed,
    Object? products = freezed,
  }) {
    return _then(_$CategoriesStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingPaginationProducts: null == isLoadingPaginationProducts
          ? _value.isLoadingPaginationProducts
          : isLoadingPaginationProducts // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadMore: null == isLoadMore
          ? _value.isLoadMore
          : isLoadMore // ignore: cast_nullable_to_non_nullable
              as bool,
      categories: freezed == categories
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as CategoriesResponse?,
      categoryProducts: freezed == categoryProducts
          ? _value.categoryProducts
          : categoryProducts // ignore: cast_nullable_to_non_nullable
              as CategoryProductsResponse?,
      products: freezed == products
          ? _value.products
          : products // ignore: cast_nullable_to_non_nullable
              as ProductsResponse?,
    ));
  }
}

/// @nodoc

class _$CategoriesStateImpl implements _CategoriesState {
  const _$CategoriesStateImpl(
      {this.isLoading = false,
      this.isLoadingPaginationProducts = false,
      this.isLoadMore = false,
      this.categories,
      this.categoryProducts,
      this.products});

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isLoadingPaginationProducts;
  @override
  @JsonKey()
  final bool isLoadMore;
  @override
  final CategoriesResponse? categories;
  @override
  final CategoryProductsResponse? categoryProducts;
  @override
  final ProductsResponse? products;

  @override
  String toString() {
    return 'CategoriesState(isLoading: $isLoading, isLoadingPaginationProducts: $isLoadingPaginationProducts, isLoadMore: $isLoadMore, categories: $categories, categoryProducts: $categoryProducts, products: $products)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CategoriesStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isLoadingPaginationProducts,
                    isLoadingPaginationProducts) ||
                other.isLoadingPaginationProducts ==
                    isLoadingPaginationProducts) &&
            (identical(other.isLoadMore, isLoadMore) ||
                other.isLoadMore == isLoadMore) &&
            (identical(other.categories, categories) ||
                other.categories == categories) &&
            (identical(other.categoryProducts, categoryProducts) ||
                other.categoryProducts == categoryProducts) &&
            (identical(other.products, products) ||
                other.products == products));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isLoading,
      isLoadingPaginationProducts,
      isLoadMore,
      categories,
      categoryProducts,
      products);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CategoriesStateImplCopyWith<_$CategoriesStateImpl> get copyWith =>
      __$$CategoriesStateImplCopyWithImpl<_$CategoriesStateImpl>(
          this, _$identity);
}

abstract class _CategoriesState implements CategoriesState {
  const factory _CategoriesState(
      {final bool isLoading,
      final bool isLoadingPaginationProducts,
      final bool isLoadMore,
      final CategoriesResponse? categories,
      final CategoryProductsResponse? categoryProducts,
      final ProductsResponse? products}) = _$CategoriesStateImpl;

  @override
  bool get isLoading;
  @override
  bool get isLoadingPaginationProducts;
  @override
  bool get isLoadMore;
  @override
  CategoriesResponse? get categories;
  @override
  CategoryProductsResponse? get categoryProducts;
  @override
  ProductsResponse? get products;
  @override
  @JsonKey(ignore: true)
  _$$CategoriesStateImplCopyWith<_$CategoriesStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
