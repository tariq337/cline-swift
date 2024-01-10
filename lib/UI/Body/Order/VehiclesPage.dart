import 'package:client_swift/Controll/OrderControll.dart';
import 'package:client_swift/Unit/classColors.dart';
import 'package:client_swift/Unit/const.dart';
import 'package:client_swift/Unit/responsive.dart';
import 'package:client_swift/Widgets/ImageWidget.dart';
import 'package:client_swift/Widgets/LoadeingWidget.dart';
import 'package:client_swift/Widgets/TextUnit.dart';
import 'package:client_swift/models/VehiclesModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VehiclesPage extends StatefulWidget {
  const VehiclesPage({super.key});

  @override
  State<VehiclesPage> createState() => _VehiclesPageState();
}

class _VehiclesPageState extends State<VehiclesPage> {
  OrderControll controll = Get.find<OrderControll>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 5,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
                onPressed: () {
                  pageOrderController.animateToPage(0,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeIn);
                },
                icon: const Icon(Icons.clear)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Obx(() {
              return LoadeingWidget(
                error: controll.errorMsg.value,
                isLoadeing: controll.isloading.value,
                reloade: () {
                  pageOrderController.animateToPage(0,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeIn);
                },
                child: Responsive(
                  mobile: VehiclesCardGridView(
                    onTap: (index) {
                      controll.setVehiclesId(
                          controll.vehiclesModel.value.vehicles![index].id!,
                          controll.vehiclesModel.value.id!);
                      pageOrderController.animateToPage(3,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn);
                    },
                    vehiclesModel: controll.vehiclesModel.value,
                    crossAxisCount:
                        MediaQuery.of(context).size.width < 650 ? 2 : 3,
                    childAspectRatio: MediaQuery.of(context).size.width < 650 &&
                            MediaQuery.of(context).size.width > 350
                        ? .8
                        : 1,
                  ),
                  tablet: VehiclesCardGridView(
                      onTap: (index) {
                        controll.setVehiclesId(
                            controll.vehiclesModel.value.vehicles![index].id!,
                            controll.vehiclesModel.value.id!);
                        pageOrderController.animateToPage(3,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn);
                      },
                      vehiclesModel: controll.vehiclesModel.value),
                  desktop: VehiclesCardGridView(
                    onTap: (index) {
                      controll.setVehiclesId(
                          controll.vehiclesModel.value.vehicles![index].id!,
                          controll.vehiclesModel.value.id!);
                      pageOrderController.animateToPage(3,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn);
                    },
                    vehiclesModel: controll.vehiclesModel.value,
                    childAspectRatio:
                        MediaQuery.of(context).size.width < 1400 ? 1.1 : 1.4,
                  ),
                ),
              );
            }),
          ),
          const SizedBox(
            height: 10,
          ),
          if (Responsive.isMobile(context))
            const SizedBox(
              height: 150,
            )
        ],
      ),
    );
  }
}

class VehiclesCardGridView extends StatelessWidget {
  VehiclesCardGridView(
      {Key? key,
      required this.onTap,
      this.crossAxisCount = 4,
      this.childAspectRatio = 1,
      required this.vehiclesModel})
      : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;
  VehiclesModel vehiclesModel;
  Function(int index) onTap;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: (vehiclesModel.vehicles ?? []).length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: childAspectRatio,
        ),
        itemBuilder: (context, index) => InkWell(
              onTap: () {
                onTap(index);
              },
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: classColors.NEUTRAL(modeControll.ThemeModeValue)[4],
                    borderRadius: BorderRadius.circular(7)),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ImageWidget(
                        image: vehiclesModel.vehicles![index].imageUrl!,
                        height: 70,
                        width: 70,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextUnit.TextsubTitel(
                          text:
                              "${vehiclesModel.vehicles![index].price!.toStringAsFixed(2)} AED"),
                      const SizedBox(
                        height: 5,
                      ),
                      TextUnit.Textsub(
                          text:
                              (vehiclesModel.vehicles![index].area).toString()),
                      const SizedBox(
                        height: 5,
                      ),
                      TextUnit.TextTitel(
                          text: vehiclesModel.vehicles![index].name!),
                    ]),
              ),
            ));
  }
}
