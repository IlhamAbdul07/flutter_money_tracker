import 'package:money_tracker/database/database_helper.dart';
import 'package:money_tracker/models/jenis_pengeluaran_model.dart';

class JenisPengeluaranRepository {

  Future<void> insertJenisPengeluaran(JenisPengeluaranModel jenisPengeluaran) async{
    final db = await DatabaseHelper.instance.database;
    await db.insert('jenis_pengeluaran', jenisPengeluaran.toMap());
  }

  Future<List<JenisPengeluaranModel>> getActiveJenisPengeluaran() async{
    final db = await DatabaseHelper.instance.database;
    final rows = await db.query('jenis_pengeluaran', where: 'is_active = ?', whereArgs: [1]);
    return rows.map((r)=>JenisPengeluaranModel.fromMap(r)).toList();
  }

  Future<int> deactivateJenisPengeluaran(String id)async{
    final db = await DatabaseHelper.instance.database;
    return await db.update('jenis_pengeluaran', {'is_active' : 0}, where: 'id_jenis_pengeluaran = ?', whereArgs: [id]);
  }

  Future<int> updateJenisPengeluaran(String id, String newJenisPengeluaran, String newIdIcon) async{
    final db = await DatabaseHelper.instance.database;
    return await db.update('jenis_pengeluaran', {'jenis_pengeluaran' : newJenisPengeluaran, 'id_icon': newIdIcon} ,where: 'id_jenis_pengeluaran = ? AND is_active = 1', whereArgs: [id]);
  }
}