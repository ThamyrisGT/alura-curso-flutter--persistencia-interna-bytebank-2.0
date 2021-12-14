import 'package:bytebank_2/model/contact.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  //final String dbPath = await getDatabasesPath();
  final String path = join(await getDatabasesPath(), 'byteBank.db');
  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute('CREATE TABLE contacts('
          'id INTEGER PRIMARY KEY,'
          'name TEXT,'
          'account_number INTEGER)');
    },
    version: 1,
    //onDowngrade: onDatabaseDowngradeDelete,
  );
}

Future<int> save(Contact contact) async {
  final Database database = await getDatabase();
  final Map<String, dynamic> contactMap = Map();
  //contactMap['id'] = contact.id;
  contactMap['name'] = contact.name;
  contactMap['account_number'] = contact.accountNumber;
  return database.insert('contacts', contactMap);
}

Future<List<Contact>> findAll() async {
  final Database database = await getDatabase();
  final List<Map<String, dynamic>> result = await database.query('contacts');
  final List<Contact> contacts = [];
  for (Map<String, dynamic> row in result) {
    final Contact contact = Contact(
      row['id'],
      row['name'],
      row['account_number'],
    );
    contacts.add(contact);
  }
  return contacts;
}
