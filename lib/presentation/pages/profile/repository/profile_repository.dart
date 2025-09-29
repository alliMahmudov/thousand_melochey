

import 'package:thousand_melochey/core/imports/imports.dart';

abstract class ProfileRepository{

  Future<ApiResult<dynamic>> getUserInfo({required String jwtToken});

  Future<ApiResult<dynamic>> getDistricts();

  Future<ApiResult<dynamic>> addNewAddress({required String streetName, required int districtID});

  Future<ApiResult<dynamic>> getAllAddresses();

  Future<ApiResult<dynamic>> deleteAddress({required int addressID});

  Future<ApiResult<dynamic>> changeAddress({
    required int addressID,
    required String streetName,
    required int districtID,
  });

  Future<dynamic> logOut();

 // Future<dynamic> getOrders();


}