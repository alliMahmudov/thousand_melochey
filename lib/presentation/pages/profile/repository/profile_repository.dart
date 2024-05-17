

import 'package:thousand_melochey/core/imports/imports.dart';

abstract class ProfileRepository{

  Future<ApiResult<UserInfoResponse>> getUserInfo({required String jwtToken});


  Future<dynamic> logOut();

 // Future<dynamic> getOrders();


}