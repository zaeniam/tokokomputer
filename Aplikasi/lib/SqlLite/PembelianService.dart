import 'package:tugas1/SqlLite/repository.dart';

import 'pembelian.dart';

class PembelianService {
  Repository _repository;

  PembelianService() {
    _repository = Repository();
  }
  //creating data
  // ignore: non_constant_identifier_names
  SavePembelian(Pembelian pembelian) async {
    return await _repository.inserData('pembelian', pembelian.pembelianMap());
  }

  //read data from table
  readPembelian() async {
    return await _repository.readData('pembelian');
  }

  //read data dari id yaitu sebagai primary key
  readPembelianById(pembelianId) async {
    return await _repository.readDataById('pembelian', pembelianId);
  }

  //update data
  updatePembelian(Pembelian pembelian) async {
    return await _repository.updatePembelian('pembelian', pembelian.pembelianMap());
  }

  //delete data
  deletePembelian(pembelianId) async {
    return await _repository.deletePembelian('pembelian', pembelianId);
  }
}
