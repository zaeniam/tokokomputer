import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import './menuDrawer.dart' as menuDrawer;
import 'dart:ui';

import 'detail.dart';

class beranda extends StatefulWidget {
  @override
  _berandaState createState() => _berandaState();
}

class _berandaState extends State<beranda> {
  final String url = "http://192.168.1.2:80/api/inputs"; //Ip cek pakai Ipconfig

  Future getData() async {
    var response = await http.get(Uri.parse(url));
    print(jsonDecode(response.body));
    return jsonDecode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text("Home"),
        actions: <Widget>[
          //action dipakek nambah widget di appbar bagian action
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {},
            color: Colors.white,
          ),
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {},
          ),
        ],
      ),
      drawer: menuDrawer.Menudrawer(), // manggil kelas drawer yang udah dibuat
      body: ListView(
        //supaya bisa discroll kebawah kalau misalkan kepenuhan
        children: <Widget>[
          Image.asset("images/m750_photo_product_004.jpg"),
          Container(
            color: Colors.deepPurple[800],
            child: Row(
              mainAxisAlignment: MainAxisAlignment
                  .end, //main axis untuk row itu ngerubah horizontal kalau cross ngerubah row dari sisi vertical
              children: [
                Expanded(
                  //menghabiskan bagian/space pada row yang tersisa
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start, //cross axis pada column untuk mengatur horizontal
                    children: <Widget>[
                      Text(
                        "Gaming Gear Set",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w800, color: Colors.white),
                      ),
                      Text(
                        "Rp. 2.800.000",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.local_grocery_store_outlined,
                    color: Colors.white,
                  ),
                  onPressed:
                      () {}, // tanda () {} adalah anonymous method fungsinya disini agar icon buttonya tidak berwarna abu-abu seperti kelihatan di pencet gitu
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.mouse),
                      onPressed: () {},
                      color: Colors.deepPurple,
                    ),
                    Text(
                      "Mouse",
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.keyboard),
                      onPressed: () {},
                      color: Colors.deepPurple,
                    ),
                    Text(
                      "Keyboard",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15, color: Colors.deepPurple),
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.mic),
                      onPressed: () {},
                      color: Colors.deepPurple,
                    ),
                    Text(
                      "Mic",
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.headset),
                      onPressed: () {},
                      color: Colors.deepPurple,
                    ),
                    Text(
                      "Headshet",
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                    )
                  ],
                )
              ],
            ),
          ),
          FutureBuilder(
            future: getData(),
            // ignore: missing_return
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: snapshot.data['data'].length,
                    // ignore: missing_return
                    itemBuilder: (context, index) {
                      return Container(
                        child: Card(
                          elevation: 4,
                          child: Row(
                            children: [
                              Container(
                                child: InkWell(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DetailProduk(
                                                detail_produk_name: snapshot.data['data'][index]
                                                    ['nama_produk'],
                                                detail_produk_new_price: snapshot.data['data']
                                                    [index]['harga'],
                                                detail_produk_picture: snapshot.data['data'][index]
                                                    ['gambar'],
                                              ))),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network(
                                      snapshot.data['data'][index]['gambar'],
                                      height: 150,
                                      width: 150,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(20),
                                child: Expanded(
                                    child: Container(
                                  margin: EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        snapshot.data['data'][index]['nama_produk'],
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                      ),
                                      Text(
                                        "Stok : " + snapshot.data['data'][index]['stok'],
                                        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
                                      ),
                                      Text(
                                        "Rp. " + snapshot.data['data'][index]['harga'],
                                        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
                                      ),
                                    ],
                                  ),
                                )),
                              )
                            ],
                          ),
                        ),
                      );
                    });
              } else {
                Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
