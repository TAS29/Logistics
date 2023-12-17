// To parse this JSON data, do
//
//     final searchModel = searchModelFromJson(jsonString);

import 'dart:convert';

SearchModel searchModelFromJson(String str) => SearchModel.fromJson(json.decode(str));

String searchModelToJson(SearchModel data) => json.encode(data.toJson());

class SearchModel {
    List<Value> value;

    SearchModel({
        required this.value,
    });

    factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
        value: List<Value>.from(json["value"].map((x) => Value.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "value": List<dynamic>.from(value.map((x) => x.toJson())),
    };
}

class Value {
    double searchScore;
    String transporterId;
    String transporterName;
    String logo;
    String? suggestion;
    String? locationName;

    Value({
        required this.searchScore,
        required this.transporterId,
        required this.transporterName,
        required this.logo,
        this.suggestion,
        required this.locationName,
    });

    factory Value.fromJson(Map<String, dynamic> json) => Value(
        searchScore: json["@search.score"]?.toDouble() ?? 0.0,
        transporterId: json["transporter_id"]??"",
        locationName: json["location_name"]??"",
        transporterName: json["transporter_name"]??"",
        logo: json["logo"]??"",
        suggestion: json["suggestion"],
    );

    Map<String, dynamic> toJson() => {
        "@search.score": searchScore,
        "transporter_id": transporterId,
        "transporter_name": transporterName,
        "logo": logo,
        "suggestion": suggestion,
    };
}
