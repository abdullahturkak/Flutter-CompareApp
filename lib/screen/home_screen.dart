import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proje/screen/product.dart';
import 'package:proje/screen/signin_screen.dart';
import '../reusable_widget/reusable_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController searchController = TextEditingController();
  late QuerySnapshot? snapshot;
  late bool isExcecuted = false;

  @override
  Widget build(BuildContext context) {
    Widget searchedData() {
      return ListView.builder(
        itemCount: snapshot?.docs.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            isThreeLine: true,
            leading: Image.network(snapshot!.docs[index]['foto']),
            title: Text(
              snapshot!.docs[index]['urunadi'],
              style: const TextStyle(color: Colors.grey),
            ),
            subtitle: Text(
              snapshot!.docs[index]['fiyat'],
              style: const TextStyle(color: Color.fromRGBO(158, 158, 158, 1)),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ProductScreen(snapshot!.docs[index])));
            },
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.clear),
          onPressed: () {
            searchController.clear();
          }),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          GetBuilder<DataController>(
            init: DataController(),
            builder: (val) {
              return IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    val.queryData(searchController.text).then((value) {
                      snapshot = value;
                      setState(() {
                        isExcecuted = true;
                      });
                    });
                  });
            },
          )
        ],
        title: TextField(
          style: TextStyle(color: Colors.white),
          decoration: const InputDecoration(
              hintText: 'Arama Gerçekleştir',
              hintStyle: TextStyle(color: Colors.white)),
          controller: searchController,
        ),
      ),
      body: isExcecuted
          ? searchedData()
          : Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      'Tüm Kategorilerde Ara',
                      style: TextStyle(color: Colors.grey, fontSize: 30.0),
                    ),
                    ElevatedButton(
                      child: Text("Çıkış Yap"),
                      onPressed: () {
                        FirebaseAuth.instance.signOut().then((value) {
                          print("Çıkış Yapıldı");
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignInScreen()));
                        });
                      },
                    ),
                  ]),
            ),
    );
  }
}
