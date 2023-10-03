import 'dart:io';
import 'package:ark_inventory/homepage.dart';
import 'package:flutter/material.dart';
import 'package:ark_inventory/notused/search.dart';
import 'package:ark_inventory/homepage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class qrimage extends StatelessWidget {
  qrimage(this.controller, {super.key});
  final TextEditingController controller;
  final ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(title: const Text('QR Code of the Item'),centerTitle: true,
         leading: IconButton(onPressed: () {
           Navigator.push(context, MaterialPageRoute(builder: (c)=>
           homepage()));
           },
             icon: Icon(Icons.arrow_back)),
         actions: [
           IconButton(onPressed: (){shareQrCode();},
               icon: Icon(Icons.share))
         ],
       ),
      body:Column(
        children: [
          SizedBox(height: 30,),
          Screenshot(
              controller: screenshotController,
           child:QrImageView(
            data: controller.text.trim(),
            version: QrVersions.auto,
            size: MediaQuery.of(context).size.width * 0.90,
            gapless: false,
          ),
          ),
           SizedBox(height: 50,width: 100,),
           //FloatingActionButton( child:Row( children:[Text("Share"),Icon(Icons.share), ] ),onPressed: () { shareQrCode(); },),

        ],
      )
    );
  }

  shareQrCode() async {
    final directory = (await getApplicationDocumentsDirectory()).path;
    screenshotController.capture().then((image) async {
      if (image != null) {
        try {
          String fileName = DateTime.now().microsecondsSinceEpoch.toString();
          final imagePath = await File('$directory/$fileName.png').create();
          if (imagePath != null) {
            await imagePath.writeAsBytes(image);
            Share.shareFiles([imagePath.path]);
          }
        } catch (error) {}
      }
    }).catchError((onError) {
      print('Error --->> $onError');
    });
  }
}


/*
screenshotController
    .captureFromWidget(
InheritedTheme.captureAll(
context, Material(child: container)),
delay: Duration(seconds: 1))
    .then((capturedImage) {

// showing the captured invisible widgets
ShowCapturedWidget(context, capturedImage);
});
},
),



// function to show captured widget
  Future<dynamic> ShowCapturedWidget(
      BuildContext context, Uint8List capturedImage) {
    return showDialog(
      useSafeArea: false,
      context: context,
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: Text("Captured widget screenshot"),
        ),
        body: Center(
            child: capturedImage != null
                ? Image.memory(capturedImage)
                : Container()),
      ),
    );
  }
}
*/