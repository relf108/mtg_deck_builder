import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:mtg_deck_builder_mobile/Objects/card.dart';
import 'package:mtg_deck_builder_mobile/Objects/deck.dart';
import 'package:mtg_deck_builder_mobile/StorageObjects/emailStorage.dart';
import 'package:mtg_deck_builder_mobile/Widgets/cardButton.dart';

import '../StorageObjects/deckStorage.dart';

class DeckBuilder extends StatefulWidget {
  Deck deck;

  DeckBuilder(Deck newDeck) {
    deck = newDeck;
  }

  @override
  _DeckBuilderState createState() => _DeckBuilderState(deck);
}

class _DeckBuilderState extends State<DeckBuilder> {
  Deck newDeck = new Deck();

  _DeckBuilderState(Deck deck) {
    newDeck = deck;
  }

  final textController = TextEditingController();

  @override
  void dispose() {
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
  }

  List<MTGCard> _parseJsonForCardDB(String jsonString) {
    return iterateJson(jsonString);
  }

  List<MTGCard> iterateJson(String jsonStr) {
    List<MTGCard> cards = new List<MTGCard>();
    List<dynamic> myMap = json.decode(jsonStr);
    int i = 0;
    while (i < myMap.length) {
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
                      child: Text("Enter Deck name here",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25)),
                      padding: EdgeInsets.fromLTRB(30.0, 50.0, 30.0, 15.0),
                    ),
                    Container(
                      child: TextField(
                        controller: textController,
                        autocorrect: true,
                      ),
                      padding: EdgeInsets.fromLTRB(30.0, 70.0, 30.0, 120.0),
                    ),
                    Container(
                        child:
                            CustomScrollView(primary: false, slivers: <Widget>[
                          SliverPadding(
                              padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                              sliver: SliverGrid.count(
                                  crossAxisSpacing: 0,
                                  mainAxisSpacing: 0,
                                  crossAxisCount: 1,
                                  children: buildCardButtons(cardList))),
                        ]),
                        padding: EdgeInsets.fromLTRB(30.0, 120.0, 30.0, 15.0)),
                    new Container(
                      alignment: Alignment.bottomLeft,
                      child: new RaisedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: new Text("Cancel"),
                      ),
                    ),
                    new Container(
                      alignment: Alignment.bottomCenter,
                      child: new RaisedButton(
                        onPressed: () async {
                          if(EmailStorage.email != "") {
                            final String password = 'XX3ixh\\S?<g5';
                            final smtpServer =
                            gmail(
                                'mtg.deck.builder.mobile@gmail.com', password);
                            final message = Message();
                            message.from =
                                Address('mtg.deck.builder.mobile@gmail.com',
                                    'MTG Deck builder');
                            message.recipients.add(EmailStorage.email);
                            message.subject =
                            'Test Dart Mailer library :: 😀 :: ${DateTime
                                .now()}';
                            message.text =
                            'This is the plain text.\nThis is line 2 of the text part.';
                            try {
                              final sendReport = await send(
                                  message, smtpServer);
                              print('Message sent: ' + sendReport.toString());
                            } on MailerException catch (e) {
                              print('Message not sent.');
                              for (var p in e.problems) {
                                print('Problem: ${p.code}: ${p.msg}');
                              }
                            }

                            Navigator.pop(context);
                          }
                          else{
                            print("Enter email");
                            Navigator.pop(context);
                          }
                          },
                        child: new Text("Export deck"),
                      ),
                    ),
                    new Container(
                      alignment: Alignment.bottomRight,
                      child: new RaisedButton(
                        onPressed: () {
                          if ((textController.text.toString() != "") &&
                              (newDeck.getName() == null)) {
                            newDeck.name = textController.text.toString();
                            DeckStorage.decks.add(newDeck);
                            Navigator.pop(context);
                          } else if ((textController.text.toString() != "") &&
                              newDeck.getName() != null) {
                            //Do nothing
                            newDeck.name = textController.text.toString();
                            Navigator.pop(context);
                          } else if ((textController.text.toString() == "") &&
                              newDeck.getName() != null) {
                            //Do nothing
                            Navigator.pop(context);
                          } else if ((newDeck.getName() == null) &&
                              (textController.text.toString() == "")) {
                            newDeck.name = "Unnamed Deck";
                            DeckStorage.decks.add(newDeck);
                            Navigator.pop(context);
                          }
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
      Widget newCardButton = new CardButton(cardList, i, newDeck);
      cardButtonList.add(newCardButton);
      i++;
    }

    return cardButtonList;
  }
}
