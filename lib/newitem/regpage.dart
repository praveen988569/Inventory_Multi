import 'dart:io';
import 'package:ark_inventory/homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:ark_inventory/newitem/generateQRcode.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_storage/firebase_storage.dart' as fStorage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ark_inventory/supporting/loading_dialog.dart';

class regpage extends StatefulWidget {
  const regpage({super.key});
  @override
  State<regpage> createState() => _regpageState();
}
class _regpageState extends State<regpage> {
  TextEditingController product_uid = TextEditingController();
  TextEditingController product_name = TextEditingController();
  TextEditingController equipment_name = TextEditingController();
  TextEditingController vendor_name = TextEditingController();
  TextEditingController vendor_address = TextEditingController();
  TextEditingController store_address = TextEditingController();
  TextEditingController product_qty = TextEditingController();
  TextEditingController store_location = TextEditingController();
  XFile? imgXFile;
  final ImagePicker imagePicker = ImagePicker();
  String downloadUrlImage = "";
  GlobalKey<FormState> formKey = GlobalKey<FormState>();


  //Image Picker function to get image from camera
  Future getImageFromCamera() async {

    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('AlertDialog'),
        content: const Text('Camera is only Paid Version. '
            'You can use Gallery option for free version'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );

   /* final imgXFile = await imagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      imgXFile;

    });*/
  }
// Pick Image from Gallery
  getImageFromGallery() async
  {
    imgXFile = await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      imgXFile;
    });
  }

  //Show options to get image from camera or gallery
  Future showOptions() async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: Text('Photo Gallery'),
            onPressed: () {
              // close the options modal
              Navigator.of(context).pop();
              // get image from gallery
              getImageFromGallery();
            },
          ),
          CupertinoActionSheetAction(
            child: Text('Camera'),
            onPressed: () {
              // close the options modal
              Navigator.of(context).pop();
              // get image from camera
              getImageFromCamera();
            },
          ),
        ],
      ),
    );
  }

  // method Storing Image
  reg() async
  {
    //check email, pass, confirm password & name text fields
    if (imgXFile == null) //image is not selected
        {
      Fluttertoast.showToast(msg: "Please select an image.");
    }
    else //image is already selected
        {
      if (product_uid.text.isNotEmpty
          && product_name.text.isNotEmpty
          && vendor_name.text.isNotEmpty
          && vendor_address.text.isNotEmpty
          && store_address.text.isNotEmpty
          && product_qty.text.isNotEmpty
          && store_location.text.isNotEmpty
          && equipment_name.text.isNotEmpty) {
        showDialog(
            context: context,
            builder: (c) {
              return LoadingDialogWidget(
                message: "Updating the Inventory with Product details",
              );
            }
        );
        //1.upload image to storage
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        fStorage.Reference storageRef = fStorage.FirebaseStorage.instance
            .ref()
            .child("Product").child(fileName);
        fStorage.UploadTask uploadImageTask = storageRef.putFile(File(imgXFile!.path));
        fStorage.TaskSnapshot taskSnapshot = await uploadImageTask.whenComplete(() {});
        await taskSnapshot.ref.getDownloadURL().then((urlImage)
        {
          downloadUrlImage = urlImage;
        });
        saveInfoToFirestoreAndLocally();
        {
          Navigator.pop(context);
          Fluttertoast.showToast(msg:
          "Please complete the form. Do not leave any text field empty.");
        }
      }
    }
  }
