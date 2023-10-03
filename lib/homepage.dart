import 'package:ark_inventory/inventory_display/inventory_display.dart';
import 'package:ark_inventory/supporting/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:ark_inventory/newitem/regpage.dart';

class homepage extends StatelessWidget {
  const homepage({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Welcome"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            width: width,
            height: height,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Welcome to Inventory Management ",
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.teal,
                      fontWeight: FontWeight.bold),
                ),

                Image(
                  image: AssetImage('assets/homepage.png'),
                  height: height * 0.5,
                  width: width,
                ),
                //SizedBox(height: 2,),
                Row(
                  children: [
                    SizedBox(width: 15,),
// Add New Item
                    Container(
                      height: height*0.15,
                      width: width*0.3,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.7),
                            spreadRadius: 5,
                            blurRadius: 5,
                            offset: Offset(1, 5), // changes position of shadow
                          ),
                        ],
                        color: Colors.white70,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10.0),
                            bottomRight: Radius.circular(50.0),
                            topLeft: Radius.circular(50.0),
                            bottomLeft: Radius.circular(10.0)
                        ),                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (c) => regpage()));
                        },
                        child: Column(
                          children: [
                            Image(
                              image: AssetImage('assets/addnewitem.png'),
                              //height: height * .15,
                              //width: width * .25,
                            ),
                            Text(
                              "New Product",
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.lightBlue,
                                  fontWeight: FontWeight.bold),
                            ),
                         ],
                        ),
                      ),
                    ),
                  SizedBox(width: 5,),
// Update Quantity
                    Container(
                      height: height*0.15,
                      width: width*0.3,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.7),
                            spreadRadius: 5,
                            blurRadius: 5,
                            offset: Offset(1, 5), // changes position of shadow
                          ),
                        ],
                        color: Colors.white70,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0),
                            topLeft: Radius.circular(10.0),
                            bottomLeft: Radius.circular(10.0)
                        ),                      ),
                      child: GestureDetector(
                        onTap: () {
                          //Navigator.push(context,MaterialPageRoute(builder: (c) =>inventory_display()         ));
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('AlertDialog'),
                              content: const Text('Only for Paid Version'),
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
                        },
                        child: Column(
                          children: [
                            Image(
                              image: AssetImage('assets/updates.png'),
                              height: height * .12,
                              width: width * .25,
                            ),
                            Text(
                              "Update",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.lightBlue,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),

                SizedBox(width: 5,),
// See Inventory
                    Container(
                      height: height*0.15,
                      width: width*0.27,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.7),
                            spreadRadius: 5,
                            blurRadius: 5,
                            offset: Offset(1, 5), // changes position of shadow
                          ),
                        ],
                        color: Colors.white70,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(50.0),
                            bottomRight: Radius.circular(10.0),
                            topLeft: Radius.circular(10.0),
                            bottomLeft: Radius.circular(50.0)
                        ),                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context,MaterialPageRoute(builder: (c) =>
                              //checkavailability()
                          inventory_display()
                          ));
                        },
                        child: Column(
                          children: [
                            Image(
                              image: AssetImage('assets/viewinventory.png'),
                              height: height * .12,
                              width: width * .25,
                            ),
                            Text(
                              "Inventory",
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.lightBlue,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),
                    SizedBox(width: 10,),
                  ],
                ),

             SizedBox(height: 20,),

// Analyse Inventory
                Container(
                  height: height*0.15,
                  width: width*0.3,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.7),
                        spreadRadius: 5,
                        blurRadius: 5,
                        offset: Offset(1, 5), // changes position of shadow
                      ),
                    ],
                    color: Colors.white70,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0),
                        topLeft: Radius.circular(10.0),
                        bottomLeft: Radius.circular(10.0)
                    ),                      ),
                  child: GestureDetector(
                    onTap: () {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('AlertDialog'),
                          content: const Text('Only for Paid Version'),
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
                      // Navigator.push(context,MaterialPageRoute(builder: (c) => regpage()));
                    },
                    child: Column(
                      children: [
                        //SizedBox(height: 10,),

                        Text(
                          "Data Analysis",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.lightBlue,
                              fontWeight: FontWeight.bold),
                        ),


                        Image(
                          image: AssetImage('assets/analysis.png'),
                          height: height * .12,
                          width: width * .25,
                        ),
                      ],
                    ),
                  ),
                ),











              ],
            ),
          ),
        ),
      ),
    );
  }
}
