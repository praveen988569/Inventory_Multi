import 'dart:io';

import 'package:ark_inventory/homepage.dart';
import 'package:ark_inventory/inventory_display/inventory_display.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class update_existingitems extends StatefulWidget {


  final String product_name;
  final String product_qty;
  final String store_location;
  final String photoUrl;
  final String equipment_name;
  final String product_uid;
  final String store_address;
  final String vendor_address;
  final String vendor_name;

  update_existingitems({
    required this.product_name,
    required this.product_qty,
    required this.store_location,
    required this.photoUrl,
    required this.equipment_name,
    required this.product_uid,
    required this.store_address,
    required this.vendor_address,
    required this.vendor_name,

  });


  @override
  State<update_existingitems> createState() => _update_existingitemsState();
   }

class _update_existingitemsState extends State<update_existingitems> {
  TextEditingController product_uidu = TextEditingController();
  TextEditingController product_nameu = TextEditingController();
  TextEditingController equipment_nameu = TextEditingController();
  TextEditingController vendor_nameu = TextEditingController();
  TextEditingController vendor_addressu = TextEditingController();
  TextEditingController store_addressu = TextEditingController();
  TextEditingController product_qtyu = TextEditingController();
  TextEditingController store_locationu = TextEditingController();
  TextEditingController detailsaboutchanges = TextEditingController();

  String downloadUrlImage = "";
  final FirebaseFirestore firestore = FirebaseFirestore.instance;



  void initState() {
    product_uidu.text= widget.product_uid;
    product_nameu.text=widget.product_name;
    equipment_nameu.text=widget.equipment_name;
    vendor_nameu.text=widget.vendor_name;
    vendor_addressu.text=widget.vendor_address;
    store_addressu.text=widget.store_address;
    product_qtyu.text=widget.product_qty;
    store_locationu.text=widget.store_location;
  }

  Savechanges() async
  {
    String producid = product_uidu.text;
    String fileName = DateTime.now().toString();

    //save to firestore
    FirebaseFirestore.instance
        .collection("Changes")
        .doc(producid)
        .set(
        {
          //"uid": currentUser.uid,
          "product_uid": producid,
          "date_time": fileName,
          "change_details": detailsaboutchanges.text.trim(),
        });
  }

