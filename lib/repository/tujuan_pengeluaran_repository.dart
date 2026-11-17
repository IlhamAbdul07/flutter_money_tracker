import 'package:money_tracker/database/database_helper.dart';
import 'package:money_tracker/models/tujuan_pengeluaran_model.dart';

class TujuanPengeluaranRepository {
  Future<void> insertTujuanPengeluaran(TujuanPengeluaranModel tujuanPengeluaran) async{
    final db = await DatabaseHelper.instance.database;
    await db.insert('tujuan_pengeluaran', tujuanPengeluaran.toMap());
  }

  Future<List<TujuanPengeluaranModel>> getActiveTujuanPengeluaran() async{
    final db = await DatabaseHelper.instance.database;
    final rows = await db.query('tujuan_pengeluaran', where: 'is_active = ?', whereArgs: [1]);
    return rows.map((r)=>TujuanPengeluaranModel.fromMap(r)).toList();
  }

  Future<int> deactivateTujuanPengeluaran(String id)async{
    final db = await DatabaseHelper.instance.database;
    return await db.update('tujuan_pengeluaran', {'is_active' : 0}, where: 'id_tujuan = ?', whereArgs: [id]);
  }

  Future<int> updateTujuanPengeluaran(String id, String newTujuanPengeluaran) async {
    final db = await DatabaseHelper.instance.database;
    final result = await db.update(
      'tujuan_pengeluaran',
      {'tujuan_pengeluaran': newTujuanPengeluaran},
      where: 'id_tujuan = ?',
      whereArgs: [id],
    );
    return result;
  }
}