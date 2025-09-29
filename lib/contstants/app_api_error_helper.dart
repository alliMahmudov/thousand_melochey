import 'dart:convert';
import 'dart:developer';

import '../core/imports/imports.dart';

class AppApiErrorHelper {
  AppApiErrorHelper._();

  static String message(dynamic data) {

    try{
      if(data != null && data.toString() != "null"){
        final errors = AppApiErrorHelperResponse.fromJson(data);
        if (errors.data?.message?.isNotEmpty ?? false) {
          return AppApiErrorHelperResponse.fromJson(data).data?.message ?? "";
        } else if (errors.message?.isNotEmpty ?? false) {
          return AppApiErrorHelperResponse.fromJson(data).message ?? "";
        } else {
          return "Kechirasiz no'malum xatolik yuz berdi";
        }
      }else{
        return "Kechirasiz no'malum xatolik yuz berdi";

      }
    }catch(e,s){
      debugPrint("$e, $s");
      if(data.runtimeType == String){
        return data.toString();
      }
      return "Kechirasiz no'malum xatolik yuz berdi";
    }
  }}



AppApiErrorHelperResponse appApiErrorHelperResponseFromJson(String str) => AppApiErrorHelperResponse.fromJson(json.decode(str));

String appApiErrorHelperResponseToJson(AppApiErrorHelperResponse data) => json.encode(data.toJson());

class AppApiErrorHelperResponse {
  final String? message;
  final Data? data;

  AppApiErrorHelperResponse({
    this.message,
    this.data,
  });

  factory AppApiErrorHelperResponse.fromJson(Map<String, dynamic> json) => AppApiErrorHelperResponse(
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  final bool? success;
  final String? message;

  Data({
    this.success,
    this.message,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}
