import 'package:bytebank_2/model/contact.dart';
import 'package:sqflite/sqflite.dart';

import '../app_database.dart';

class ContactDao {
  static const String TABLESQL = 'CREATE TABLE $TABLENAME('
      '$ID INTEGER PRIMARY KEY,'
      '$NAME TEXT,'
      '$ACCOUNT_NUMBER INTEGER)';

  static const String TABLENAME = 'contacts';
  static const String ID = 'id';
  static const String NAME = 'name';
  static const String ACCOUNT_NUMBER = 'account_number';

  Future<int> save(Contact contact) async {
    final Database database = await getDatabase();
    Map<String, dynamic> contactMap = _toMap(contact);
    return database.insert(TABLENAME, contactMap);
  }

  Map<String, dynamic> _toMap(Contact contact) {
    final Map<String, dynamic> contactMap = Map();
    contactMap[NAME] = contact.name;
    contactMap[ACCOUNT_NUMBER] = contact.accountNumber;
    return contactMap;
  }

  Future<List<Contact>> findAll() async {
    final Database database = await getDatabase();
    final List<Map<String, dynamic>> result = await database.query(TABLENAME);
    List<Contact> contacts = _toList(result);
    return contacts;
  }

  List<Contact> _toList(List<Map<String, dynamic>> result) {
    final List<Contact> contacts = [];
    for (Map<String, dynamic> row in result) {
      final Contact contact = Contact(
        row[ID],
        row[NAME],
        row[ACCOUNT_NUMBER],
      );
      contacts.add(contact);
    }
    return contacts;
  }
}
