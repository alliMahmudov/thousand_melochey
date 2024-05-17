// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'main_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MainState {
  int get indexPage => throw _privateConstructorUsedError;
  int get shopId => throw _privateConstructorUsedError;
  String get lang => throw _privateConstructorUsedError;
  String get loadingText => throw _privateConstructorUsedError;
  String get userType =>
      throw _privateConstructorUsedError; // @Default(false) bool showFloatingButtonHome,
//InternetStatus? connectionStatus,
//LocalStorageDebtActionsResponse? debtActionsResponse,
  List<NavItemEnum> get navItem => throw _privateConstructorUsedError;
  List<GlobalKey<NavigatorState>> get listKey =>
      throw _privateConstructorUsedError;
  List<String> get icons => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MainStateCopyWith<MainState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MainStateCopyWith<$Res> {
  factory $MainStateCopyWith(MainState value, $Res Function(MainState) then) =
      _$MainStateCopyWithImpl<$Res, MainState>;
  @useResult
  $Res call(
      {int indexPage,
      int shopId,
      String lang,
      String loadingText,
      String userType,
      List<NavItemEnum> navItem,
      List<GlobalKey<NavigatorState>> listKey,
      List<String> icons});
}

/// @nodoc
class _$MainStateCopyWithImpl<$Res, $Val extends MainState>
    implements $MainStateCopyWith<$Res> {
  _$MainStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? indexPage = null,
    Object? shopId = null,
    Object? lang = null,
    Object? loadingText = null,
    Object? userType = null,
    Object? navItem = null,
    Object? listKey = null,
    Object? icons = null,
  }) {
    return _then(_value.copyWith(
      indexPage: null == indexPage
          ? _value.indexPage
          : indexPage // ignore: cast_nullable_to_non_nullable
              as int,
      shopId: null == shopId
          ? _value.shopId
          : shopId // ignore: cast_nullable_to_non_nullable
              as int,
      lang: null == lang
          ? _value.lang
          : lang // ignore: cast_nullable_to_non_nullable
              as String,
      loadingText: null == loadingText
          ? _value.loadingText
          : loadingText // ignore: cast_nullable_to_non_nullable
              as String,
      userType: null == userType
          ? _value.userType
          : userType // ignore: cast_nullable_to_non_nullable
              as String,
      navItem: null == navItem
          ? _value.navItem
          : navItem // ignore: cast_nullable_to_non_nullable
              as List<NavItemEnum>,
      listKey: null == listKey
          ? _value.listKey
          : listKey // ignore: cast_nullable_to_non_nullable
              as List<GlobalKey<NavigatorState>>,
      icons: null == icons
          ? _value.icons
          : icons // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MainStateImplCopyWith<$Res>
    implements $MainStateCopyWith<$Res> {
  factory _$$MainStateImplCopyWith(
          _$MainStateImpl value, $Res Function(_$MainStateImpl) then) =
      __$$MainStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int indexPage,
      int shopId,
      String lang,
      String loadingText,
      String userType,
      List<NavItemEnum> navItem,
      List<GlobalKey<NavigatorState>> listKey,
      List<String> icons});
}

/// @nodoc
class __$$MainStateImplCopyWithImpl<$Res>
    extends _$MainStateCopyWithImpl<$Res, _$MainStateImpl>
    implements _$$MainStateImplCopyWith<$Res> {
  __$$MainStateImplCopyWithImpl(
      _$MainStateImpl _value, $Res Function(_$MainStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? indexPage = null,
    Object? shopId = null,
    Object? lang = null,
    Object? loadingText = null,
    Object? userType = null,
    Object? navItem = null,
    Object? listKey = null,
    Object? icons = null,
  }) {
    return _then(_$MainStateImpl(
      indexPage: null == indexPage
          ? _value.indexPage
          : indexPage // ignore: cast_nullable_to_non_nullable
              as int,
      shopId: null == shopId
          ? _value.shopId
          : shopId // ignore: cast_nullable_to_non_nullable
              as int,
      lang: null == lang
          ? _value.lang
          : lang // ignore: cast_nullable_to_non_nullable
              as String,
      loadingText: null == loadingText
          ? _value.loadingText
          : loadingText // ignore: cast_nullable_to_non_nullable
              as String,
      userType: null == userType
          ? _value.userType
          : userType // ignore: cast_nullable_to_non_nullable
              as String,
      navItem: null == navItem
          ? _value._navItem
          : navItem // ignore: cast_nullable_to_non_nullable
              as List<NavItemEnum>,
      listKey: null == listKey
          ? _value._listKey
          : listKey // ignore: cast_nullable_to_non_nullable
              as List<GlobalKey<NavigatorState>>,
      icons: null == icons
          ? _value._icons
          : icons // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$MainStateImpl implements _MainState {
  const _$MainStateImpl(
      {this.indexPage = 0,
      this.shopId = 0,
      this.lang = "",
      this.loadingText = "",
      this.userType = "",
      final List<NavItemEnum> navItem = const [
        NavItemEnum.home,
        NavItemEnum.favorite,
        NavItemEnum.cart,
        NavItemEnum.profile
      ],
      final List<GlobalKey<NavigatorState>> listKey = const [],
      final List<String> icons = const []})
      : _navItem = navItem,
        _listKey = listKey,
        _icons = icons;

  @override
  @JsonKey()
  final int indexPage;
  @override
  @JsonKey()
  final int shopId;
  @override
  @JsonKey()
  final String lang;
  @override
  @JsonKey()
  final String loadingText;
  @override
  @JsonKey()
  final String userType;
// @Default(false) bool showFloatingButtonHome,
//InternetStatus? connectionStatus,
//LocalStorageDebtActionsResponse? debtActionsResponse,
  final List<NavItemEnum> _navItem;
// @Default(false) bool showFloatingButtonHome,
//InternetStatus? connectionStatus,
//LocalStorageDebtActionsResponse? debtActionsResponse,
  @override
  @JsonKey()
  List<NavItemEnum> get navItem {
    if (_navItem is EqualUnmodifiableListView) return _navItem;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_navItem);
  }

  final List<GlobalKey<NavigatorState>> _listKey;
  @override
  @JsonKey()
  List<GlobalKey<NavigatorState>> get listKey {
    if (_listKey is EqualUnmodifiableListView) return _listKey;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_listKey);
  }

  final List<String> _icons;
  @override
  @JsonKey()
  List<String> get icons {
    if (_icons is EqualUnmodifiableListView) return _icons;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_icons);
  }

  @override
  String toString() {
    return 'MainState(indexPage: $indexPage, shopId: $shopId, lang: $lang, loadingText: $loadingText, userType: $userType, navItem: $navItem, listKey: $listKey, icons: $icons)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MainStateImpl &&
            (identical(other.indexPage, indexPage) ||
                other.indexPage == indexPage) &&
            (identical(other.shopId, shopId) || other.shopId == shopId) &&
            (identical(other.lang, lang) || other.lang == lang) &&
            (identical(other.loadingText, loadingText) ||
                other.loadingText == loadingText) &&
            (identical(other.userType, userType) ||
                other.userType == userType) &&
            const DeepCollectionEquality().equals(other._navItem, _navItem) &&
            const DeepCollectionEquality().equals(other._listKey, _listKey) &&
            const DeepCollectionEquality().equals(other._icons, _icons));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      indexPage,
      shopId,
      lang,
      loadingText,
      userType,
      const DeepCollectionEquality().hash(_navItem),
      const DeepCollectionEquality().hash(_listKey),
      const DeepCollectionEquality().hash(_icons));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MainStateImplCopyWith<_$MainStateImpl> get copyWith =>
      __$$MainStateImplCopyWithImpl<_$MainStateImpl>(this, _$identity);
}

abstract class _MainState implements MainState {
  const factory _MainState(
      {final int indexPage,
      final int shopId,
      final String lang,
      final String loadingText,
      final String userType,
      final List<NavItemEnum> navItem,
      final List<GlobalKey<NavigatorState>> listKey,
      final List<String> icons}) = _$MainStateImpl;

  @override
  int get indexPage;
  @override
  int get shopId;
  @override
  String get lang;
  @override
  String get loadingText;
  @override
  String get userType;
  @override // @Default(false) bool showFloatingButtonHome,
//InternetStatus? connectionStatus,
//LocalStorageDebtActionsResponse? debtActionsResponse,
  List<NavItemEnum> get navItem;
  @override
  List<GlobalKey<NavigatorState>> get listKey;
  @override
  List<String> get icons;
  @override
  @JsonKey(ignore: true)
  _$$MainStateImplCopyWith<_$MainStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
