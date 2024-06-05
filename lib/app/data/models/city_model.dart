// ignore_for_file: non_constant_identifier_names

class CityModel {
  String city_id, province_id, province, type, city_name, postal_code;

  CityModel({
    required this.city_id,
    required this.province_id,
    required this.province,
    required this.type,
    required this.city_name,
    required this.postal_code,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      city_id: json["city_id"],
      province_id: json["province_id"],
      province: json["province"],
      type: json["type"],
      city_name: json["city_name"],
      postal_code: json["postal_code"],
    );
  }
}
