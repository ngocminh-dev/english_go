import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/vocabulary_provider.dart';

class FavoriteScreen extends ConsumerWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoriteWordsProvider);

    return Scaffold(
      appBar: AppBar(title: Text("Từ Vựng Yêu Thích")),
      body: favorites.isEmpty
          ? Center(child: Text("Chưa có từ nào được lưu."))
          : ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          final word = favorites[index];
          return ListTile(
            title: Text(word),
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () => ref.read(favoriteWordsProvider.notifier).toggleFavorite(word),
            ),
          );
        },
      ),
    );
  }
}
