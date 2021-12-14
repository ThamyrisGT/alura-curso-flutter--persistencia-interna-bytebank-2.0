import 'package:bytebank_2/database/dao/contact_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  //final String dbPath = await getDatabasesPath();
  final String path = join(await getDatabasesPath(), 'byteBank.db');
  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(ContactDao.TABLESQL);
    },
    version: 1,
    //onDowngrade: onDatabaseDowngradeDelete,
  );
}
