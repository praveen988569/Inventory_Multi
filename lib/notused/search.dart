import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class checkavailability extends StatefulWidget {
  @override
  _checkavailabilityState createState() => _checkavailabilityState();
}

class _checkavailabilityState extends State<checkavailability> {
  void initState() {
    super.initState();
    _fetchData();
    loadCountries();
  }

  final TextEditingController _productUidController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  List<Product> products = [];
  String? selectedCountry; // No need to set an initial value here
  List<String> countries = [];

  @override
  void dispose() {
    _productUidController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  // Collecting all country details from firebase
  Future<void> loadCountries() async {
    final QuerySnapshot vendorSnapshot =
        await FirebaseFirestore.instance.collection('Product').get();

    if (vendorSnapshot.docs.isNotEmpty) {
      final List<String> countryList = vendorSnapshot.docs
          .map((doc) => doc['vendor_address'] as String)
          .toSet()
          .toList();

      setState(() {
        countries = countryList;
      });
    }
  }

  // Collecting all details from firebase
  Future<void> _fetchData() async {
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Product')
        //.where('product_uid', isEqualTo: productId)
        .get();

    final List<Product> fetchedProducts =
        querySnapshot.docs.map((doc) => Product.fromSnapshot(doc)).toList();

    setState(() {
      products = fetchedProducts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Available Product'),
      ),
      body: Column(children: [
        Row(
          children: [
            DropdownButton<String>(
              value: selectedCountry,
              onChanged: (newValue) => setState(() {
                selectedCountry = newValue!;
              }),
              items: countries.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              hint: Text('Select a country'),
            ),
          ],
        ),
        Divider(height: 10,thickness: 2,color: Colors.red,),
        Text("World Wide available Material"),
        Expanded(
          child: GridView.builder(
            scrollDirection: Axis.vertical,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // Number of columns in the grid
              mainAxisSpacing: 5.0, // Vertical spacing between items
              crossAxisSpacing: 5.0, // Horizontal spacing between items
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              // Calculate the image size based on the screen width
              final screenWidth = MediaQuery.of(context).size.width;
              final imageSize =
                  screenWidth * 0.2; // Adjust the factor as needed
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => FullImagePage(
                      product_name: product.product_name,
                      product_qty: product.product_qty,
                      store_location: product.store_location,
                      photoUrl: product.photoUrl,
                      equipment_name: product.equipment_name,
                      product_uid: product.product_uid,
                      store_address: product.store_address,
                      vendor_address: product.vendor_address,
                      vendor_name: product.vendor_name,
                    ),
                  ));
                },
                child: GridTile(
                  child: Container(
                    width: imageSize,
                    // You can set the height to match the width for a square aspect ratio
                    height: imageSize,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(
                          product.photoUrl,
                          width: imageSize,
                          height: imageSize * .8,
                          fit: BoxFit.cover,
                        ),
                        Text(product.product_name),
                        Text('Quantity: ${product.product_qty}'),
                        Text('Store: ${product.store_location}'),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ]),
    );
  }
}

class FullImagePage extends StatelessWidget {
  final String product_name;
  final String product_qty;
  final String store_location;
  final String photoUrl;
  final String equipment_name;
  final String product_uid;
  final String store_address;
  final String vendor_address;
  final String vendor_name;

  FullImagePage({
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details Page'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                photoUrl,
                width: double.infinity, // Adjust the image size as needed
                height: 400,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Product Name:',
                    style: TextStyle(fontSize: 25, color: Colors.black),
                  ),
                  Text('${product_name}',
                      style: TextStyle(fontSize: 25, color: Colors.lightBlue))
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Text('Equipment Name: ${product_qty}',
                  style: TextStyle(fontSize: 25)),
              SizedBox(
                height: 5,
              ),
              Text('Product UID: ${product_uid}',
                  style: TextStyle(fontSize: 25)),
              SizedBox(
                height: 5,
              ),
              Text('Store Address: ${store_address}',
                  style: TextStyle(fontSize: 25)),
              SizedBox(
                height: 5,
              ),
              Text('Vendor Address: ${vendor_address}',
                  style: TextStyle(fontSize: 25)),
              SizedBox(
                height: 5,
              ),
              Text('Vendor Name: ${vendor_name}',
                  style: TextStyle(fontSize: 25)),
              SizedBox(
                height: 5,
              ),
              Text('Product Quantity: ${product_qty}',
                  style: TextStyle(fontSize: 25)),
              SizedBox(
                height: 5,
              ),
              Text('Store Location: ${store_location}',
                  style: TextStyle(fontSize: 25)),
            ],
          ),
        ),
      ),
    );
  }
}

class Product {
  final String product_name;
  final String product_qty;
  final String store_location;
  final String photoUrl;
  final String equipment_name;
  final String product_uid;
  final String store_address;
  final String vendor_address;
  final String vendor_name;

  Product({
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

  factory Product.fromSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Product(
      product_name: data['product_name'],
      product_qty: data['product_qty'],
      store_location: data['store_location'],
      photoUrl: data['photoUrl'],
      equipment_name: data['equipment_name'],
      product_uid: data['product_uid'],
      store_address: data['store_address'],
      vendor_address: data['vendor_address'],
      vendor_name: data['vendor_name'],
    );
  }
}
