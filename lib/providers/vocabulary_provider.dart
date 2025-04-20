import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoriteWordsProvider = StateNotifierProvider<FavoriteWordsNotifier, List<String>>(
      (ref) => FavoriteWordsNotifier(),
);

class FavoriteWordsNotifier extends StateNotifier<List<String>> {
  FavoriteWordsNotifier() : super([]);

  void toggleFavorite(String word) {
    if (state.contains(word)) {
      state = state.where((w) => w != word).toList();
    } else {
      state = [...state, word];
    }
  }
}
