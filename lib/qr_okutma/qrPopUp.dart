import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:genclikduragiqr/pop_up/basarili.dart';
import 'package:genclikduragiqr/pop_up/basarisiz.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:http/http.dart' as http;

class QrPopUp extends StatelessWidget {
  MobileScannerController controller;
  String kullaniciId;
  String code;
  QrPopUp(
      {super.key,
      required this.controller,
      required this.code,
      required this.kullaniciId});
  var data;
  var okuma;
  @override
  Widget build(BuildContext context) {
    //  data = fetchData(code);
    okuma = fetchOkuma(code, kullaniciId);
    return FutureBuilder<OkumaData>(
        future: okuma,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.ad != "") {
              return BasariliPopUp(
                baslik: snapshot.data!.ad,
                aciklama: snapshot.data!.ad != "Okutuldu"
                    ? snapshot.data!.okul +
                        "\n\n" +
                        snapshot.data!.bolum +
                        "\n\n" +
                        snapshot.data!.durum +
                        "\n\n" +
                        snapshot.data!.hata
                    : snapshot.data!.hata,
                controller: controller,
              );
            } else {
              return BasarisizPopUp(
                baslik: "Bulunamadı",
                aciklama: "Bu katılımcı bulunamadı\n${snapshot.data!.bolum}",
                controller: controller,
              );
            }
          } else
            return Center(
              child: CircularProgressIndicator(),
            );
        });
    /* return FutureBuilder<UserData>(
        future: data,
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.ad != "") {
              return FutureBuilder<OkumaData>(
                  builder: (context, snapshotOkuma) {
                if (snapshotOkuma.hasData) {
                  return BasariliPopUp(
                    baslik: snapshot.data!.ad,
                    aciklama: snapshot.data!.okul +
                        "\n\n" +
                        snapshot.data!.bolum +
                        "\n\n" +
                        snapshotOkuma.data!.durum +
                        "\n\n" +
                        snapshotOkuma.data!.hata,
                    controller: controller,
                  );
                } else
                  return SizedBox();
              });
            } else {
              return BasarisizPopUp(
                baslik: "Bulunamadı",
                aciklama: "Bu katılımcı bulunamadı\n${snapshot.data!.bolum}",
                controller: controller,
              );
            }
          } else {
            return SizedBox(
                height: 40,
                width: 40,
                child: Center(child: CircularProgressIndicator()));
          }
        }));*/
    /* bool value = true;
    return value
        ? BasariliPopUp(
            baslik: code,
            aciklama: code,
            controller: controller,
          )
        : BasarisizPopUp(
            baslik: code,
            aciklama: code,
            controller: controller,
          );*/
  }
}

/*
Future<UserData> fetchData(String code) async {
  final uri = 'http://gncapi.genclikduragi.com/BiletRequest/GetBilet/$code';

  http.Response response = await http.get(Uri.parse(uri));
  print(response);
  if (response.statusCode == 200) {
    try {
      return UserData.fromJson(jsonDecode(response.body));
    } catch (e) {
      return UserData(ad: "", okul: "", bolum: "");
    }
  } else {
    return UserData(ad: "", okul: "İnternet Hatası", bolum: "");
  }
}

class UserData {
  final String ad;
  final String okul;
  final String bolum;
  UserData({required this.ad, required this.okul, required this.bolum});
  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(ad: json['Name'], okul: json['Okul'], bolum: json['Bolum']);
  }
}
*/
Future<OkumaData> fetchOkuma(String code, String kullaniciId) async {
  final uri =
      'http://gncapi.genclikduragi.com/BiletRequest/GetBilet/${code}_$kullaniciId';

  http.Response response = await http.get(Uri.parse(uri));
  print(response);
  if (response.statusCode == 200) {
    try {
      return OkumaData.fromJson(jsonDecode(response.body));
    } catch (e) {
      return OkumaData(
          durum: "", hata: "İnternet Hatası", ad: "", okul: "", bolum: "");
    }
  } else {
    return OkumaData(
        durum: "", hata: "İnternet Hatası", ad: "", bolum: "", okul: "");
  }
}

class OkumaData {
  final String ad;
  final String okul;
  final String bolum;
  final String durum;
  final String hata;

  OkumaData(
      {required this.durum,
      required this.hata,
      required this.okul,
      required this.bolum,
      required this.ad});
  factory OkumaData.fromJson(Map<String, dynamic> json) {
    return OkumaData(
        durum: json['Durum'],
        hata: json['Hata'],
        okul: json['Okul'],
        bolum: json['Bolum'],
        ad: json['Name']);
  }
}
