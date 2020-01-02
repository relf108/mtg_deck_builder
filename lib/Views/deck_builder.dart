import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:mtg_deck_builder_mobile/Objects/deck.dart';

import '../StorageObjects/deckStorage.dart';

class DeckBuilder extends StatefulWidget {
  @override
  _DeckBuilderState createState() => _DeckBuilderState();
}

class _DeckBuilderState extends State<DeckBuilder> {
  Deck newDeck = new Deck();

  final textController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
          new Stack /*stacks can take children while containers cant*/ (
        children: [
          Container(
            child: Text(
              "Enter Deck name here"
                  
            ),
            padding: EdgeInsets.fromLTRB(30.0, 50.0,30.0, 15.0),
          ),
          Container(
            child: TextField(
              controller: textController,
              autocorrect: true,
            ),
            padding: EdgeInsets.fromLTRB(30.0, 50.0,30.0, 15.0),
          )
          ,
          new Container(
            alignment: Alignment.bottomLeft,
            child: new RaisedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: new Text("Back"),
            ),
          ),
          new Container(
            alignment: Alignment.bottomRight,
            child: new RaisedButton(
              onPressed: () {
                if (textController.text.toString() != ""){
                  newDeck.name = textController.text.toString();
                }
                else{
                  newDeck.name = "Unnamed Deck";
                }
                DeckStorage.decks.add(newDeck);
                Navigator.pop(context);
              },
              child: new Text(
                  "Done"), //this button needs to return deck data to main
            ),
          ),
        ],
      ),
    );
  }
}

@override
State<StatefulWidget> createState() {
  // TODO: implement createState
  return null;
}
