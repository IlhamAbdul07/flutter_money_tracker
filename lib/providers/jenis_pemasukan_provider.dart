import 'package:flutter/material.dart';
import 'package:money_tracker/models/jenis_pemasukan_model.dart';
import 'package:money_tracker/repository/jenis_pemasukan_repository.dart';

class JenisPemasukanProvider extends ChangeNotifier {
  final JenisPemasukanRepository _jenisPemasukanRepository = JenisPemasukanRepository();

  List<JenisPemasukanModel> _jenisPemasukan = [];
  bool _isLoading = false;
  String? _errorMessage = '';
  String? _message = '';
  
  List<JenisPemasukanModel> get jenisPemasukan => _jenisPemasukan;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get message => _message;

  Future<void> fetchJenisPemasukan() async {
    _isLoading = true;
    try {
      _jenisPemasukan = await _jenisPemasukanRepository.getActiveJenisPemasukan();
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Gagal memuat jenis pemasukan: $e';
      notifyListeners();
    } finally {
      _isLoading = false;
    }
  }

  Future<void> addJenisPemasukan(JenisPemasukanModel jenisPemasukan) async {
    try {
      await _jenisPemasukanRepository.insertJenisPemasukan(jenisPemasukan);
      notifyListeners();
      await fetchJenisPemasukan(); 
    } catch (e) {
      _errorMessage = 'Gagal menambah jenis pemasukan: $e';
      notifyListeners();
    }
  }

  Future<int> updateJenisPemasukan(String id, String newJenisPemasukan, String newIdIcon) async {
    _errorMessage = null;
    _message = null;

    if (newJenisPemasukan.trim().isEmpty || newIdIcon.trim().isEmpty) {
      _errorMessage = 'Gagal memperbarui jenis pemasukan: nama jenis, icon wajib diisi';
      notifyListeners();
      return 0;
    }   
    try {
      final result = await _jenisPemasukanRepository.updateJenisPemasukan(id, newJenisPemasukan.trim(), newIdIcon.trim(),);
      if (result == 0){
        _errorMessage = 'Gagal memperbarui jenis pemasukan: Not Found';
        notifyListeners();
        return 0;
      }
        _message = 'Jenis pemasukan updated successfully';
        await fetchJenisPemasukan();
        return result;   
    } catch (e) {
      _errorMessage = 'Gagal memperbarui jenis pemasukan: $e';
      notifyListeners();
      return 0;
    }
  }

  Future<int> deactivateJenisPemasukan(String id,) async {
    _errorMessage = null;
    _message = null;

    try {
      final result = await _jenisPemasukanRepository.deactivateJenisPemasukan(id);
      if (result == 0){
        _errorMessage = 'Gagal menghapus jenis pemasukan: Not Found';
        notifyListeners();
        return 0;
      }
      
      _message = 'Jenis pemasukan berhasil dihapus';
      await fetchJenisPemasukan();
      return result;
    } catch (e) {
      _errorMessage = 'Gagal menghapus jenis pemasukan: $e';
      notifyListeners();
      return 0;
    }
  }
}