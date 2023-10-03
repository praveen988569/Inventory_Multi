import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';


class checkavailabity extends StatefulWidget {
  @override
  _checkavailabityState createState() => _checkavailabityState();
}

class _checkavailabityState extends State<checkavailabity> {
  final TextEditingController searchController = TextEditingController();
  QRViewController? controller;
  String? result;
  bool isFlashOn = false;

  @override
  void initState() {
    super.initState();
    isFlashOn = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Scanner & Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search...',
                suffixIcon: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.camera),
                      onPressed: () async {

                        /*
                          File file = await ImagePicker().pickImage(source: ImageSource.camera).then((picked) {
                            if (picked == null) return null;
                            return File(picked.path);
                          });
                          if (file == null) return;
                          Uint8List bytes = file.readAsBytesSync();
                          String barcode = await scanner.scanBytes(bytes);
                          this._outputController.text = barcode;
                      */

                      //async {final scannedResult = await Navigator.push(context,MaterialPageRoute(builder: (context) => QRScannerScreen(),),                   );
                        //if (scannedResult != null) {setState(() {result = scannedResult;searchController.text = result!;});
                        }
                    ),

                    IconButton(
                        icon: Icon(Icons.upload),
                        onPressed: () {
                          //async {final scannedResult = await Navigator.push(context,MaterialPageRoute(builder: (context) => QRScannerScreen(),),                   );

                          //if (scannedResult != null) {setState(() {result = scannedResult;searchController.text = result!;});
                        }
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


/*
class QRScannerScreen extends StatefulWidget {
  @override
  _QRScannerScreenState createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Scanner'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: Colors.red,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: 300,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  result != null && result!.isNotEmpty
                      ? Icons.flash_off
                      : Icons.flash_on,
                  color: Colors.white,
                ),
                onPressed: () {
                  if (result != null && result!.isNotEmpty) {
                    setState(() {
                      result = null;
                    });
                  } else {
                    controller!.toggleFlash();
                  }
                },
              ),
            ],
          ),
          if (result != null && result!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(labelText: 'Scanned QR Code'),
                controller: TextEditingController(text: result),
                readOnly: true,
              ),
            ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });

    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData.code;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }


}

 */
