import 'package:flutter_cek_ongkir/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_cek_ongkir/app/data/models/city_model.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class Kota extends StatelessWidget {
  final HomeController controller;
  final String provinceID;
  final String type;

  const Kota({
    super.key,
    required this.controller,
    required this.provinceID,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: DropdownSearch<CityModel>(
        dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            hintText: (type == "Asal")
                ? "Kota/Kabupaten $type"
                : "Kota/Kabupaten $type",
            labelText: (type == "Asal")
                ? "Kota/Kabupaten $type"
                : "Kota/Kabupaten $type",
            border: const OutlineInputBorder(),
          ),
        ),
        clearButtonProps: const ClearButtonProps(
          isVisible: true,
          icon: Icon(
            Icons.close,
            color: Colors.black,
          ),
        ),
        asyncItems: (text) => controller.fetchCity(provinceID),
        itemAsString: (item) => "${item.type} ${item.city_name}",
        onChanged: (value) {
          if (value != null) {
            if (type == "Asal") {
              controller.cityfromId.value = int.parse(value.city_id);
            } else {
              controller.cityToId.value = int.parse(value.city_id);
            }
          } else {
            if (type == "Asal") {
              controller.cityfromId.value = 0;
            } else {
              controller.cityToId.value = 0;
            }
          }
          controller.validasi();
        },
      ),
    );
  }
}
