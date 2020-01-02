import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:mtg_deck_builder_mobile/Objects/card.dart';
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

  Future<MTGCard> card;
  String cardName;

  void initState() {
    super.initState();
    card = initHelper();
  }

  initHelper() {
    card = loadCardDB();
    //card.printCard();
    return card;
  }

  Future<MTGCard> loadCardDB() async {
    String cardDB = await _loadCardDB();

    return _parseJsonForCardDB(cardDB);
    //if you just print cardDB here it returns what i want but i cant return cardDb as a string without it printing "Instance of 'Future<dynamic>'".
  }

  MTGCard _parseJsonForCardDB(String jsonString) {
    Map decoded = jsonDecode(jsonString);

    return MTGCard.fromJson(decoded);
  }

  Future<String> _loadCardDB() async {
    return await rootBundle.loadString('lib/cardDB.json');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Build Deck",
      home: Scaffold(
        body: FutureBuilder<MTGCard>(
            future: card,
            builder: (BuildContext contextFuture, AsyncSnapshot<MTGCard> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                MTGCard card = snapshot.data;
                return Stack /*stacks can take children while containers cant*/ (
                  children: [
                    Container(
                      child: Text("Enter Deck name here"),
                      padding: EdgeInsets.fromLTRB(30.0, 50.0, 30.0, 15.0),
                    ),
                    Container(
                      child: TextField(
                        controller: textController,
                        autocorrect: true,
                      ),
                      padding: EdgeInsets.fromLTRB(30.0, 70.0, 30.0, 15.0),
                    ),
                    Container(
                      //Seperate this widget into its own method and load it into a Wrap
                      child: FlatButton(
                          child: Text(card.cardName),
                          onPressed: (){
                            newDeck.addCard(card);
                          },
                        color: Color.fromARGB(100, 34, 139, 34),

                      ),
                      padding: EdgeInsets.fromLTRB(30.0, 200.0, 30.0, 15.0),
                    ),
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
                          if (textController.text.toString() != "") {
                            newDeck.name = textController.text.toString();
                          } else {
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
                );
              }
            }),
      ),
    );
  }
}
