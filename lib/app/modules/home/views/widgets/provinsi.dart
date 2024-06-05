import 'package:flutter_cek_ongkir/app/data/models/province_model.dart';
import 'package:flutter_cek_ongkir/app/modules/home/controllers/home_controller.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class Provinsi extends StatelessWidget {
  final HomeController controller;
  final String type;
  const Provinsi({
    super.key,
    required this.controller,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: DropdownSearch<ProvinceModel>(
        dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            hintText: (type == "Asal")
                ? "Masukkan Provinsi $type"
                : "Masukkan Provinsi $type",
            labelText: (type == "Asal") ? "Provinsi $type" : "Provinsi $type",
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
        asyncItems: (text) => controller.fetchProvince(),
        itemAsString: (item) => item.province,
        onChanged: (value) {
          if (value != null) {
            if (type == "Asal") {
              controller.hiddenCityFrom.value = false;
              controller.provinceFromId.value = int.parse(value.province_id);
            } else {
              controller.hiddenCityTo.value = false;
              controller.provinceToId.value = int.parse(value.province_id);
            }
          } else {
            if (type == "Asal") {
              controller.hiddenCityFrom.value = true;
              controller.provinceFromId.value = 0;
            } else {
              controller.hiddenCityTo.value = true;
              controller.provinceToId.value = 0;
            }
          }
          controller.validasi();
        },
      ),
    );
  }
}
