import 'package:flutter/material.dart';
import 'package:payflow/modules/barcodeScanner/barcodeScanner_controller.dart';
import 'package:payflow/modules/barcodeScanner/barcodeScanner_status.dart';
import 'package:payflow/shared/bottomSheet/bottomSheet_widget.dart';
import 'package:payflow/shared/themes/appTextStyles.dart';
import 'package:payflow/shared/themes/appcolors.dart';
import 'package:payflow/shared/widgets/setLabelButtons/setLabelButtons_widget.dart';

class BarcodeScannerPage extends StatefulWidget {
  BarcodeScannerPage({Key? key}) : super(key: key);

  @override
  _BarcodeScannerPageState createState() => _BarcodeScannerPageState();
}

class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
  final controller = BarcodeScannerController();

  @override
  void initState() {
    controller.getAvailableCameras();
    controller.statusNotifier.addListener(() {
      if (controller.status.hasBarcode) {
        Navigator.pushReplacementNamed(context, "/insertBoleto",
            arguments: controller.status.barcode);
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: true,
      left: true,
      right: true,
      child: Stack(
        children: [
          ValueListenableBuilder<BarcodeScannerStatus>(
              valueListenable: controller.statusNotifier,
              builder: (_, status, __) {
                if (status.showCamera) {
                  return Container(
                    color: Colors.blue,
                    child: controller.cameraController!.buildPreview(),
                  );
                } else {
                  return Container();
                }
              }),
          RotatedBox(
            quarterTurns: 1,
            child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  backgroundColor: Colors.black,
                  centerTitle: true,
                  title: Text(
                    "Escaneie o código de barras do boleto",
                    style: TextStyles.buttonBackground,
                  ),
                  leading: BackButton(
                    color: AppColors.background,
                  ),
                ),
                body: Column(
                  children: [
                    Expanded(
                      child: Container(
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        color: Colors.transparent,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.black.withOpacity(0.5),
                      ),
                    )
                  ],
                ),
                bottomNavigationBar: SetLabelButtons(
                  primaryLabel: "Inserir código do boleto",
                  primaryOnPressed: () {
                    controller.status = BarcodeScannerStatus.error("Error");
                  },
                  secundaryLabel: "Adicionar da galeria",
                  secundaryOnPressed: controller.scanWithImagePicker,
                )),
          ),
          ValueListenableBuilder<BarcodeScannerStatus>(
              valueListenable: controller.statusNotifier,
              builder: (_, status, __) {
                if (status.hasError) {
                  return Align(
                      alignment: Alignment.bottomLeft,
                      child: BottomSheetWidget(
                          primaryLabel: "Escanear novamente",
                          primaryOnPressed: () {
                            controller.scanWithCamera();
                          },
                          secundaryLabel: "Digitar código",
                          secundaryOnPressed: () {},
                          title:
                              "Não foi possível identificar um código de barras.",
                          subtitle:
                              "Tente escanear novamente ou digite o código do seu boleto."));
                } else {
                  return Container();
                }
              }),
        ],
      ),
    );
  }
}
