// To parse this JSON data, do
//
//     final getDistrictsResponse = getDistrictsResponseFromJson(jsonString);

import 'dart:convert';

GetDistrictsResponse getDistrictsResponseFromJson(String str) => GetDistrictsResponse.fromJson(json.decode(str));

String getDistrictsResponseToJson(GetDistrictsResponse data) => json.encode(data.toJson());

class GetDistrictsResponse {
  final String? status;
  final Data? data;

  GetDistrictsResponse({
    this.status,
    this.data,
  });

  factory GetDistrictsResponse.fromJson(Map<String, dynamic> json) => GetDistrictsResponse(
    status: json["status"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data?.toJson(),
  };
}

class Data {
  final List<District>? districts;

  Data({
    this.districts,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    districts: json["districts"] == null ? [] : List<District>.from(json["districts"]!.map((x) => District.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "districts": districts == null ? [] : List<dynamic>.from(districts!.map((x) => x.toJson())),
  };
}

class District {
  final int? id;
  final String? name;

  District({
    this.id,
    this.name,
  });

  factory District.fromJson(Map<String, dynamic> json) => District(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
