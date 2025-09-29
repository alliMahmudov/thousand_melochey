// To parse this JSON data, do
//
//     final addingNewAddressResponse = addingNewAddressResponseFromJson(jsonString);

import 'dart:convert';

AddingNewAddressResponse addingNewAddressResponseFromJson(String str) => AddingNewAddressResponse.fromJson(json.decode(str));

String addingNewAddressResponseToJson(AddingNewAddressResponse data) => json.encode(data.toJson());

class AddingNewAddressResponse {
  final int? id;
  final String? addressLine1;
  final dynamic addressLine2;
  final String? city;
  final int? districtIdRead;
  final String? districtName;

  AddingNewAddressResponse({
    this.id,
    this.addressLine1,
    this.addressLine2,
    this.city,
    this.districtIdRead,
    this.districtName,
  });

  factory AddingNewAddressResponse.fromJson(Map<String, dynamic> json) => AddingNewAddressResponse(
    id: json["id"],
    addressLine1: json["address_line1"],
    addressLine2: json["address_line2"],
    city: json["city"],
    districtIdRead: json["district_id_read"],
    districtName: json["district_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "address_line1": addressLine1,
    "address_line2": addressLine2,
    "city": city,
    "district_id_read": districtIdRead,
    "district_name": districtName,
  };
}
