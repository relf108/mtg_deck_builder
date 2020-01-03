import 'package:flutter/material.dart';
import 'package:mtg_deck_builder_mobile/StorageObjects/deckStorage.dart';

import '../StorageObjects/deckStorage.dart';
import 'deck_builder.dart';

void main() {
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
  // DeckStorage deckStorage = new DeckStorage();
  String _url = 'lib/output-onlinepngtools.png';

  Widget deckIcon(String name) {
    return Column(children: <Widget>[
      Container(
          padding: EdgeInsets.fromLTRB(0.0, 15.0, 15.0, 15.0),
          child: ConstrainedBox(
              constraints: BoxConstraints.expand(width: 120.0, height: 120.0),
              child: FlatButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Center(child: DeckBuilder())));
                  },
                  child: Image.asset(_url)))),
      Container(
          // constraints: BoxConstraints.expand(width: 20.0, height: 20.0),
          child: Text(name))
    ]);
  }

  @override
  Widget build(BuildContext context) {
//    print(loadCardDB()); //Why does this return "Instance of 'Future<dynamic>'" instead of a card object?

    // ignore: missing_return
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: CustomScrollView(primary: false, slivers: <Widget>[
          SliverPadding(
              padding: const EdgeInsets.all(10),
              sliver: SliverGrid.count(
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                  children: getDeckIcons()))
        ]));
    // displayDecks());
  }

  List<Widget> getDeckIcons() {
    List<Widget> deckIconList = new List<Widget>();
    int i = 0;
    while (i <= DeckStorage.decks.length) {
      if (i != 0) {
        Widget newDeckIcon = deckIcon(DeckStorage.decks[i - 1].getName());
        deckIconList.add(newDeckIcon);
      } else {
        Widget newDeckIcon = deckIcon("Add deck");
        deckIconList.add(newDeckIcon);
      }
      i++;
    }
    return deckIconList;
  }
}
