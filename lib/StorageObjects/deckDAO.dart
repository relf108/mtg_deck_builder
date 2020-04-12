import 'dart:async';
import 'package:mtg_deck_builder_mobile/object/deck.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DeckDAO{
  static DeckDAO _self = DeckDAO._internal();
  static Database database;
  static String databasePath;
  String path;

  var initialised = Completer<String>();

  factory DeckDAO(){
    return _self;
  }

  void createDB() async {
    openDB();

    //await deleteDatabase(path);

// open the database
  }
  void openDB() async {

    await initialised.future;
    Database databaseTemp = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
            await db.execute(
                'CREATE TABLE Decks (id INTEGER PRIMARY KEY, deckName TEXT, cardsNum INTEGER, cards INTEGER);');
            await db.execute(
                'CREATE TABLE Email (id INTERGER PRIMARY KEY, email TEXT);');


        }
    );

    database = databaseTemp;
// Insert some records in a transaction

  }

  DeckDAO._internal() {
     initPath().then((_) {
       path = join(databasePath, 'deck.db');
       initialised.complete(path);
     });
  }

  Future<void> initPath() async {
    databasePath = await getDatabasesPath();
  }

  Future<void> deleteDB() async {
    await deleteDatabase(path);
  }

  Future<void> addDeck(Deck deck, int cardsNum) async {
    await database.execute('CREATE TABLE Cards (cardName TEXT)');
    for (int i = 0; i <= cardsNum; i++){
      await database.transaction((txn) async {
        await txn.rawInsert(
            'INSERT INTO Cards(cardName) VALUES(?)',<String>[deck.cards[i].name]);
      });
    }

  }

  Future<String> getEmail() async{
    List<Map> list = await database.rawQuery('SELECT email FROM Email');
    String email = list[0].toString();
    String emailTrim = email.substring(8, email.length -1);
    return emailTrim;
  }
  Future<String> getDecks() async{
    List<Map> list = await database.rawQuery('Select * from Decks');
    return list.toString();

  }
}