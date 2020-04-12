import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mtg_deck_builder_mobile/Views/deck_builder.dart';
import 'package:mtg_deck_builder_mobile/object/deck.dart';

@immutable
class DeckIcon extends StatelessWidget {
  final Deck deck;
  final String name;

  DeckIcon(this.deck, this.name);

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
                    Navigator.push<void>(
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
