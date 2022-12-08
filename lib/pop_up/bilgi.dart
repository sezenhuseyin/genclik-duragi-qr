import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genclikduragiqr/sabitler/const.dart';

class BilgiPopUp extends StatelessWidget {
  String baslik;
  String aciklama;
  BilgiPopUp({Key? key, required this.baslik, required this.aciklama})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: grey,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: Icon(
        FontAwesomeIcons.circleQuestion,
        color: blue,
        size: 28,
      ),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            baslik,
            style: TextStyle(fontFamily: "bold", fontSize: 22, color: blue),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            aciklama,
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: "normal", color: black, fontSize: 18),
          ),
        ],
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "Anladım",
              style: TextStyle(fontFamily: "bold", color: blue),
            ))
      ],
    );
  }
}
