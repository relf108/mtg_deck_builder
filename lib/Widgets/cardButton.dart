import 'package:flutter/material.dart';
import 'package:mtg_deck_builder_mobile/object/card/mtg_card.dart';
import 'package:mtg_deck_builder_mobile/object/deck.dart';
@immutable
class CardButton extends StatelessWidget {
  final MTGCard card;
  final Deck deck;

  CardButton(this.card, this.deck);

  @override
  Widget build(BuildContext context) {
    return cardButton();
  }

  Widget cardButton() {
    return Container(
      child: FlatButton(
        child: Text(card.name/* +
            "\n Mana cost: " +
            cardList[i].manaCost *//*+
            "\n Keywords: " +
            cardList[i].keyword +
            "\n Effects: " +
            cardList[i].etbEffect +
            " " +
            cardList[i].tapEffect +
            "\n Power/Toughness: " +
            cardList[i].power.toString() +
            "/" +
            cardList[i].toughness.toString()*/),
        onPressed: () {
          deck.addCard(card);
        },
        color: Color.fromARGB(100, 34, 139, 34),
      ),
      padding: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 15.0),
    );
  }
}
