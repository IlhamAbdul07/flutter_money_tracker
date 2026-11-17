import 'package:money_tracker/database/database_helper.dart';
import 'package:money_tracker/models/sumber_pemasukan_model.dart';

class SumberPemasukanRepository {
  Future<void> insertSumberPemasukan(SumberPemasukanModel sumberPemasukan) async{
    final db = await DatabaseHelper.instance.database;
    await db.insert('sumber_pemasukan', sumberPemasukan.toMap());
  }

  Future<List<SumberPemasukanModel>> getActiveSumberPemasukan() async{
    final db = await DatabaseHelper.instance.database;
    final rows = await db.query('sumber_pemasukan', where: 'is_active = ?', whereArgs: [1]);
    return rows.map((r)=>SumberPemasukanModel.fromMap(r)).toList();
  }

  Future<int> deactivateSumberPemasukan(String id) async {
    final db = await DatabaseHelper.instance.database;
    return await db.update('sumber_pemasukan', {'is_active' : 0}, where: 'id_sumber= ?', whereArgs: [id]);
  }

  Future<int> updateSumberPemasukan(String id, String newSumberPemasukan) async {
    final db = await DatabaseHelper.instance.database;
    return await db.update(
      'sumber_pemasukan',
      {'sumber_pemasukan': newSumberPemasukan},
      where: 'id_sumber = ? AND is_active = 1',
      whereArgs: [id],
    );
  }
}