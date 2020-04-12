import 'card/mtg_card.dart';

class Deck {
  String name;
  List<MTGCard> cards =  List<MTGCard>();

  String getName() {
    return name;
  }

  void addCard(MTGCard newCard) {
    cards.add(newCard);
  }

  void removeCard(String cardName) {
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
