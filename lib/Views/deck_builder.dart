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

  Future<List<MTGCard>> cardList;
  Future<MTGCard> card;
  String cardName;

  void initState() {
    super.initState();
    cardList = initHelper();
  }

  initHelper() {
    cardList = loadCardDB();
    //card.printCard();
    return cardList;
  }

  Future<List<MTGCard>> loadCardDB() async {
    String cardDB = await _loadCardDB();

    return _parseJsonForCardDB(cardDB);
    //if you just print cardDB here it returns what i want but i cant return cardDb as a string without it printing "Instance of 'Future<dynamic>'".
  }

  List<MTGCard> _parseJsonForCardDB(String jsonString) {
    /*Map decoded = jsonDecode(jsonString);
     MTGCard card = MTGCard.fromJson(decoded);*/

    //List<MTGCard> cardList = json.decode(jsonString).map((Map m)=> MTGCard.fromJson(m)).toList();
    return iterateJson(jsonString);
  }

  List<MTGCard> iterateJson(String jsonStr) {
    List<MTGCard> cards = new List<MTGCard>();
    List<dynamic> myMap = json.decode(jsonStr);
    int i = 0;
    while (i < myMap.length) {
      //MTGCard newCards = new MTGCard(myMap[i][0], myMap[i][1], myMap[i][2], myMap[i][3], myMap[i][4], myMap[i][5], myMap[i][6]);
      MTGCard newCard = MTGCard.fromJson(myMap[i]);
      cards.add(newCard);
      i++;
    }
    return cards;

//    return cardList;
  }

  Future<String> _loadCardDB() async {
    return await rootBundle.loadString('lib/cardDB.json');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Build Deck",
      home: Scaffold(
        body: FutureBuilder<List<MTGCard>>(
            future: cardList,
            builder: (BuildContext contextFuture,
                AsyncSnapshot<List<MTGCard>> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                List<MTGCard> cardList = snapshot.data;
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
                       child: Wrap(children: buildCardButtons(cardList))
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

  List<Widget> buildCardButtons(List<MTGCard> cardList) {
    List<Widget> cardButtonList = new List<Widget>();
    int i = 0;
    while (i < cardList.length) {
      Widget newCardButton = cardButton(cardList, i);
      cardButtonList.add(newCardButton);
      i++;
    }

    return cardButtonList;
  }

  Widget cardButton(List<MTGCard> cardList, int i) {
    return Container(
      child: FlatButton(
        child: Text(cardList[i].cardName),
        onPressed: () {
          newDeck.addCard(cardList[i]);
        },
        color: Color.fromARGB(100, 34, 139, 34),
      ),
      padding: EdgeInsets.fromLTRB(30.0, 200.0, 30.0, 15.0),
    );
  }
}
