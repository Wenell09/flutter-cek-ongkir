import 'package:flutter_cek_ongkir/app/modules/home/views/widgets/provinsi.dart';
import 'package:flutter_cek_ongkir/app/modules/home/views/widgets/kota.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_cek_ongkir/app/routes/app_pages.dart';
import '../controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cek Ongkir Indonesia'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          const SizedBox(
            height: 35,
          ),
          Provinsi(
            controller: controller,
            type: "Asal",
          ),
          Obx(
            () => (controller.hiddenCityFrom.value)
                ? Container()
                : Kota(
                    controller: controller,
                    provinceID: controller.provinceFromId.toString(),
                    type: "Asal",
                  ),
          ),
          Provinsi(
            controller: controller,
            type: "Tujuan",
          ),
          Obx(
            () => (controller.hiddenCityTo.value)
                ? Container()
                : Kota(
                    controller: controller,
                    provinceID: controller.provinceToId.toString(),
                    type: "Tujuan",
                  ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: controller.inputBerat,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Berat Barang"),
                      hintText: "Masukkan Berat Barang",
                    ),
                    onChanged: (value) {
                      controller.convertTotalToGram(value);
                      debugPrint("hasil : ${controller.berat}");
                      controller.validasi();
                    },
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                Expanded(
                  flex: 1,
                  child: DropdownSearch(
                    items: const [
                      "gram",
                      "kg",
                      "mg",
                      "ons",
                      "dg",
                      "cg",
                      "pon",
                      "kuintal",
                      "ton",
                      "kati"
                    ],
                    selectedItem: "gram",
                    onChanged: (value) {
                      controller.convertGram(value.toString());
                      debugPrint("hasil convert : ${controller.berat}");
                      controller.validasi();
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: DropdownSearch(
              dropdownDecoratorProps: const DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  hintText: "Masukkan Tipe Kurir",
                  labelText: "Tipe Kurir",
                  border: OutlineInputBorder(),
                ),
              ),
              clearButtonProps: const ClearButtonProps(
                isVisible: true,
                icon: Icon(
                  Icons.close,
                  color: Colors.black,
                ),
              ),
              items: const [
                {
                  "code": "jne",
                  "name": "Jalur Nugraha Ekakurir (JNE)",
                },
                {
                  "code": "pos",
                  "name": "Perusahaan Opsional Surat (POS)",
                },
                {
                  "code": "tiki",
                  "name": "Titipan Kilat (TIKI)",
                }
              ],
              itemAsString: (item) => "${item["name"]}",
              onChanged: (value) {
                if (value != null) {
                  controller.kurirCode.value = value["code"].toString();
                } else {
                  controller.kurirCode.value = "";
                }
                controller.validasi();
              },
            ),
          ),
          Obx(() => (controller.hiddenButtonCheck.value)
              ? Container()
              : InkWell(
                  onTap: () {
                    controller.kirimCekOngkir();
                    Navigator.of(context).pushNamed(Routes.HASIL);
                  },
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 55,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        border: Border.all(color: Colors.black),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 4,
                            offset: Offset(0, 4),
                            spreadRadius: 0,
                          )
                        ]),
                    child: const Center(
                      child: Text(
                        "CEK ONGKOS KIRIM",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                )),
        ],
      ),
    );
  }
}
