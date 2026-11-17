import 'package:flutter/material.dart';
import 'package:money_tracker/models/jenis_pengeluaran_model.dart';
import 'package:money_tracker/repository/jenis_pengeluaran_repository.dart';

class JenisPengeluaranProvider extends ChangeNotifier {
  final JenisPengeluaranRepository _jenisPengeluaranRepository = JenisPengeluaranRepository();

  List<JenisPengeluaranModel> _jenisPengeluaran = [];
  bool _isLoading = false;
  String? _errorMessage = '';
  String? _message = '';
  
  List<JenisPengeluaranModel> get jenisPengeluaran => _jenisPengeluaran;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get message => _message;

  Future<void> fetchJenisPengeluaran() async {
    _isLoading = true;
    try {
      _jenisPengeluaran = await _jenisPengeluaranRepository.getActiveJenisPengeluaran();
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Gagal memuat jenis pengeluaran: $e';
      notifyListeners();
    } finally {
      _isLoading = false;
    }
  }

  Future<void> addJenisPengeluaran(JenisPengeluaranModel jenisPengeluaran) async {
    try {
      await _jenisPengeluaranRepository.insertJenisPengeluaran(jenisPengeluaran);
      notifyListeners();
      await fetchJenisPengeluaran(); 
    } catch (e) {
      _errorMessage = 'Gagal menambah jenis pengeluaran: $e';
      notifyListeners();
    }
  }

  Future<int> updateJenisPengeluaran(String id, String newJenisPengeluaran, String newIdIcon) async {
    _errorMessage = null;
    _message = null;

    if (newJenisPengeluaran.trim().isEmpty || newIdIcon.trim().isEmpty) {
      _errorMessage = 'Gagal memperbarui jenis pengeluaran: nama jenis, icon wajib diisi';
      notifyListeners();
      return 0;
    }   
    try {
      final result = await _jenisPengeluaranRepository.updateJenisPengeluaran(id, newJenisPengeluaran.trim(), newIdIcon.trim(),);
      if (result == 0){
        _errorMessage = 'Gagal memperbarui jenis pengeluaran: Not Found';
        notifyListeners();
        return 0;
      }
        _message = 'Jenis pengeluaran updated successfully';
        await fetchJenisPengeluaran();
        return result;   
    } catch (e) {
      _errorMessage = 'Gagal memperbarui jenis pengeluaran: $e';
      notifyListeners();
      return 0;
    }
  }

  Future<int> deactivateJenisPengeluaran(String id,) async {
    _errorMessage = null;
    _message = null;

    try {
      final result = await _jenisPengeluaranRepository.deactivateJenisPengeluaran(id);
      if (result == 0){
        _errorMessage = 'Gagal menghapus jenis pengeluaran: Not Found';
        notifyListeners();
        return 0;
      }
      
      _message = 'Jenis pengeluaran berhasil dihapus';
      await fetchJenisPengeluaran();
      return result;
    } catch (e) {
      _errorMessage = 'Gagal menghapus jenis pengeluaran: $e';
      notifyListeners();
      return 0;
    }
  }
}