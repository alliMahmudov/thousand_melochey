



import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/presentation/pages/cart/data/get_districts_response.dart';
import 'package:thousand_melochey/presentation/pages/profile/data/all_adresses_response.dart';
import 'package:thousand_melochey/presentation/pages/profile/data/user_info_response.dart';
part 'profile_state.freezed.dart';

@freezed
class ProfileState with _$ProfileState{
  const factory ProfileState({

    @Default(false) bool isLoading,
    @Default(false) bool isResponseError,
    @Default(false) bool isNotEmpty,
    @Default(false) bool isCollapse,
    @Default(false) bool isError,
    @Default(false) bool isUserInfoLoading,
    @Default('uz') String defaultLang,
    @Default(0) int selectedAddress,
    Locale? localLang,
    UserInfoResponse? userInfo,
    AllAddressesResponse? userAllAddresses,
    GetDistrictsResponse? districts,
    District? selectedDistrict,
    Address? selectedUserAddress


}) = _ProfileState;
}