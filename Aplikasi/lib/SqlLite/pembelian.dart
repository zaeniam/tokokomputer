class Pembelian {
  int id;
  String namabrg;
  String lokasi;

  pembelianMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id;
    mapping['namabrg'] = namabrg;
    mapping['lokasi'] = lokasi;

    return mapping;
  }
}
