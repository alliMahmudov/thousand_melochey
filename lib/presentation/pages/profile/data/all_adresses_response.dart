// To parse this JSON data, do
//
//     final allAddressesResponse = allAddressesResponseFromJson(jsonString);

import 'dart:convert';

AllAddressesResponse allAddressesResponseFromJson(String str) => AllAddressesResponse.fromJson(json.decode(str));

String allAddressesResponseToJson(AllAddressesResponse data) => json.encode(data.toJson());

class AllAddressesResponse {
  final List<Address>? addresses;

  AllAddressesResponse({
    this.addresses,
  });

  factory AllAddressesResponse.fromJson(Map<String, dynamic> json) => AllAddressesResponse(
    addresses: json["addresses"] == null ? [] : List<Address>.from(json["addresses"]!.map((x) => Address.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "addresses": addresses == null ? [] : List<dynamic>.from(addresses!.map((x) => x.toJson())),
  };
}

class Address {
  final int? id;
  final String? addressLine1;
  final dynamic addressLine2;
  final String? city;
  final int? districtIdRead;
  final String? districtName;

  Address({
    this.id,
    this.addressLine1,
    this.addressLine2,
    this.city,
    this.districtIdRead,
    this.districtName,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
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
