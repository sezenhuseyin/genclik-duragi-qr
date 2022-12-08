import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genclikduragiqr/giris_ekranlari/giris.dart';
import 'package:genclikduragiqr/sabitler/const.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';

class Cikis extends StatelessWidget {
  const Cikis({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      backgroundColor: grey,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: Icon(
        FontAwesomeIcons.solidCircleXmark,
        color: red,
        size: 40,
      ),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Çıkış yapmak istediğinize emin misiniz?",
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: "bold", fontSize: 22, color: black),
          ),
        ],
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        TextButton(
            onPressed: () async {
              await SessionManager().destroy();
              Navigator.pop(context);
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Giris()));
            },
            child: Text(
              "Evet",
              style: TextStyle(fontSize: 18, fontFamily: "bold", color: black),
            )),
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "Hayır",
              style: TextStyle(fontSize: 18, fontFamily: "bold", color: red),
            ))
      ],
    );
  }
}
