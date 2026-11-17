import 'package:money_tracker/database/database_helper.dart';
import 'package:money_tracker/models/rekening_model.dart';

class RekeningRepository {
  Future<void> insertRekening(RekeningModel rek) async {
    final db = await DatabaseHelper.instance.database;
    db.insert('rekening', rek.toMap());
  }

  Future<List<RekeningModel>> getActiveRekening() async {
    final db = await DatabaseHelper.instance.database;
    final rows =  await db.query('rekening', where: 'is_active = ?', whereArgs: [1]);
    return rows.map((r) => RekeningModel.fromMap(r)).toList();
  }

  Future<int> deactivateRekening(String id) async {
    final db = await DatabaseHelper.instance.database;
    return await db.update('rekening', {'is_active': 0}, where: 'id_rekening = ? AND saldo = 0', whereArgs: [id]);
  }

  Future<int> updateRekening(String id, String newNamaRekening) async {
    final db = await DatabaseHelper.instance.database;
    return await db.update('rekening', {'nama_rekening': newNamaRekening}, where: 'id_rekening = ? AND is_active = 1', whereArgs: [id]);
  }
}