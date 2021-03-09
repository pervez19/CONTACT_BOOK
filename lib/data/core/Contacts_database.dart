import 'package:contact_book/common/constants/constants.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class ContactsDatabase {
  ContactsDatabase();

  static final ContactsDatabase _contactsDatabase =
      new ContactsDatabase._internal();

  ContactsDatabase._internal();

  Database _database;

  static ContactsDatabase get() {
    return _contactsDatabase;
  }

  bool didInit = false;

  Future<Database> getDb() async {
    if (!didInit) await initDatabase();
    return _database;
  }

  Future initDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, DATABASE_NAME);
    _database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await createContactTable(db);
    }, onUpgrade: (Database db, int oldVersion, int newVersion) async {
      await db.execute("DROP TABLE ${ContactTable.TABLE_NAME}");
      await createContactTable(db);
    });
    didInit = true;
  }

  Future createContactTable(Database db) {
    return db.transaction((Transaction txn) async {
      txn.execute(CreateTableQueries.CREATE_CONTACT_TABLE);
    });
  }
}
