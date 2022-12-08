import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genclikduragiqr/sabitler/const.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class BasarisizPopUp extends StatelessWidget {
  MobileScannerController? controller;

  String baslik;
  String aciklama;
  BasarisizPopUp(
      {Key? key,
      required this.baslik,
      required this.aciklama,
      MobileScannerController? this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: grey,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: Icon(
        FontAwesomeIcons.circleXmark,
        color: red,
        size: 28,
      ),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            baslik,
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: "bold", fontSize: 22, color: red),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            aciklama,
            style: TextStyle(fontFamily: "normal", color: black),
          ),
        ],
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        TextButton(
            onPressed: () {
              if (controller != null) {
                controller!.start();
              }
              Navigator.pop(context);
            },
            child: Text(
              "Tamam",
              style: TextStyle(fontFamily: "bold", color: red),
            ))
      ],
    );
  }
}
