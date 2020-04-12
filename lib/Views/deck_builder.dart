import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:mtg_deck_builder_mobile/StorageObjects/deckDAO.dart';
import 'package:mtg_deck_builder_mobile/Widgets/cardButton.dart';
import 'package:mtg_deck_builder_mobile/object/card.dart';
import 'package:mtg_deck_builder_mobile/object/card/mtg_card.dart';
import 'package:mtg_deck_builder_mobile/object/deck.dart';

import '../StorageObjects/deckStorage.dart';
@immutable
class DeckBuilder extends StatefulWidget {
  final Deck deck;

  DeckBuilder(this.deck);

  @override
  _DeckBuilderState createState() => _DeckBuilderState(deck);
}

class _DeckBuilderState extends State<DeckBuilder> {
  Deck newDeck = Deck();

  _DeckBuilderState(Deck deck) {
    newDeck = deck;
  }

  final textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  Future<MTGCard> card;
  String cardName;

  void initState() {
    super.initState();
  }


  Future<Cards> loadCardDB() async {
    Cards cardDB = await Cards.fromJson();

    return cardDB;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Build Deck",
      home: Scaffold(
        body: FutureBuilder<Cards>(
            future: loadCardDB(),
            builder: (BuildContext contextFuture,
                AsyncSnapshot<Cards> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                Cards cards = snapshot.data;
                return Stack /*stacks can take children while containers cant*/ (
                  children: [
                    buildNamePrompt(),
                    buildDeckNameField(),
                    buildCardList(cards),
                     buildCancelButton(context),
                     buildExportButton(context),
                     buildDoneButton(context),
                  ],
                );
              }
            }),
      ),
    );
  }

  Container buildDeckNameField() {
    return Container(
                    child: TextField(
                      controller: textController,
                      autocorrect: true,
                    ),
                    padding: EdgeInsets.fromLTRB(30.0, 70.0, 30.0, 120.0),
                  );
  }

  Container buildNamePrompt() {
    return Container(
                    child: Text("Enter Deck name here",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25)),
                    padding: EdgeInsets.fromLTRB(30.0, 50.0, 30.0, 15.0),
                  );
  }

  Container buildCardList(Cards cards) {
    return Container(
                      child:
                          CustomScrollView(primary: false, slivers: <Widget>[
                        SliverPadding(
                            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                            sliver: SliverGrid.count(
                                crossAxisSpacing: 0,
                                mainAxisSpacing: 0,
                                crossAxisCount: 1,
                                children: buildCardButtons(cards))),
                      ]),
                      padding: EdgeInsets.fromLTRB(30.0, 120.0, 30.0, 15.0));
  }

  Container buildCancelButton(BuildContext context) {
    return Container(
                    alignment: Alignment.bottomLeft,
                    child:  RaisedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child:  Text("Cancel"),
                    ),
                  );
  }

  Container buildExportButton(BuildContext context) {
    return Container(
                    alignment: Alignment.bottomCenter,
                    child:  RaisedButton(
                      onPressed: () async {
                        await sendEmail(context);
                        },
                      child:  Text("Export deck"),
                    ),
                  );
  }

  Future sendEmail(BuildContext context) async {
     DeckDAO db =  DeckDAO();
    String email = await db.getEmail();
    print(email);
    if(email != null) {
      final String password = r'XX3ixh\S?<g5';
      final smtpServer =
      gmail(
          'mtg.deck.builder.mobile@gmail.com', password);
      final message = Message();
      message.from =
          Address('mtg.deck.builder.mobile@gmail.com',
              'MTG Deck builder');
      message.recipients.add(email);
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
        print('Message not sent. $e');
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
  }

  Container buildDoneButton(BuildContext context)  {
    return Container(
                    alignment: Alignment.bottomRight,
                    child:  RaisedButton(
                      onPressed: () async {
                        DeckDAO db =  DeckDAO();
                        if ((textController.text.toString() != "") &&
                            (newDeck.getName() == null)) {
                          newDeck.name = textController.text.toString();
                          DeckStorage.decks.add(newDeck);
                          await db.addDeck(newDeck, newDeck.cards.length);
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
                        print(await db.getDecks());
                      },
                      child:  Text(
                          "Done"), //this button needs to return deck data to main
                    ),
                  );
  }

  List<Widget> buildCardButtons(Cards cards) {
    List<Widget> cardButtonList =  List<Widget>();
    cards.cardMap.forEach((name, card) {
      Widget newCardButton =  CardButton(card, newDeck);
      cardButtonList.add(newCardButton);
    });

    return cardButtonList;
  }
}
