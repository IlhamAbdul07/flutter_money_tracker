import 'package:money_tracker/database/database_helper.dart';
import 'package:money_tracker/models/pengeluaran_model.dart';

class PengeluaranRepository {
  Future<void> insertPengeluaran(PengeluaranModel pengeluaran) async{
    final db = await DatabaseHelper.instance.database;
    await db.insert('pengeluaran', pengeluaran.toMap());
  }

  Future<List<PengeluaranModel>> getAllPengeluaran() async{
    final db = await DatabaseHelper.instance.database;
    final rows = await db.query('pengeluaran');
    return rows.map((r)=>PengeluaranModel.fromMap(r)).toList();
  }
}