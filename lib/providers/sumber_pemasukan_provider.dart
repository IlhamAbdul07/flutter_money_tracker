import 'package:flutter/material.dart';
import 'package:money_tracker/models/sumber_pemasukan_model.dart';
import 'package:money_tracker/repository/sumber_pemasukan_repository.dart';

class SumberPemasukanProvider extends ChangeNotifier {
  final _sumberPemasukanRepository = SumberPemasukanRepository();
  List<SumberPemasukanModel> _sumberPemasukan = [];
  bool _isLoading = false;
  String? _errorMessage = '';
  String? _message = '';

  List<SumberPemasukanModel> get sumberPemasukan => _sumberPemasukan;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get message => _message;

  Future<void> fetchSumberPemasukan() async {
    _isLoading = true;
    try {
      _sumberPemasukan = await _sumberPemasukanRepository.getActiveSumberPemasukan();
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Gagal memuat tujuan pengeluaran: $e';
      notifyListeners();
    } finally {
      _isLoading = false;
    }
  }

  Future<void> addSumberPemasukan(SumberPemasukanModel sumberPemasukan) async {
    try {
      await _sumberPemasukanRepository.insertSumberPemasukan(sumberPemasukan);
      notifyListeners();
      await fetchSumberPemasukan();
    } catch (e) {
      _errorMessage = 'Gagal menambah sumber pemasukan: $e';
      notifyListeners();
    }
  }

  Future<int> updateSumberPemasukan(String id, String newSumberPemasukan) async {
    _errorMessage = null;
    _message = null;

    if (newSumberPemasukan.trim().isEmpty) {
      _errorMessage = 'Gagal memperbarui sumber pemasukan: nama sumber wajib diisi';
      notifyListeners();
      return 0;
    }

    try {
      final result = await _sumberPemasukanRepository.updateSumberPemasukan(id, newSumberPemasukan.trim());
      if (result == 0) {
        _errorMessage = 'Gagal memperbarui sumber pemasukan: Not Found';
        notifyListeners();
        return 0;
      }
      _message = 'Sumber pemasukan updated successfully';
      await fetchSumberPemasukan();
      return result;
    } catch (e) {
      _errorMessage = 'Gagal memperbarui sumber pemasukan: $e';
      notifyListeners();
      return 0;
    }
  }

  Future<int> deactivateSumberPemasukan(String id) async {
    _errorMessage = null;
    _message = null;

    try {
      final result = await _sumberPemasukanRepository.deactivateSumberPemasukan(id);
      if (result == 0) {
        _errorMessage = 'Gagal menonaktifkan sumber pemasukan: Not Found';
        notifyListeners();
        return 0;
      }
      _message = 'Sumber pemasukan dinonaktifkan successfully';
      await fetchSumberPemasukan();
      return result;
    } catch (e) {
      _errorMessage = 'Gagal menonaktifkan sumber pemasukan: $e';
      notifyListeners();
      return 0;
    }
  }
  
}