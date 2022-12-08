import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genclikduragiqr/dene.dart';
import 'package:genclikduragiqr/pop_up/bilgi.dart';
import 'package:genclikduragiqr/sabitler/const.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

TextEditingController _mailController = TextEditingController();
TextEditingController _passController = TextEditingController();
bool _visibility = false;

class Giris extends StatefulWidget {
  const Giris({super.key});

  @override
  State<Giris> createState() => _GirisState();
}

class _GirisState extends State<Giris> {
  @override
  void dispose() {
    super.dispose();
    _mailController.clear();
    _passController.clear();
    _visibility = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey,
      appBar: AppBar(
        title: SizedBox(height: 50, child: Image.asset("assets/logo.png")),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: SizedBox(),
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Hoşgeldin!",
                  textAlign: TextAlign.left,
                  style:
                      TextStyle(fontFamily: "bold", fontSize: 28, color: blue),
                )),
            SizedBox(
              height: 20,
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Giriş Yap",
                  textAlign: TextAlign.left,
                  style:
                      TextStyle(fontFamily: "bold", fontSize: 18, color: black),
                )),
            Expanded(
              flex: 1,
              child: SizedBox(),
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              controller: _mailController,
              decoration: InputDecoration(
                  prefixIcon: Icon(FontAwesomeIcons.solidUser),
                  label: Text(
                    "Kullanıcı Adı",
                    style: TextStyle(fontFamily: "bold"),
                  )),
            ),
            SizedBox(
              height: 40,
            ),
            TextField(
              controller: _passController,
              obscureText: !_visibility,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: _visibility
                        ? Icon(
                            FontAwesomeIcons.solidEyeSlash,
                            color: blue,
                          )
                        : Icon(
                            FontAwesomeIcons.solidEye,
                          ),
                    onPressed: () {
                      setState(() {
                        _visibility = !_visibility;
                      });
                    },
                  ),
                  label: Text("Şifre"),
                  prefixIcon: Icon(FontAwesomeIcons.key)),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                child: Text("Şifreni mi unuttun?"),
                onPressed: () {
                  _sifremiUnuttum(context);
                },
              ),
            ),
            Spacer(
              flex: 1,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_mailController.text != "" &&
                      _passController.text != "") {
                    print("object");
                    _logIn(_mailController.text, _passController.text);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Kullanıcı adı veya şifre eksik")));
                    /*showDialog<void>(
                      context: context,
                      barrierDismissible: true, // user must tap button!
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Icon(
                            FontAwesomeIcons.circleXmark,
                            color: red,
                            size: 32,
                          ),
                          content: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Mail veya Şifre Eksik",
                                style:
                                    TextStyle(fontFamily: "bold", color: red),
                              ),
                              SizedBox(
                                height: 10,
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
                                  "Tamam",
                                  style:
                                      TextStyle(color: red, fontFamily: "bold"),
                                ))
                          ],
                        );
                      },
                    );*/
                  }
                },
                child: Text('Giriş Yap'),
              ),
            ),
            Spacer(
              flex: 3,
            ),
            Text(
              "(C) 2022 Gençlik Durağı Eğitim Danışmanlık ve Organizasyon Hizmetleri Sanayi Ticaret Limited Şirketi",
              style: TextStyle(
                fontFamily: "normal",
                color: black,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  void _logIn(String kullaniciAd, String sifre) async {
    try {
      Dio dio = Dio();
      Response response = await dio.get(
          "http://gncapi.genclikduragi.com/UserRequest/GetUser/${kullaniciAd}_$sifre");
      if (response.data) {
        await SessionManager().set("token", kullaniciAd);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => Dene(
                      kullaniciId: kullaniciAd,
                    )));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Hatalı Giriş")));
      }

      /* Response response = await dio.get(
          "http://gncapi.genclikduragi.com/api/UserRequest/GetUser?username=$kullaniciAd&&password=$sifre");
      print(response);*/
    } catch (e) {
      print(e);
    }

    /*var response;
  await http
      .get(Uri.parse(
          "http://gncapi.genclikduragi.com/api/UserRequest/GetUser?username=$kullaniciAd&&password=$sifre"))
      .then((value) => response = value);
  print(response);*/
  }
}

void _sifremiUnuttum(BuildContext context) {
  showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return BilgiPopUp(
          baslik: "Şifremi unuttum",
          aciklama:
              "Kullanıcı adı ve şifre bilgileri size Gençlik Durağı tarafından gönderilen bilgilerdir.");
    },
  );
}

fetchData(String kullaniciAd, String sifre) async {
  bool dogrulukDeger = true;
  String uri =
      "http://gncapi.genclikduragi.com/UserRequest/GetUser/${kullaniciAd}_$sifre";

  http.Response response = await http.get(Uri.parse(uri));
  print(response);
  if (response.statusCode == 200) {
    try {
      return Dogruluk.fromJson(jsonDecode(response.body));
    } catch (e) {
      return Dogruluk(dogruluk: dogrulukDeger);
    }
  } else {
    return Dogruluk(dogruluk: dogrulukDeger);
  }
}

class Dogruluk {
  final bool dogruluk;

  Dogruluk({required this.dogruluk});
  factory Dogruluk.fromJson(bool json) {
    return Dogruluk(dogruluk: json);
  }
}
