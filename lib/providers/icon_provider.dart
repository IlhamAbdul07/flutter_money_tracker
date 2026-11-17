import 'package:flutter/widgets.dart';
import 'package:money_tracker/models/icon_model.dart';
import 'package:money_tracker/repository/icon_repository.dart';

class IconProvider extends ChangeNotifier {
  final IconRepository _iconRepository = IconRepository();

  List<IconModel> _icons = [];
  bool _isLoading = false;
  String? _errorMessage = '';

  List<IconModel> get icons => _icons;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchIcons() async {
    _isLoading = true;
    notifyListeners();

    try {
      _icons = await _iconRepository.getActiveIcon();
      _errorMessage = '';
    } catch (e) {
      _errorMessage = 'Failed to load icons: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addIcon(IconModel icon) async {
    try {
      await _iconRepository.insertIcon(icon);
      await fetchIcons(); 
    } catch (e) {
      _errorMessage = 'Failed to add icon: $e';
      notifyListeners();
    }
  }

  Future<int> updateIcon(String id, String newIconName) async {
    _errorMessage = null;

    if (newIconName.trim().isEmpty) {
      _errorMessage = 'Gagal memperbarui icon: nama icon wajib diisi';
      notifyListeners();
      return 0;
    }

    try {
      final result = await _iconRepository.updateIcon(id, newIconName.trim());
      if (result == 0) {
        _errorMessage = 'Failed to update icon: Not Found';
        notifyListeners();
        return 0;
      }
      await fetchIcons();
      return result;
    } catch (e) {
      _errorMessage = 'Failed to update icon: $e';
      notifyListeners();
      return 0;
    }
  }
}