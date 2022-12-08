import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:genclikduragiqr/dene.dart';
import 'package:genclikduragiqr/giris_ekranlari/giris.dart';
import 'package:genclikduragiqr/sabitler/const.dart';

dynamic token = '';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(QrScannerApp());
}

class QrScannerApp extends StatefulWidget {
  @override
  State<QrScannerApp> createState() => _QrScannerAppState();
}

class _QrScannerAppState extends State<QrScannerApp> {
  @override
  Widget build(BuildContext context) {
    
    token = SessionManager().get('token');

    return MaterialApp(
        theme: ThemeData(
            drawerTheme: const DrawerThemeData(),
            inputDecorationTheme: InputDecorationTheme(
              focusColor: white,
              border: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(36),
                  borderSide: BorderSide.none),
              focusedBorder: InputBorder.none,
              fillColor: white,
              filled: true,
              labelStyle: TextStyle(
                fontFamily: "bold",
              ),
            ),
            backgroundColor: grey,
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
              elevation: 10,
              backgroundColor: blue,
              shadowColor: blue.withOpacity(1),
              textStyle:
                  TextStyle(fontSize: 18, fontFamily: "normal", color: white),
              minimumSize: Size(300, 60),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)),
            )),
            /*bottomSheetTheme:
                BottomSheetThemeData(constraints: BoxConstraints.expand()),*/
            fontFamily: "normal",
            primaryColor: black,
            scaffoldBackgroundColor: grey,
            appBarTheme: AppBarTheme(
                iconTheme: IconThemeData(color: black),
                titleTextStyle:
                    TextStyle(fontFamily: "bold", color: black, fontSize: 22),
                color: Colors.transparent,
                elevation: 0,
                foregroundColor: black,
                centerTitle: true)),
        debugShowCheckedModeBanner: false,
        home: FutureBuilder(
            future: SessionManager().get('token'),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Dene(kullaniciId:snapshot.data,);
              } else {
                return Giris();
              }
            })); //Dene//Giris());
  }
}
/*QrPopUp(
          controller: MobileScannerController(),
          aciklama: "a",
          baslik: "b",
        )*/
