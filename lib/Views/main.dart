import 'package:flutter/material.dart';
import 'package:mtg_deck_builder_mobile/Objects/deck.dart';
import 'package:mtg_deck_builder_mobile/StorageObjects/deckStorage.dart';
import 'package:mtg_deck_builder_mobile/Views/setup.dart';
import 'package:mtg_deck_builder_mobile/Widgets/deckIcon.dart';
import 'package:sqflite/sqflite.dart';
import '../StorageObjects/deckDAO.dart';
import '../StorageObjects/deckStorage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  var deleteDB = false;
  if (deleteDB){
    DeckDAO().deleteDB();
  }
  DeckDAO().createDB();
  runApp(MaterialApp(
    title: 'MTGA Mobile deck builder',
    home: MyHomePage(title: 'MTGA Mobile Deck Builder'),
  ));
}

class MyHomePage extends StatefulWidget {
  MyHomePage({this.title});

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
//    print(loadCardDB()); //Why does this return "Instance of 'Future<dynamic>'" instead of a card object?

    // ignore: missing_return
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: <Widget>[
            Container(
                child: FloatingActionButton(
                    child: Icon(Icons.settings),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Setup()),
                      );
                    }))
          ],
        ),
        body: Stack(children: <Widget>[
          CustomScrollView(primary: false, slivers: <Widget>[
            SliverPadding(
                padding: const EdgeInsets.all(10),
                sliver: SliverGrid.count(
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 2,
                    children: getDeckIcons()))
          ]),
        ]));
    // displayDecks());
  }

  List<Widget> getDeckIcons() {
    List<Widget> deckIconList = new List<Widget>();
    int i = 0;
    while (i <= DeckStorage.decks.length) {
      if (i != 0) {
        Widget newDeckIcon = new DeckIcon(
            DeckStorage.decks[i - 1], DeckStorage.decks[i - 1].getName());
        deckIconList.add(newDeckIcon);
      } else {
        Widget newDeckIcon = new DeckIcon(new Deck(), "Add deck");
        deckIconList.add(newDeckIcon);
      }
      i++;
    }
    return deckIconList;
  }
}
