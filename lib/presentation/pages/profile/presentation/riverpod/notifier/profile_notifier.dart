import 'package:thousand_melochey/core/handlers/sp.dart';
import 'package:thousand_melochey/core/imports/imports.dart';

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

/*  Future<void> getUserInfo({
    VoidCallback? checkYourNetwork,
    VoidCallback? unAuthorised,
    VoidCallback? success,
  }) async {
    state = state.copyWith(isUserInfoLoading: true);

    final response = await _profileRepository.getUserInfo();
    response.when(success: (data) {
      state = state.copyWith(isUserInfoLoading: false, userInfo: data);
      nameController.text = data.name;
      emailController.text = data.email;
      success?.call();
    }, failure: (failure, status, data) {
      state = state.copyWith(
          isUserInfoLoading: false, isResponseError: true, userInfo: data);
      if (failure == const NetworkExceptions.unauthorisedRequest()) {
        unAuthorised?.call();
      }
      debugPrint("==> get user info response failure: $failure");
    });
  }*/

  Future<void> getUserInfo({
    VoidCallback? checkYourNetwork,
    VoidCallback? unAuthorised,
    VoidCallback? success,
  }) async {
    state = state.copyWith(
      isUserInfoLoading: true,
    );
    final jwtToken = await SP.readJWT();
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
}
