import 'package:thousand_melochey/core/handlers/local_storage.dart';
import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/presentation/pages/cart/data/get_districts_response.dart';
import 'package:thousand_melochey/presentation/pages/profile/data/all_adresses_response.dart';
import 'package:thousand_melochey/service/localizations/riverpod/provider/localization_provider.dart';

import '../../../../cart/data/create_order_response.dart';

class ProfileNotifier extends StateNotifier<ProfileState> {
  final ProfileRepository _profileRepository;
  final Ref ref;

  ProfileNotifier(this._profileRepository, this.ref) : super(const ProfileState());
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
  final TextEditingController currentPasswordController = TextEditingController();

  selectDistrict(District district) => state = state.copyWith(selectedDistrict: district);

  selectAddress(int addressID) => state = state.copyWith(selectedAddress: addressID);

  selectUserAddress(Address address) => state = state.copyWith(selectedUserAddress: address);


  Future<void> changeAppLanguage({
    VoidCallback? checkYourNetwork,
    VoidCallback? unAuthorised,
    VoidCallback? success,
    required String lang,
    BuildContext? context,
  }) async {
    state = state.copyWith(isLoading: true);

    final response = await _profileRepository.changeAppLanguage(lang: lang);

    response.when(
      success: (data) async {
        // После успешного обновления на бэкенде, обновляем только состояние
        // Локальное хранилище и перезапуск приложения будут выполнены в setLang
        final updatedUserInfo = state.userInfo != null
            ? UserInfoResponse(
          id: state.userInfo!.id,
          name: state.userInfo!.name,
          email: state.userInfo!.email,
          phoneNumber: state.userInfo!.phoneNumber,
          language: lang,
        )
            : null;
        state = state.copyWith(
          isLoading: false,
          userInfo: updatedUserInfo,
        );
        success?.call();
      },
      failure: (failure, status, errorMessage) {
        state = state.copyWith(isResponseError: true, isLoading: false);

        if (failure == const NetworkExceptions.unauthorisedRequest()) {
          unAuthorised?.call();
        }
        debugPrint('==> change app language failure: $failure');
      },
    );
  }

  /// Синхронизирует язык при первой авторизации
  /// Отправляет локальный язык на бэкенд, если на бэкенде язык не установлен
  Future<void> syncLanguageOnFirstAuth({BuildContext? context}) async {
    try {
      // Получаем информацию о пользователе
      final jwtToken = LocalStorage.instance.getJWT();
      if (jwtToken.isEmpty) return;

      final response = await _profileRepository.getUserInfo(jwtToken: 'jwt=$jwtToken');

      response.when(
        success: (data) async {
          final localLang = LocalStorage.instance.getLang();

          // Если на бэкенде язык не установлен или пустой, отправляем локальный
          if (data.language == null || data.language!.isEmpty) {
            await changeAppLanguage(
              lang: localLang,
              context: context,
            );
          } else if (data.language != localLang) {
            // Если языки отличаются, применяем язык из бэкенда
            final langNotifier = ref.read(langProvider(0).notifier);
            await langNotifier.syncLangFromBackend(data.language!, context);
          }
        },
        failure: (failure, status, errorMessage) {
          debugPrint('==> sync language on first auth failure: $failure');
        },
      );
    } catch (e) {
      debugPrint('==> sync language on first auth error: $e');
    }
  }

  Future<void> getUserInfo({
    VoidCallback? checkYourNetwork,
    VoidCallback? unAuthorised,
    VoidCallback? success,
    BuildContext? context,
  }) async {
    state = state.copyWith(
      isUserInfoLoading: true,
    );
    final jwtToken = LocalStorage.instance.getJWT();
    final response =
    await _profileRepository.getUserInfo(jwtToken: 'jwt=$jwtToken');
    response.when(
      success: (data) async {
        state = state.copyWith(isUserInfoLoading: false, userInfo: data);

        // Синхронизируем язык из бэкенда, если он отличается от локального
        if (data.language != null && data.language!.isNotEmpty) {
          final currentLocalLang = LocalStorage.instance.getLang();
          if (currentLocalLang != data.language) {
            // Применяем язык из бэкенда
            final langNotifier = ref.read(langProvider(0).notifier);
            await langNotifier.syncLangFromBackend(data.language!, context);
          }
        }

        success?.call();
      },
      failure: (failure, status, errorMessage) {
        state = state.copyWith(
            isResponseError: true, isUserInfoLoading: false);

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
      failure: (failure, status, errorMessage) {
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
      failure: (failure, status, errorMessage) {
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
      failure: (failure, status, errorMessage) {
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
      failure: (failure, status, errorMessage) {
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
    }, failure: (failure, status, errorMessage) {

      state = state.copyWith(isLoading: false, isResponseError: true);
      if (failure == const NetworkExceptions.unauthorisedRequest()) {
        unAuthorised?.call();
      }
      debugPrint('==> get districts response failure: $failure');
    });
  }

  Future<void> deleteAccount({
    VoidCallback? checkYourNetwork,
    VoidCallback? unAuthorised,
    VoidCallback? success,
  }) async {

    state = state.copyWith(isLoading: true);

    final response = await _profileRepository.deleteAccount(currentPassword: currentPasswordController.text);

    response.when(success: (data) async {

      state = state.copyWith(isLoading: false);

      success?.call();

    }, failure: (failure, status, errorMessage) {
      state = state.copyWith(isLoading: false, isResponseError: true);

      AppHelpers.showErrorToast(errorMessage: errorMessage.toString());

      if (failure == const NetworkExceptions.unauthorisedRequest()) {
        unAuthorised?.call();
      }
      debugPrint('==> delete account response failure: $failure');
    });
  }

}
