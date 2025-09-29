import 'package:thousand_melochey/contstants/app_api_error_helper.dart';
import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/presentation/pages/cart/data/get_districts_response.dart';
import 'package:thousand_melochey/presentation/pages/profile/data/adding_new_address_response.dart';
import 'package:thousand_melochey/presentation/pages/profile/data/all_adresses_response.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  @override
  Future<ApiResult<UserInfoResponse>> getUserInfo({
    required String jwtToken
}) async {
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.get('/api/user/');
      return ApiResult.success(
        data: UserInfoResponse.fromJson(response.data),
      );
    } on DioException catch (e) {
      debugPrint('==> get user info failure: ${e.response?.data}');
      return ApiResult.failure(
        error: NetworkExceptions.getDioException(e),
        statusCode: NetworkExceptions.getDioStatus(e),
      );
    } catch (e) {
      debugPrint('==> get user info failure: $e');
      return ApiResult.failure(
          error: NetworkExceptions.getDioException(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult> logOut() async {
    try {
      final client = inject<HttpService>().client();
      final response = await client.post('/api/logout/');
      return const ApiResult.success(
        data: "Log out successfully",
      );
    } on DioException catch (e) {
      debugPrint('==> logout  failure: ${e.response?.data}');
      return ApiResult.failure(
        error: NetworkExceptions.getDioException(e),
        statusCode: NetworkExceptions.getDioStatus(e),
      );
    } catch (e) {
      debugPrint('==> log out failure: $e');
      return ApiResult.failure(
          error: NetworkExceptions.getDioException(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult> addNewAddress({required String streetName, required int districtID}) async {
    final data = <String, dynamic> {
      "address_line1": streetName,
      "city": "Tashkent",
      "district_id": "$districtID",
    };
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.post('api/user/address/new/', data: data);
      return ApiResult.success(
        data: AddingNewAddressResponse.fromJson(response.data),
      );
    } on DioException catch (e) {
      debugPrint('==> adding new address failure: ${e.response?.data}');
      return ApiResult.failure(
        error: NetworkExceptions.getDioException(e),
        statusCode: NetworkExceptions.getDioStatus(e),
      );
    } catch (e) {
      debugPrint('==> adding new address failure: $e');
      return ApiResult.failure(
          error: NetworkExceptions.getDioException(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult> getAllAddresses() async {
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.get('api/user/all/addresses/');
      return ApiResult.success(
        data: AllAddressesResponse.fromJson(response.data),
      );
    } on DioException catch (e) {
      debugPrint('==> get all addresses failure: ${e.response?.data}');
      return ApiResult.failure(
        error: NetworkExceptions.getDioException(e),
        statusCode: NetworkExceptions.getDioStatus(e),
      );
    } catch (e) {
      debugPrint('==> get all addresses failure: $e');
      return ApiResult.failure(
          error: NetworkExceptions.getDioException(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult> deleteAddress({
    required int addressID
}) async {
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.delete('api/user/addresses/$addressID/');
      return const ApiResult.success(
        data: "Deleted successfully",
      );
    } on DioException catch (e) {
      debugPrint('==> delete address failure: ${e.response?.data}');
      return ApiResult.failure(
        error: NetworkExceptions.getDioException(e),
        statusCode: NetworkExceptions.getDioStatus(e),
        data: AppApiErrorHelper.message(e.response?.data)
      );
    } catch (e) {
      debugPrint('==> delete address failure: $e');
      return ApiResult.failure(
          error: NetworkExceptions.getDioException(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult> changeAddress({
    required int addressID,
    required String streetName,
    required int districtID,
  }) async {
    final data = <String, dynamic> {
      "address_line1": streetName,
      "city": "Tashkent",
      "district_id": "$districtID",
    };
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.put('api/user/addresses/$addressID/', data: data);
      return ApiResult.success(
        data: AddingNewAddressResponse.fromJson(response.data),
      );
    } on DioException catch (e) {
      debugPrint('==> change address failure: ${e.response?.data}');
      return ApiResult.failure(
          error: NetworkExceptions.getDioException(e),
          statusCode: NetworkExceptions.getDioStatus(e),
          data: AppApiErrorHelper.message(e.response?.data)
      );
    } catch (e) {
      debugPrint('==> change address failure: $e');
      return ApiResult.failure(
          error: NetworkExceptions.getDioException(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult> getDistricts() async{
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.get('api/districts/');
      return ApiResult.success(
          data: GetDistrictsResponse.fromJson(response.data));
    } on DioException catch (e) {
      debugPrint('==> Get districts failure: ${e.response?.data}');
      return ApiResult.failure(
        error: NetworkExceptions.getDioException(e),
        statusCode: NetworkExceptions.getDioStatus(e),
      );
    } catch (e) {
      debugPrint('==> Get districts failure: $e');
      return ApiResult.failure(
          error: NetworkExceptions.getDioException(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }
}
