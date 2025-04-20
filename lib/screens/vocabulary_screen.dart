import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/vocabulary_provider.dart';
import '../services/dictionary_api.dart';
import '../services/image_api.dart';
import '../services/vocabulary_api.dart';

class VocabularyScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<VocabularyScreen> createState() => _VocabularyScreenState();
}

class _VocabularyScreenState extends ConsumerState<VocabularyScreen> {
  List<String> words = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchWordsFromApi();
  }

  Future<void> fetchWordsFromApi() async {
    final fetchedWords = await VocabularyApi.fetchWordList();
    setState(() {
      words = fetchedWords;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final favorites = ref.watch(favoriteWordsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Học Từ Vựng"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: "Làm mới danh sách",
            onPressed: fetchWordsFromApi,
          )
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.9,
        ),
        itemCount: words.length,
        itemBuilder: (context, index) {
          final word = words[index];
          final isFavorite = favorites.contains(word);

          return GestureDetector(
            onTap: () async {
              final definition = await DictionaryService.fetchDefinition(word);
              final vietnamese = await DictionaryService.translateToVietnamese(word);

              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text(word),
                  content: Text(
                    "📘 Tiếng Anh: ${definition ?? "Không có dữ liệu."}\n\n🇻🇳 Tiếng Việt: ${vietnamese ?? "Không có dữ liệu."}",
                  ),
                ),
              );
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: FutureBuilder<String?>(
                      future: ImageApi.fetchImageUrl(word),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasData && snapshot.data != null) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.network(
                              snapshot.data!,
                              height: 80,
                              width: 80,
                              fit: BoxFit.cover,
                            ),
                          );
                        } else {
                          return const Icon(Icons.image, size: 60);
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    word,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : Colors.grey,
                    ),
                    onPressed: () => ref.read(favoriteWordsProvider.notifier).toggleFavorite(word),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
