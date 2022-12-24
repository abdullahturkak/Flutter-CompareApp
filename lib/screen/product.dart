import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:proje/screen/compare_screen.dart';
import 'package:proje/screen/home_screen.dart';

class ProductScreen extends StatefulWidget {
  final DocumentSnapshot? userDoc;
  const ProductScreen(this.userDoc);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                }),
          ),
          backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
          body: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Container(
                      width: double.infinity,
                      child: Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(3, (index) {
                                return Padding(
                                  padding: EdgeInsets.only(left: 16, top: 8),
                                  child: Container(
                                    width: 7,
                                    height: 7,
                                    decoration: BoxDecoration(
                                      color: index == 0
                                          ? Colors.black
                                          : Colors.grey,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),
                                );
                              }),
                            ),
                            Expanded(
                                child: Image.network(widget.userDoc!['foto'])),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  widget.userDoc!['urunadi'],
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  widget.userDoc!['kategori'],
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  widget.userDoc!['aciklama'],
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1.0,
                    fontFamily: 'Lobster',
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    Text(
                      "₺ ",
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      widget.userDoc!['fiyat'],
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'Lobster',
                      ),
                    ),
                    Spacer(),
                    SizedBox(width: 60),
                    MaterialButton(
                      height: 50,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CompareScreen(widget.userDoc)));
                      },
                      child: const Text(
                        'Karşılaştır',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      color: Colors.black,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
