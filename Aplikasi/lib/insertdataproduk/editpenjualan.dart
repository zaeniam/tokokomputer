import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class EditPenjualan extends StatelessWidget {
  final Map input;
  EditPenjualan({@required this.input});
  final _formkey = GlobalKey<FormState>();
  TextEditingController namaController = TextEditingController();
  TextEditingController stok = TextEditingController();
  TextEditingController hargaController = TextEditingController();
  TextEditingController gambarController = TextEditingController();
  Future updateData() async {
    final response = await http
        .put(Uri.parse("http://192.168.1.2:80/api/inputs/" + input['id'].toString()), body: {
      "nama_produk": namaController.text,
      "stok": stok.text,
      "harga": hargaController.text,
      "gambar": gambarController.text,
    });
    return jsonDecode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow.shade800,
        title: Text("Edit Penjualan"),
      ),
      body: Container(
        child: Form(
          key: _formkey,
          child: Padding(
            padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: TextFormField(
                    controller: namaController..text = input['nama_produk'],
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        labelText: "Nama Produk",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(3.0))),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Mohon Masukkan Data";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: TextFormField(
                    controller: stok..text = input['stok'],
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        labelText: "Stok",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(3.0))),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Mohon Masukkan Data";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: TextFormField(
                    controller: gambarController..text = input['gambar'],
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        labelText: "URL Gambar",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(3.0))),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Mohon Masukkan Data";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: TextFormField(
                    controller: hargaController..text = input['harga'],
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        labelText: "Harga",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(3.0))),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Mohon Masukkan Data";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        // ignore: deprecated_member_use
                        child: RaisedButton(
                          color: Colors.green,
                          textColor: Theme.of(context).primaryColorLight,
                          child: Text(
                            "Simpan",
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            if (_formkey.currentState.validate()) {
                              updateData().then((value) {
                                Navigator.pop(context);
                              });
                            }
                          },
                        ),
                      ),
                      Container(
                        width: 5.0,
                      ),
                      Expanded(
                          // ignore: deprecated_member_use
                          child: RaisedButton(
                        color: Colors.red,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          "Batal",
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ))
                    ],
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
