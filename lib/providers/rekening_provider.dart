import 'package:flutter/material.dart';
import 'package:money_tracker/models/rekening_model.dart';
import 'package:money_tracker/repository/rekening_repository.dart';

class RekeningProvider extends ChangeNotifier {
  final RekeningRepository _rekeningRepository = RekeningRepository();

  List<RekeningModel> _rekenings = [];
  bool _isLoading = false;
  String? _errorMessage = '';
  String? _message = '';

  List<RekeningModel> get rekenings => _rekenings;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get message => _message;

  Future<void> fetchRekenings() async {
    _isLoading = true;
    notifyListeners();

    try {
      _rekenings = await _rekeningRepository.getActiveRekening();
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Gagal memuat rekening: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addRekening(RekeningModel rekening) async {
    try {
      await _rekeningRepository.insertRekening(rekening);
      notifyListeners();
      await fetchRekenings(); 
    } catch (e) {
      _errorMessage = 'Gagal menambah rekening: $e';
      notifyListeners();
    }
  }

  Future<int> updateRekening(String id, String newNamaRekening) async {
    _errorMessage = null;
    _message = null;

    if (newNamaRekening.trim().isEmpty) {
      _errorMessage = 'Gagal memperbarui rekening: nama rekening wajib diisi';
      notifyListeners();
      return 0;
    }

    try {
      final result = await _rekeningRepository.updateRekening(id, newNamaRekening.trim());
      if (result == 0) {
        _errorMessage = 'Gagal memperbarui rekening: Not Found';
        notifyListeners();
        return 0;
      }
      _message = 'Rekening updated successfully';
      await fetchRekenings();
      return result;
    } catch (e) {
      _errorMessage = 'Gagal memperbarui rekening: $e';
      notifyListeners();
      return 0;
    }
  }

  Future<int> deactivateRekening(String id) async {
    _errorMessage = null;
    _message = null;

    try {
      final result = await _rekeningRepository.deactivateRekening(id);
      if (result == 0) {
        _errorMessage = 'Gagal menghapus rekening: Not Found';
        notifyListeners();
        return 0;
      }
      _message = 'Rekening deleted successfully';
      await fetchRekenings();
      return result;
    } catch (e) {
      _errorMessage = 'Gagal menghapus rekening: $e';
      notifyListeners();
      return 0;
    }
  }
}