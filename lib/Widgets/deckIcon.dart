import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mtg_deck_builder_mobile/Objects/deck.dart';
import 'package:mtg_deck_builder_mobile/Views/deck_builder.dart';

class DeckIcon extends StatelessWidget {
  Deck deck;
  String name;

  DeckIcon(Deck newDeck, String newName) {
    deck = newDeck;
    name = newName;
  }

  @override
  Widget build(BuildContext context) {
    return deckIcon(deck, name, context);
  }

  Widget deckIcon(Deck deck, String name, BuildContext context) {
    String _url = 'lib/output-onlinepngtools.png';
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
                                Center(child: DeckBuilder(deck))));
                  },
                  child: Image.asset(_url)))),
      Container(
          // constraints: BoxConstraints.expand(width: 20.0, height: 20.0),
          child: Text(name))
    ]);
  }
}
