import 'package:thousand_melochey/core/handlers/local_storage.dart';
import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/presentation/pages/cart/data/get_districts_response.dart';
import 'package:thousand_melochey/presentation/pages/profile/data/all_adresses_response.dart';

import '../../../../cart/data/create_order_response.dart';

class ProfileNotifier extends StateNotifier<ProfileState> {
  final ProfileRepository _profileRepository;

  ProfileNotifier(this._profileRepository) : super(const ProfileState());
  ScrollController scrollController = ScrollController();
  final ValueNotifier<double> scrollPosition = ValueNotifier<double>(0.0);

  scrolled(bool check) {
    scrollController = ScrollController()
      ..addListener(() {
        if (scrollController.hasClients) {
          check = scrollController.offset <= 0;
        }
      });
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController streetNameController = TextEditingController();
  final TextEditingController editStreetNameController = TextEditingController();

  selectDistrict(District district) => state = state.copyWith(selectedDistrict: district);

  selectAddress(int addressID) => state = state.copyWith(selectedAddress: addressID);

  selectUserAddress(Address address) => state = state.copyWith(selectedUserAddress: address);

  Future<void> getUserInfo({
    VoidCallback? checkYourNetwork,
    VoidCallback? unAuthorised,
    VoidCallback? success,
  }) async {
    state = state.copyWith(
      isUserInfoLoading: true,
    );
    final jwtToken = await LocalStorage.instance.getJWT();
    final response =
        await _profileRepository.getUserInfo(jwtToken: 'jwt=$jwtToken');
    response.when(
      success: (data) async {
        state = state.copyWith(isUserInfoLoading: false, userInfo: data);
        success?.call();
      },
      failure: (failure, status, data) {
        state = state.copyWith(
            isResponseError: true, isUserInfoLoading: false, userInfo: data);

        if (failure == const NetworkExceptions.unauthorisedRequest()) {
          unAuthorised?.call();
        }
        debugPrint('==> get profile info failure: $failure');
      },
    );
  }

  Future<void> logOut({
    VoidCallback? checkYourNetwork,
    VoidCallback? unAuthorised,
    VoidCallback? success,
  }) async {
    state = state.copyWith(
      isLoading: true,
    );
    final response = await _profileRepository.logOut();
    response.when(
      success: (data) async {
        state = state.copyWith(isLoading: false);
        success?.call();
      },
      failure: (failure, status, data) {
        state = state.copyWith(isResponseError: true, isLoading: false);

        if (failure == const NetworkExceptions.unauthorisedRequest()) {
          unAuthorised?.call();
        }
        debugPrint('==> logout failure: $failure');
      },
    );
  }

  Future<void> addingNewAddress({
    VoidCallback? checkYourNetwork,
    VoidCallback? unAuthorised,
    VoidCallback? success,
    required String streetName,
    required int districtID,
  }) async {
    state = state.copyWith(isLoading: true);
    
    final response = await _profileRepository.addNewAddress(streetName: streetName, districtID: districtID);
    
    response.when(
      success: (data) async {
        state = state.copyWith(isLoading: false);
        success?.call();
      },
      failure: (failure, status, data) {
        state = state.copyWith(isResponseError: true, isLoading: false);

        if (failure == const NetworkExceptions.unauthorisedRequest()) {
          unAuthorised?.call();
        }
        debugPrint('==> adding new address failure: $failure');
      },
    );
  }

  Future<void> changeAddress({
    VoidCallback? checkYourNetwork,
    VoidCallback? unAuthorised,
    VoidCallback? success,
    required String streetName,
    required int districtID,
    required int addressID,
  }) async {
    state = state.copyWith(isLoading: true);

    final response = await _profileRepository.changeAddress(
        addressID: addressID,
        streetName: streetName,
        districtID: districtID,
    );

    response.when(
      success: (data) async {
        state = state.copyWith(isLoading: false);
        success?.call();
      },
      failure: (failure, status, data) {
        state = state.copyWith(isResponseError: true, isLoading: false);

        if (failure == const NetworkExceptions.unauthorisedRequest()) {
          unAuthorised?.call();
        }
        debugPrint('==> adding new address failure: $failure');
      },
    );
  }

  Future<void> deleteAddress({
    VoidCallback? checkYourNetwork,
    VoidCallback? unAuthorised,
    VoidCallback? success,
    required int addressID,
  }) async {
    state = state.copyWith(isLoading: true);

    final response = await _profileRepository.deleteAddress(addressID: addressID);

    response.when(
      success: (data) async {
        state = state.copyWith(isLoading: false);
        success?.call();
      },
      failure: (failure, status, errorMessage) {
        state = state.copyWith(isResponseError: true, isLoading: false);
        AppHelpers.showErrorToast(errorMessage: errorMessage);
        if (failure == const NetworkExceptions.unauthorisedRequest()) {
          unAuthorised?.call();
        }
        debugPrint('==> delete address failure: $failure');
      },
    );
  }

  Future<void> getAllAddresses({
    VoidCallback? checkYourNetwork,
    VoidCallback? unAuthorised,
    VoidCallback? success,
  }) async {
    state = state.copyWith(isLoading: true);

    final response = await _profileRepository.getAllAddresses();

    response.when(
      success: (data) async {
        state = state.copyWith(isLoading: false, userAllAddresses: data);
        success?.call();
      },
      failure: (failure, status, data) {
        state = state.copyWith(isResponseError: true, isLoading: false);

        if (failure == const NetworkExceptions.unauthorisedRequest()) {
          unAuthorised?.call();
        }
        debugPrint('==> get all addresses failure: $failure');
      },
    );
  }

  Future<void> getDistricts({
    VoidCallback? checkYourNetwork,
    VoidCallback? unAuthorised,
    VoidCallback? success,
  }) async {
    state = state.copyWith(isLoading: true);
    final response =
    await _profileRepository.getDistricts();
    response.when(success: (data) async {

      state = state.copyWith(isLoading: false, districts: data);
      success?.call();
    }, failure: (failure, status, data) {

      state = state.copyWith(isLoading: false, isResponseError: true);
      if (failure == const NetworkExceptions.unauthorisedRequest()) {
        unAuthorised?.call();
      }
      debugPrint('==> get districts response failure: $failure');
    });
  }

}
