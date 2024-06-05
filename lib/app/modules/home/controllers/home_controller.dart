import 'package:flutter_cek_ongkir/app/data/models/cost_model.dart';
import 'package:flutter_cek_ongkir/app/data/models/province_model.dart';
import 'package:flutter_cek_ongkir/app/data/constant/base_url.dart';
import 'package:flutter_cek_ongkir/app/data/models/city_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';

class HomeController extends GetxController {
  late TextEditingController inputBerat;
  var province = <ProvinceModel>[].obs;
  var isLoadingCheckOngkir = true.obs;
  var hiddenButtonCheck = true.obs;
  var hiddenCityFrom = true.obs;
  var city = <CityModel>[].obs;
  var hasilDataOngkir = <CostModel>[].obs;
  var hiddenCityTo = true.obs;
  var provinceFromId = 0.obs;
  var provinceToId = 0.obs;
  var cityfromId = 0.obs;
  var kurirCode = "".obs;
  var kurirName = "".obs;
  var cityToId = 0.obs;
  var berat = 0.0.obs;
  var error = "".obs;
  var satuan = "gram";

  Future<List<ProvinceModel>> fetchProvince() async {
    try {
      final response = await http.get(Uri.parse("$url/province"), headers: {
        "key": dotenv.env["APIKEY"].toString(),
      });
      if (response.statusCode == 200) {
        final List result = jsonDecode(response.body)["rajaongkir"]["results"];
        province.value = result.map((e) => ProvinceModel.fromJson(e)).toList();
      } else {
        debugPrint("status code : ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("error : $e");
    }
    return province;
  }

  Future<List<CityModel>> fetchCity(String provinceID) async {
    try {
      final response =
          await http.get(Uri.parse("$url/city?province=$provinceID"), headers: {
        "key": dotenv.env["APIKEY"].toString(),
      });
      if (response.statusCode == 200) {
        final List result = jsonDecode(response.body)["rajaongkir"]["results"];
        city.value = result.map((e) => CityModel.fromJson(e)).toList();
      } else {
        debugPrint("Response : ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("error : $e");
    }
    return city;
  }

  Future<List<CostModel>> kirimCekOngkir() async {
    isLoadingCheckOngkir.value = true;
    try {
      if (berat.value > 30000.0) {
        error.value = "Berat Barang melebihi 30000gram,silahkan kurangi";
        isLoadingCheckOngkir.value = false;
      } else {
        final response = await http.post(Uri.parse("$url/cost"), body: {
          "origin": cityfromId.value.toString(),
          "destination": cityToId.value.toString(),
          "weight": berat.value.toString(),
          "courier": kurirCode.value,
        }, headers: {
          "key": dotenv.env["APIKEY"].toString(),
          "content-type": "application/x-www-form-urlencoded",
        });
        final List result = jsonDecode(response.body)["rajaongkir"]["results"];
        hasilDataOngkir.value =
            result.map((e) => CostModel.fromJson(e)).toList();
        isLoadingCheckOngkir.value = false;
        error.value = "";
      }
    } catch (e) {
      debugPrint("Error :$e");
    }
    return hasilDataOngkir;
  }

  void convertGram(String value) {
    berat.value = double.tryParse(inputBerat.text) ?? 0.0;
    satuan = value;
    switch (satuan) {
      case 'gram':
        berat.value;
      case 'kg':
        berat.value = berat.value * 1000;
        break;
      case 'mg':
        berat.value = berat.value / 1000;
        break;
      case 'ons':
        berat.value = berat.value * 100;
        break;
      case 'dg':
        berat.value = berat.value * 0.1;
        break;
      case 'cg':
        berat.value = berat.value * 0.01;
        break;
      case 'pon':
        berat.value = berat.value * 453.592;
        break;
      case 'kuintal':
        berat.value = berat.value * 100000;
        break;
      case 'ton':
        berat.value = berat.value * 1000000;
        break;
      case 'kati':
        berat.value = berat.value * 605;
      default:
        berat.value = berat.value;
    }
  }

  void convertTotalToGram(String value) {
    berat.value = double.tryParse(inputBerat.text) ?? 0.0;
    switch (value) {
      case 'gram':
        berat.value;
      case 'kg':
        berat.value = berat.value * 1000;
        break;
      case 'mg':
        berat.value = berat.value / 1000;
        break;
      case 'ons':
        berat.value = berat.value * 100;
        break;
      case 'dg':
        berat.value = berat.value * 0.1;
        break;
      case 'cg':
        berat.value = berat.value * 0.01;
        break;
      case 'pon':
        berat.value = berat.value * 453.592;
        break;
      case 'kuintal':
        berat.value = berat.value * 100000;
        break;
      case 'ton':
        berat.value = berat.value * 1000000;
        break;
      case 'kati':
        berat.value = berat.value * 605;
      default:
        berat.value = berat.value;
    }
    satuan = value;
  }

  validasi() {
    if (provinceFromId.value != 0 &&
        provinceToId.value != 0 &&
        cityfromId.value != 0 &&
        cityToId.value != 0 &&
        berat.value > 0 &&
        satuan != "" &&
        kurirCode.value != "") {
      hiddenButtonCheck.value = false;
    } else {
      hiddenButtonCheck.value = true;
    }
  }

  @override
  void onInit() {
    inputBerat = TextEditingController(text: "$berat");
    super.onInit();
  }

  @override
  void dispose() {
    inputBerat.dispose();
    super.dispose();
  }
}
