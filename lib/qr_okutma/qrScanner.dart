

/*import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genclikduragiqr/dene.dart';
import 'package:genclikduragiqr/popUp.dart';
import 'package:genclikduragiqr/sabitler/const.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

bool validity = true;

class QrScanner extends StatefulWidget {
  const QrScanner({Key? key}) : super(key: key);

  @override
  State<QrScanner> createState() => _QrScannerState();
}

class _QrScannerState extends State<QrScanner> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child:
            QRViewExample()); /*Scaffold(
        body: Scaffold(
      appBar: AppBar(title: const Text('Flutter Demo Home Page')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const QRViewExample(),
            ));
          },
          child: const Text('qrView'),
        ),
      ),
    ));*/
  }
}

class QRViewExample extends StatefulWidget {
  const QRViewExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

Barcode? result;

class _QRViewExampleState extends State<QRViewExample> {
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    Widget scannedWidget() {
      //result.cpde
      bool onay = false;

      return Container(
        color: black,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                    icon: Icon(
                      FontAwesomeIcons.xmark,
                      size: 36,
                      color: white,
                    ),
                    onPressed: () {
                      setState(() {
                        result = null;
                      });
                    }),
              ),
              SizedBox(
                height: 100,
              ),
              onay
                  ? Icon(
                      FontAwesomeIcons.circleCheck,
                      color: blue,
                      size: 150,
                    )
                  : Icon(
                      FontAwesomeIcons.circleXmark,
                      color: red,
                      size: 150,
                    ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Bilet",
                style:
                    TextStyle(color: white, fontSize: 40, fontFamily: "bold"),
              ),
              Text(
                onay ? "Geçerli" : "Geçersiz",
                style: TextStyle(
                    fontFamily: "bold", color: onay ? blue : red, fontSize: 40),
              ),
              SizedBox(
                height: 40,
              ),
              Divider(
                thickness: 3,
                color: grey,
                endIndent: 40,
                indent: 40,
              ),
              SizedBox(
                height: 20,
              ),
              onay
                  ? Text(
                      "Bilet tek seferliğine onaylanmıştır.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: "bold", color: white, fontSize: 20),
                    )
                  : Text(
                      "Bilet tek seferliğine onaylanamamıştır.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: "bold", color: white, fontSize: 20),
                    ),
              SizedBox(
                height: 20,
              ),
              onay
                  ? Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 40),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Detaylar:",
                              style: TextStyle(
                                fontFamily: "normal",
                                color: grey,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 40),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Bilet sahibi:",
                              style: TextStyle(
                                fontFamily: "normal",
                                color: grey,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Column()
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: result != null
          ? AppBar(
              backgroundColor: black,
              title: Text(
                "Qr Okuyucu",
                style: TextStyle(fontFamily: "bold", color: white),
              ),
              centerTitle: true,
              actions: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(FontAwesomeIcons.arrowRightFromBracket,
                        color: grey))
              ],
            )
          : null,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
          Positioned(
            top: 40,
            left: 20,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  (result != null)
                      ? Text(
                          'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}',
                          style: TextStyle(color: Colors.white),
                        )
                      : const Text(
                          'Scan a code',
                          style: TextStyle(color: Colors.white),
                        ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: TextButton(
                            onPressed: () async {
                              await controller?.toggleFlash();
                              setState(() {});
                            },
                            child: FutureBuilder(
                              future: controller?.getFlashStatus(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return snapshot.data!
                                      ? Icon(FontAwesomeIcons.bolt)
                                      : Icon(
                                          FontAwesomeIcons.bolt,
                                          color: white,
                                        );
                                } else {
                                  return Text("Loading");
                                }
                              },
                            )),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: TextButton(
                            onPressed: () async {
                              await controller?.flipCamera();
                              setState(() {});
                            },
                            child: FutureBuilder(
                              future: controller?.getCameraInfo(),
                              builder: (context, snapshot) {
                                if (snapshot.data != null) {
                                  return Icon(
                                    FontAwesomeIcons.cameraRotate,
                                    color: white,
                                  );
                                } else {
                                  return const Text('loading');
                                }
                              },
                            )),
                      )
                    ],
                  ),
                  /*  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                          onPressed: () async {
                            await controller?.pauseCamera();
                          },
                          child: const Text('pause',
                              style: TextStyle(fontSize: 20)),
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            //showMyDialog(context, validity);
                            print(result!.format);
                            readDataFromCode();
                          },
                          child: Text("Dene")),
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                          onPressed: () async {
                            await controller?.resumeCamera();
                          },
                          child: const Text('resume',
                              style: TextStyle(fontSize: 20)),
                        ),
                      )
                    ],
                  ),*/
                ],
              ),
            ),
          ),
          /*
          //////////////////
          //////////////////
          //////////////////
          //////////////////
          //////////////////
          */
          result != null ? scannedWidget() : SizedBox()
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: white,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    if (Platform.isAndroid) {
      controller.pauseCamera();
    }
    controller.resumeCamera();

    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Kameraya İzin Veriniz')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  readDataFromCode() async {
    if (result != null) {
      showMyDialog(context, true);
    }
  }
}
*/