import 'dart:async';

import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class AppDatabase {
  static final AppDatabase _appDatabase = AppDatabase._internal();

  static AppDatabase get instance => _appDatabase;

  // Database? db;
  Completer<Database>? _dbOpenCompleter;

  AppDatabase._internal();

  Future<Database> get database async {
    if (_dbOpenCompleter == null) {
      _dbOpenCompleter = Completer();
      _openDatabase();
    }

    return _dbOpenCompleter!.future;
  }

  Future _openDatabase() async {
    ///Database connection
    // get the application documents directory
    var dir = await getApplicationDocumentsDirectory();
    // make sure it exists
    await dir.create(recursive: true);
    // build the database path
    // var dbPath = cs.join(dir.path, 'chat_database.db');
    // // open the database
    // var db = await databaseFactoryIo.openDatabase(dbPath);

    // _dbOpenCompleter?.complete(db);
  }
}