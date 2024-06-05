import 'package:flutter/material.dart';
import 'package:flutter_cek_ongkir/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';

class HasilView extends GetView<HomeController> {
  const HasilView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hasil Ongkir'),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Obx(
        () => (controller.isLoadingCheckOngkir.value)
            ? const Center(child: CircularProgressIndicator())
            : (controller.error.value != "")
                ? Center(child: Text(controller.error.value))
                : SingleChildScrollView(
                    physics: const ScrollPhysics(),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        var cost = controller.hasilDataOngkir[index];
                        controller.kurirName.value = cost.name;
                        return Column(
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              cost.name,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Column(
                              children: cost.costs
                                  .map(
                                    (e) => ListTile(
                                      title: Text(
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        e.description,
                                        style: const TextStyle(
                                          fontSize: 17,
                                        ),
                                      ),
                                      subtitle: Text(
                                        "Rp.${e.cost[index].value}",
                                        style: const TextStyle(
                                          fontSize: 17,
                                        ),
                                      ),
                                      trailing: (cost.code == "pos")
                                          ? Text(
                                              e.cost[index].etd,
                                              style: const TextStyle(
                                                fontSize: 17,
                                              ),
                                            )
                                          : Text(
                                              "${e.cost[index].etd} HARI",
                                              style: const TextStyle(
                                                fontSize: 17,
                                              ),
                                            ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ],
                        );
                      },
                      itemCount: controller.hasilDataOngkir.length,
                    ),
                  ),
      ),
    );
  }
}
