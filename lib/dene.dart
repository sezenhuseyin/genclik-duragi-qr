import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genclikduragiqr/pop_up/cikis.dart';
import 'package:genclikduragiqr/qr_okutma/qrCustomPaint.dart';
import 'package:genclikduragiqr/qr_okutma/qrPopUp.dart';
import 'package:genclikduragiqr/sabitler/const.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class Dene extends StatefulWidget {
  String kullaniciId;
   Dene({
    super.key,required this.kullaniciId
  });

  @override
  State<Dene> createState() => _DeneState();
}

late MobileScannerController controller;

class _DeneState extends State<Dene> {
  @override
  Widget build(BuildContext context) {
    controller = MobileScannerController();

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Stack(
            children: [
              ScannerWidget(kullaniciId: widget.kullaniciId),
              Center(child: MyWidget()),
              appBarWidget(),
            ],
          ),
        ),
      ),
    );
  }

  appBarWidget() {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        margin: const EdgeInsets.only(top: 16, right: 25, left: 25),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: white, borderRadius: BorderRadius.circular(34)),
        height: 68,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            IconButton(
                onPressed: () {
                  cikisDialog();
                },
                icon: Container(
                  margin: EdgeInsets.only(left: 10),
                  child: const Icon(
                    FontAwesomeIcons.solidCircleXmark,
                    color: red,
                    size: 28,
                  ),
                )),
            Image.asset(
              "assets/logo.png",
              scale: 8,
            ),
            SizedBox(
              width: 56,
            )
          ],
        ),
      ),
    );
  }

  Future<void> cikisDialog() {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Cikis();
      },
    );
  }
}

class ScannerWidget extends StatelessWidget {
  final kullaniciId;
  const ScannerWidget({
    Key? key,required this.kullaniciId
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MobileScanner(
        allowDuplicates: false,
        controller: controller,
        onDetect: ((barcode, args) {
          if (barcode.rawValue == null) {
            debugPrint('Failed to scan Barcode');
          } else {
            controller.stop();
            //barcode.rawValue!
            showDialog<void>(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return QrPopUp(controller: controller, code: barcode.rawValue!,kullaniciId: kullaniciId,);
              },
            );
          }
        }));
  }
}
