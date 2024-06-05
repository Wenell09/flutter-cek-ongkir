// ignore_for_file: non_constant_identifier_names
class ProvinceModel {
  String province_id, province;

  ProvinceModel({required this.province_id, required this.province});

  factory ProvinceModel.fromJson(Map<String, dynamic> json) {
    return ProvinceModel(
      province_id: json["province_id"] ?? "",
      province: json["province"] ?? "",
    );
  }
}