// Method to Store Product Details
  saveInfoToFirestoreAndLocally() async
  {
    //save to firestore
   FirebaseFirestore.instance
        .collection("Product")
        .doc(product_uid.text.trim())
        .set(
        {
          //"uid": currentUser.uid,
          "product_uid": product_uid.text.trim(),
          "product_name": product_name.text.trim(),
          "equipment_name": equipment_name.text.trim(),
          "vendor_name": vendor_name.text.trim(),
           "vendor_address": vendor_address.text.trim(),
          "store_address": store_address.text.trim(),
          "product_qty": product_qty.text.trim(),
          "store_location": store_location.text.trim(),
          "photoUrl": downloadUrlImage,

        });
    //save locally
    var sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences!.setString("product_uid", product_uid.text.trim());
    await sharedPreferences!.setString("product_name", product_name.text.trim());
    await sharedPreferences!.setString("equipment_name", equipment_name.text.trim());
    await sharedPreferences!.setString("photoUrl", downloadUrlImage);

    Navigator.push(context,MaterialPageRoute(
        builder: ((context) {
      return qrimage(product_uid);}),
    ),
    );

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0XF5E3EAFF),
        body:SafeArea(child: Column(
          children: [

            //Expanded(flex:2, child: Center()),
            Expanded(flex:7, child:
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(50),topRight: Radius.circular(50)),
                color: Colors.white,
              ),
              child: ListView(
                children: <Widget>[
                  SizedBox(height: 10,),
                  Center(child: Text("New Item Registeration", style: TextStyle(fontSize: 20,color: Colors.black),)),
                  //SizedBox(height: 50,),
                  //get-capture image
                  GestureDetector(
                    onTap: ()
                    {
                      showOptions();
                      //getImageFromGallery();
                    },
                    child: CircleAvatar(
                      radius: MediaQuery.of(context).size.width * 0.20,
                      backgroundColor: Colors.white,
                      backgroundImage: imgXFile == null
                          ? null
                          : FileImage(
                          File(imgXFile!.path)
                      ),
                      child: imgXFile == null
                          ? Icon(
                        Icons.add_photo_alternate,
                        color: Colors.grey,
                        size: MediaQuery.of(context).size.width * 0.20,
                      ) : null,
                    ),
                  ),
                  // product_ID
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: TextFormField(
                      controller: product_uid,
                      decoration: InputDecoration(labelText: "Product ID",
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                        hintText: "Product ID",
                        prefixIcon: Icon(Icons.perm_identity,color: Colors.black12,),
                      ),
                      obscureText: false,
                    ),
                  ),
                  // product_name
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: TextFormField(
                      controller: product_name,
                      decoration: InputDecoration(labelText: "Product Name",
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                        hintText: "Product Name",
                        prefixIcon: Icon(Icons.sort_by_alpha,color: Colors.black12,),
                      ),
                      obscureText: false,
                    ),
                  ),
                  // Equipment Name
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: TextFormField(
                      controller: equipment_name,
                      decoration: InputDecoration(labelText: "Equipment Name",
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                        hintText: "Product Name",
                        prefixIcon: Icon(Icons.account_tree,color: Colors.black12,),
                      ),
                      obscureText: false,
                    ),
                  ),
                  // Vendor Name
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: TextFormField(
                      controller: vendor_name,
                      decoration: InputDecoration(labelText: "Vendor Name",
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                        hintText: "Vendor Name",
                        prefixIcon: Icon(Icons.person,color: Colors.black12,),
                      ),
                      obscureText: false,
                    ),
                  ),
                  // Vendor Address
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: TextFormField(
                      controller: vendor_address,
                      decoration: InputDecoration(labelText: "Vendor Address",
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                        hintText: "Vendor Address",
                        prefixIcon: Icon(Icons.add_chart_rounded,color: Colors.black12,),
                      ),
                      obscureText: false,
                    ),
                  ),
                  // Store Address
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: TextFormField(
                      controller: store_address,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                        hintText: "Store Address",
                        prefixIcon: Icon(Icons.store,color: Colors.black12,),
                      ),
                      obscureText: false,
                    ),
                  ),
                  // Store Location
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: TextFormField(
                      controller: store_location,
                      decoration: InputDecoration(labelText: "Store Location ( Country)",
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                        hintText: "Store Location ( Country)",
                        prefixIcon: Icon(Icons.maps_ugc,color: Colors.black12,),
                      ),
                      obscureText: false,
                    ),
                  ),
                  // Quantity
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: TextFormField(
                      controller: product_qty,
                      decoration: InputDecoration(labelText: "Quantity",
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                        hintText: "Quantity",
                        prefixIcon: Icon(Icons.quora_outlined,color: Colors.black12,),
                      ),
                      obscureText: false,
                    ),
                  ),
                  // sign Button
                  SizedBox(height: 5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent,
                            //fixedSize:Size(50,50),
                          elevation: 2,),
                          onPressed: reg,
                          child: Text('ADD',style: TextStyle(fontSize: 20,color: Colors.black),),
                        ),
                      ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent,
                      //fixedSize:Size(50,50),
                    elevation: 2,),
                    onPressed:(){
                      Navigator.push(context, MaterialPageRoute(builder: (c)=>
                          homepage()));
                    },
                    child: Text('Back',style: TextStyle(fontSize: 20,color: Colors.black),),
                  ),
                    ],
                  ),
                ],
              ),
            )),
          ],)));

  }
}