  void updatefb() async {
    String producid = product_uidu.text;
    String vendor_address = vendor_addressu.text;
    String vendor_name = vendor_nameu.text;
    String store_address = store_addressu.text;
    String store_location = store_locationu.text;
    String product_qty = product_qtyu.text;

      final Map<String, dynamic> updatedData = {
        'vendor_address': vendor_address,
        'vendor_name': vendor_name,
        'store_address': store_address,
        'store_location': store_location,
        'product_qty': product_qty,
      };
      // Update the document in Firestore
      await FirebaseFirestore.instance
          .collection('Product')
          .doc(producid)
          .update(updatedData);
    Savechanges();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Product data updated successfully.'),
        ),
      );
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0XF5E3EAFF),
        body: SafeArea(child: Column(
          children: [
            //Expanded(flex:2, child: Center()),
            Expanded(flex: 7, child:
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(50),
                    topRight: Radius.circular(50)),
                color: Colors.white,
              ),
              child: ListView(
                children: <Widget>[
                  const SizedBox(height: 10,),
                  const Center(child: Text("Update Inventory",
                    style: TextStyle(fontSize: 20, color: Colors.black),)),
                  //SizedBox(height: 50,),
                  //get-capture image
                  GestureDetector(
                    onTap: () {
                      //showOptions();
                      //getImageFromGallery();
                    },

                    child: CircleAvatar(
                        radius: MediaQuery
                            .of(context)
                            .size
                            .width * 0.4,
                        backgroundColor: Colors.white,
                        backgroundImage: NetworkImage(widget.photoUrl)
                    ),
                  ),
                  // product_ID
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child:
                    TextFormField(
                      controller: product_uidu,
                      //TextEditingController(text:widget.product_uid),
                      enabled: false,
                      decoration: InputDecoration(labelText: "Product ID",
                        border: OutlineInputBorder(borderRadius: BorderRadius
                            .all(Radius.circular(10.0))),
                        hintText: "Product ID",
                        prefixIcon: Icon(Icons.perm_identity,
                          color: Colors.black12,),
                      ),
                      obscureText: false,
                    ),
                  ),
                  // product_name
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: TextFormField(
                      controller: product_nameu,
                      //TextEditingController(                          text: widget.product_name),
                      enabled: false,
                      decoration: InputDecoration(labelText: "Product Name",
                        border: OutlineInputBorder(borderRadius: BorderRadius
                            .all(Radius.circular(10.0))),
                        hintText: "Product Name",
                        prefixIcon: Icon(Icons.sort_by_alpha,
                          color: Colors.black12,),
                      ),
                      obscureText: false,
                    ),
                  ),
                  // Equipment Name
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: TextFormField(
                      controller: equipment_nameu,
                      //TextEditingController(                          text: widget.equipment_name),
                      enabled: false,
                      decoration: InputDecoration(labelText: "Equipment Name",
                        border: OutlineInputBorder(borderRadius: BorderRadius
                            .all(Radius.circular(10.0))),
                        hintText: "Product Name",
                        prefixIcon: Icon(Icons.account_tree,
                          color: Colors.black12,),
                      ),
                      obscureText: false,
                    ),
                  ),
                  // Vendor Name
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: TextFormField(
                      controller: vendor_nameu,
                      //TextEditingController(                          text: widget.vendor_name),
                      decoration: InputDecoration(labelText: "Vendor Name",
                        border: OutlineInputBorder(borderRadius: BorderRadius
                            .all(Radius.circular(10.0))),
                        hintText: "Vendor Name",
                        prefixIcon: Icon(Icons.person, color: Colors.black12,),
                      ),
                      obscureText: false,
                    ),
                  ),
                  // Vendor Address
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: TextFormField(
                      controller: vendor_addressu,
                      //TextEditingController(                          text: widget.vendor_address),
                      decoration: InputDecoration(labelText: "Vendor Address",
                        border: OutlineInputBorder(borderRadius: BorderRadius
                            .all(Radius.circular(10.0))),
                        hintText: "Vendor Address",
                        prefixIcon: Icon(Icons.add_chart_rounded,
                          color: Colors.black12,),
                      ),
                      obscureText: false,
                    ),
                  ),
                  // Store Address
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: TextFormField(
                      controller: store_addressu,
                      //TextEditingController(                          text: widget.store_address),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(10.0))),
                        hintText: "Store Address",
                        prefixIcon: Icon(Icons.store, color: Colors.black12,),
                      ),
                      obscureText: false,
                    ),
                  ),
                  // Store Location
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: TextFormField(
                      controller: store_locationu,
                      //TextEditingController(                          text: widget.store_location),
                      decoration: InputDecoration(
                        labelText: "Store Location ( Country)",
                        border: OutlineInputBorder(borderRadius: BorderRadius
                            .all(Radius.circular(10.0))),
                        hintText: "Store Location ( Country)",
                        prefixIcon: Icon(Icons.maps_ugc,
                          color: Colors.black12,),
                      ),
                      obscureText: false,
                    ),
                  ),
                  // Quantity
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: TextFormField(
                      controller: product_qtyu,
                      //TextEditingController(                          text: widget.product_qty),
                      decoration: InputDecoration(labelText: "Quantity",
                        border: OutlineInputBorder(borderRadius: BorderRadius
                            .all(Radius.circular(10.0))),
                        hintText: "Quantity",
                        prefixIcon: Icon(Icons.quora_outlined,
                          color: Colors.black12,),
                      ),
                      obscureText: false,
                    ),
                  ),
// Details about Changes
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: TextFormField(
                      controller: detailsaboutchanges,
                      //TextEditingController(                          text: widget.product_qty),
                      decoration: InputDecoration(labelText: "detailsaboutchanges",
                        border: OutlineInputBorder(borderRadius: BorderRadius
                            .all(Radius.circular(10.0))),
                        hintText: "detailsaboutchanges",
                        prefixIcon: Icon(Icons.pending_actions,
                          color: Colors.black12,),
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
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            //fixedSize:Size(50,50),
                            elevation: 2,),
                          onPressed: () {
                            updatefb();
                            Navigator.push(context,MaterialPageRoute(builder: (c) =>
                            //checkavailability()
                            inventory_display()
                            ));
                          },
                          child: Text('Update', style: TextStyle(
                              fontSize: 20, color: Colors.black),),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors
                            .blueAccent,
                          //fixedSize:Size(50,50),
                          elevation: 2,),
                        onPressed: () {
                          Navigator.push(
                              context, MaterialPageRoute(builder: (c) =>
                              homepage()));
                        },
                        child: Text('Back', style: TextStyle(
                            fontSize: 20, color: Colors.black),),
                      ),
                    ],
                  ),
                ],
              ),
            )),
          ],)));
  }
}
