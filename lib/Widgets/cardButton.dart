import 'package:flutter/material.dart';
import 'package:mtg_deck_builder_mobile/Objects/card.dart';
import 'package:mtg_deck_builder_mobile/Objects/deck.dart';

class CardButton extends StatelessWidget {
  List<MTGCard> cardList;
  int i;
  Deck deck;

  CardButton(List<MTGCard> newCardList, int newInt, Deck newDeck) {
    cardList = newCardList;
    i = newInt;
    deck = newDeck;
  }

  @override
  Widget build(BuildContext context) {
    return cardButton(cardList, i, deck);
  }

  Widget cardButton(List<MTGCard> cardList, int i, Deck deck) {
    return Container(
      child: FlatButton(
        child: Text(cardList[i].cardName +
            "\n Mana cost: " +
            cardList[i].manaCost +
            "\n Keywords: " +
            cardList[i].keyword +
            "\n Effects: " +
            cardList[i].etbEffect +
            " " +
            cardList[i].tapEffect +
            "\n Power/Toughness: " +
            cardList[i].power.toString() +
            "/" +
            cardList[i].toughness.toString()),
        onPressed: () {
          deck.addCard(cardList[i]);
        },
        color: Color.fromARGB(100, 34, 139, 34),
      ),
      padding: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 15.0),
    );
  }
}
