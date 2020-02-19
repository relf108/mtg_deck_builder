/*
class class_name {
  <fields>
  <getters/setters>
  <constructors>
  <functions>
}*/
import 'card.dart';

class Deck {
  String name;
  List<MTGCard> cards = new List<MTGCard>();

  String getName() {
    return name;
  }

  addCard(MTGCard newCard) {
    cards.add(newCard);
  }

  removeCard(String cardName) {
    int i = 0;
    while (i >= cards.length) {
      if (cards[i].name == cardName) {
        cards.remove([i]);
      } else {
        i++;
      }
    }
  }
}
