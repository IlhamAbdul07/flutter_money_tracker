import 'package:money_tracker/database/database_helper.dart';
import 'package:money_tracker/models/jenis_pemasukan_model.dart';

class JenisPemasukanRepository {
  Future<void> insertJenisPemasukan(JenisPemasukanModel jenisPemasukan) async{
    final db = await DatabaseHelper.instance.database;
    await db.insert('jenis_pemasukan', jenisPemasukan.toMap());
  }

  Future<List<JenisPemasukanModel>> getActiveJenisPemasukan() async{
    final db = await DatabaseHelper.instance.database;
    final rows = await db.query('jenis_pemasukan', where: 'is_active = ?', whereArgs: [1]);
    return rows.map((r)=>JenisPemasukanModel.fromMap(r)).toList();
  }

  Future<int> deactivateJenisPemasukan(String id)async{
    final db = await DatabaseHelper.instance.database;
    return await db.update('jenis_pemasukan', {'is_active' : 0}, where: 'id_jenis_pemasukan = ?', whereArgs: [id]);
  }

  Future<int> updateJenisPemasukan(String id, String newJenisPemasukanName, String newIconId) async{
    final db = await DatabaseHelper.instance.database;
    return await db.update('jenis_pemasukan', {'nama_jenis_pemasukan': newJenisPemasukanName, 'id_icon': newIconId}, where: 'id_jenis_pemasukan = ?', whereArgs: [id]);
  }
}