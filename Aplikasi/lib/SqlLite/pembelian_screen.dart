import 'package:flutter/material.dart';

import 'PembelianService.dart';
import 'pembelian.dart';

class PembelianScreen extends StatefulWidget {
  @override
  _PembelianScreenState createState() => _PembelianScreenState();
}

class _PembelianScreenState extends State<PembelianScreen> {
  var _pembelian = Pembelian();
  var pembelian;
  var _pembelianservice = PembelianService();
  var _namaController = TextEditingController();
  var _lokasiController = TextEditingController();

  // ignore: deprecated_member_use
  List<Pembelian> _pembelianList = List<Pembelian>();
  @override
  void initState() {
    super.initState();
    getAllPembelian();
  }

  getAllPembelian() async {
    // ignore: deprecated_member_use
    _pembelianList = List<Pembelian>();
    var pembelians = await _pembelianservice.readPembelian();
    pembelians.forEach((pembelian) {
      setState(() {
        var pembelianModel = Pembelian();
        pembelianModel.namabrg = pembelian['namabrg'];
        pembelianModel.lokasi = pembelian['lokasi'];
        pembelianModel.id = pembelian['id'];
        _pembelianList.add(pembelianModel);
      });
    });
  }

  // ignore: non_constant_identifier_names
  editPembelian(BuildContext, pembelianId) async {
    pembelian = await _pembelianservice.readPembelianById(pembelianId);
    setState(() {
      _namaController.text = pembelian[0]['namabrg'] ?? 'Tidak ada nama';
      _lokasiController.text = pembelian[0]['lokasi'] ?? 'Tidak ada lokasi';
    });
    editdialog(context);
  }

  editdialog(BuildContext context) {
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
                          Navigator.pop(context);
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
                          _pembelian.id = pembelian[0]['id'];
                          _pembelian.namabrg = _namaController.text;
                          _pembelian.lokasi = _lokasiController.text;

                          var result = await _pembelianservice.updatePembelian(pembelian);
                          if (result > 0) {
                            Navigator.pop(context);
                            getAllPembelian();
                          }
                        },
                        child: Text(
                          'Save',
                          style: TextStyle(color: Colors.white),
                        ))),
              ),
            ],
            title: Text('Edit Bookmark'),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: _namaController,
                    decoration: InputDecoration(hintText: "Name", labelText: "Name"),
                  ),
                  TextField(
                    controller: _lokasiController,
                    decoration: InputDecoration(hintText: 'Lokasi', labelText: 'Lokasi'),
                  )
                ],
              ),
            ),
          );
        });
  }

  deletedialog(BuildContext context, pembelianId) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            actions: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Container(
                    color: Colors.blue,
                    child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Cancel',
                          style: TextStyle(color: Colors.white),
                        ))),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Container(
                    color: Colors.red,
                    child: TextButton(
                        onPressed: () async {
                          var result = await _pembelianservice.deletePembelian(pembelianId);
                          if (result > 0) {
                            Navigator.pop(context);
                            getAllPembelian();
                          }
                        },
                        child: Text(
                          'Delete',
                          style: TextStyle(color: Colors.white),
                        ))),
              ),
            ],
            title: Text('Are you sure to delete this ?'),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: ListView.builder(
          itemCount: _pembelianList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 5,
                child: ListTile(
                    leading: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          editPembelian(BuildContext, _pembelianList[index].id);
                        }),
                    title: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(_pembelianList[index].namabrg),
                          IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                deletedialog(context, _pembelianList[index].id);
                              })
                        ],
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_pembelianList[index].lokasi),
                      ],
                    )),
              ),
            );
          }),
    );
  }
}
