import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:tugas1/SqlLite/pembelian_screen.dart';

import 'SqlLite/PembelianService.dart';
import 'SqlLite/pembelian.dart';

class DetailProduk extends StatefulWidget {
  final detail_produk_name;
  final detail_produk_new_price;
  final detail_produk_picture;

  DetailProduk({
    this.detail_produk_name,
    this.detail_produk_new_price,
    this.detail_produk_picture,
  });
  @override
  _DetailProdukState createState() => _DetailProdukState();
}

class _DetailProdukState extends State<DetailProduk> {
  final String url = "http://192.168.1.2:80/api/inputs"; //Ip cek pakai Ipconfig

  Future getData() async {
    var response = await http.get(Uri.parse(url));
    print(jsonDecode(response.body));
    return jsonDecode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.1,
        backgroundColor: Colors.deepPurple,
        title: Text('Detail Product'),
        actions: <Widget>[
          new IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {}),
          new IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => PembelianScreen()))),
        ],
      ),
      body: new ListView(
        children: <Widget>[
          new Container(
            height: 300.0,
            child: GridTile(
              child: Container(
                color: Colors.white,
                child: Image.network(widget.detail_produk_picture),
              ),
              footer: new Container(
                color: Colors.grey[200],
                child: ListTile(
                  leading: new Text(widget.detail_produk_name,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
                  title: new Row(
                    children: <Widget>[
                      Expanded(
                        child: new Text(
                          "Rp. ${widget.detail_produk_new_price}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // untuk tombol 1 pada detail produk

          // untuk tombol 2 pada detail produk
          Row(
            children: <Widget>[
              // untuk tombol beli
              Expanded(
                child: MaterialButton(
                    onPressed: () {
                      formdialog(context);
                    },
                    color: Colors.red,
                    textColor: Colors.white,
                    elevation: 0.2,
                    child: new Text("Beli Sekarang")),
              ),

              new IconButton(
                  icon: Icon(
                    Icons.add_shopping_cart,
                    color: Colors.red,
                  ),
                  onPressed: () {}),
              new IconButton(
                  icon: Icon(
                    Icons.favorite_border,
                    color: Colors.red,
                  ),
                  onPressed: () {}),
            ],
          ),

          Divider(),
          new Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child: new Text("Nama Produk", style: TextStyle(color: Colors.grey)),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: new Text(widget.detail_produk_name),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

formdialog(BuildContext context) {
  var nameController = TextEditingController();
  var lokasiController = TextEditingController();

  var _pembelian = Pembelian();
  var _pembelianService = PembelianService();
  return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          actions: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Container(
                  color: Colors.red,
                  child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(color: Colors.white),
                      ))),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Container(
                  color: Colors.blue,
                  child: TextButton(
                      onPressed: () async {
                        _pembelian.namabrg = nameController.text;
                        _pembelian.lokasi = lokasiController.text;

                        _pembelianService.SavePembelian(_pembelian);

                        Navigator.pop(context);
                      },
                      child: Text(
                        'Save',
                        style: TextStyle(color: Colors.white),
                      ))),
            ),
          ],
          title: Text('Pembelian'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(hintText: "Name Pembeli", labelText: "Nama Pembeli"),
                ),
                TextField(
                  controller: lokasiController,
                  decoration: InputDecoration(hintText: 'Lokasi', labelText: 'Lokasi'),
                )
              ],
            ),
          ),
        );
      });
}
