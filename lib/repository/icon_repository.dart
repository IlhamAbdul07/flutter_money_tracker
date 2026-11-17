import 'package:money_tracker/database/database_helper.dart';
import 'package:money_tracker/models/icon_model.dart';

class IconRepository {

  Future<void> insertIcon(IconModel icon) async{
    final db = await DatabaseHelper.instance.database;
    await db.insert('icon', icon.toMap());
  }

  Future<List<IconModel>> getActiveIcon() async{
    final db = await DatabaseHelper.instance.database;
    final rows = await db.query('icon', where: 'is_active = ?', whereArgs: [1]);
    return rows.map((r)=>IconModel.fromMap(r)).toList();
  }

  Future<int> updateIcon(String id, String newIconName) async{
    final db = await DatabaseHelper.instance.database;
    return await db.update('icon', {'icon' : newIconName} ,where: 'id_icon = ? AND is_active = 1', whereArgs: [id]);
  }

  Future<int> deactivateIcon(String id) async{
    final db = await DatabaseHelper.instance.database;
    return await db.update('icon', {'is_active' : 0}, where: 'id_icon = ?', whereArgs: [id]);
  }
}