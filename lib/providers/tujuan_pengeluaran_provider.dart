import 'package:flutter/material.dart';
import 'package:money_tracker/models/tujuan_pengeluaran_model.dart';
import 'package:money_tracker/repository/tujuan_pengeluaran_repository.dart';

class TujuanPengeluaranProvider extends ChangeNotifier {
  final _tujuanPengeluaranRepository = TujuanPengeluaranRepository();
  List<TujuanPengeluaranModel> _tujuanPengeluaran = [];
  bool _isLoading = false;
  String? _errorMessage = '';
  String? _message = '';

  List<TujuanPengeluaranModel> get tujuanPengeluaran => _tujuanPengeluaran;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get message => _message;

  Future<void> fetchTujuanPengeluaran() async {
    _isLoading = true;
    try {
      _tujuanPengeluaran = await _tujuanPengeluaranRepository.getActiveTujuanPengeluaran();
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Gagal memuat tujuan pengeluaran: $e';
      notifyListeners();
    } finally {
      _isLoading = false;
    }
  }

  Future<void> addTujuanPengeluaran(TujuanPengeluaranModel tujuanPengeluaran) async {
    try {
      await _tujuanPengeluaranRepository.insertTujuanPengeluaran(tujuanPengeluaran);
      notifyListeners();
      await fetchTujuanPengeluaran();
    } catch (e) {
      _errorMessage = 'Gagal menambah tujuan pengeluaran: $e';
      notifyListeners();
    }
  }

  Future<int> updateTujuanPengeluaran(String id, String newTujuanPengeluaran) async {
    _errorMessage = null;
    _message = null;

    if (newTujuanPengeluaran.trim().isEmpty) {
      _errorMessage = 'Gagal memperbarui tujuan pengeluaran: nama tujuan wajib diisi';
      notifyListeners();
      return 0;
    }

    try {
      final result = await _tujuanPengeluaranRepository.updateTujuanPengeluaran(id, newTujuanPengeluaran.trim());
      if (result == 0) {
        _errorMessage = 'Gagal memperbarui tujuan pengeluaran: Not Found';
        notifyListeners();
        return 0;
      }
      _message = 'Tujuan pengeluaran updated successfully';
      await fetchTujuanPengeluaran();
      return result;
    } catch (e) {
      _errorMessage = 'Gagal memperbarui tujuan pengeluaran: $e';
      notifyListeners();
      return 0;
    }
  }

  Future<int> deactivateTujuanPengeluaran(String id) async {
    _errorMessage = null;
    _message = null;

    try {
      final result = await _tujuanPengeluaranRepository.deactivateTujuanPengeluaran(id);
      if (result == 0) {
        _errorMessage = 'Gagal menonaktifkan tujuan pengeluaran: Not Found';
        notifyListeners();
        return 0;
      }
      _message = 'Tujuan pengeluaran dinonaktifkan successfully';
      await fetchTujuanPengeluaran();
      return result;
    } catch (e) {
      _errorMessage = 'Gagal menonaktifkan tujuan pengeluaran: $e';
      notifyListeners();
      return 0;
    }
  }
  
}