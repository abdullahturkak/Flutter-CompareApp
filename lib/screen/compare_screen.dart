import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:proje/screen/product.dart';

class CompareScreen extends StatefulWidget {
  final DocumentSnapshot? userDoc;
  const CompareScreen(this.userDoc);
  @override
  _CompareScreenState createState() => _CompareScreenState();
}

class _CompareScreenState extends State<CompareScreen> {
  List<Widget> makeListWiget(AsyncSnapshot snapshot) {
    return snapshot.data.docs.map<Widget>((document) {
      return ListTile(
          isThreeLine: true,
          leading: Image.network(widget.userDoc!['foto']),
          title: Text(document["urunadi"],
              style: const TextStyle(color: Colors.grey)),
          subtitle: Row(
            children: <Widget>[
              Text("Market:" + " " + document["market"] + "  ",
                  style: const TextStyle(color: Colors.grey)),
              Text("Fiyat:" + " " + document["fiyat"] + "₺" + "  ",
                  style: const TextStyle(color: Colors.grey)),
            ],
          ));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text('Benzer Ürünler'),
        ),
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        body: Container(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('uruntablo')
                    .where('alt_kategori',
                        isEqualTo: widget.userDoc!['alt_kategori'])
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.data == null) return CircularProgressIndicator();
                  return ListView(
                    children: makeListWiget(snapshot),
                  );
                })));
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}
