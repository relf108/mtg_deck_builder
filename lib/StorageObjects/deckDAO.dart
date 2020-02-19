import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DeckDAO{
  static DeckDAO _self = DeckDAO._internal();
  static Database database;

  factory DeckDAO(){
    return _self;
  }

  void createDB() async {
    var databasesPath = await getDatabasesPath();
    String path = (databasesPath + 'deck.db');
    openDB(path);

    //await deleteDatabase(path);

// open the database
  }
  openDB( String path) async {

    Database databaseTemp = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
            await db.execute(
                'CREATE TABLE Test (id INTEGER PRIMARY KEY, deckName TEXT, cardsNum INTEGER)');
          }
    );

    database = databaseTemp;
// Insert some records in a transaction

  }

  DeckDAO._internal();
}