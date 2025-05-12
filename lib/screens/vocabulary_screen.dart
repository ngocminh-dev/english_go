import 'package:english_go/services/text_to_speech_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/vocabulary_provider.dart';
import '../services/dictionary_api.dart';
import '../services/image_api.dart';
import '../services/vocabulary_api.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class VocabularyScreen extends ConsumerStatefulWidget {
  const VocabularyScreen({super.key});

  @override
  ConsumerState<VocabularyScreen> createState() => _VocabularyScreenState();
}

class _VocabularyScreenState extends ConsumerState<VocabularyScreen> {
  List<String> words = [];
  bool isLoading = true;
  bool isListening = false;
  String spokenText = '';
  stt.SpeechToText speech = stt.SpeechToText();

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

  Future<void> startListening() async {
    bool available = await speech.initialize();
    if (available) {
      setState(() {
        isListening = true;
      });
      speech.listen(
        onResult: (result) {
          setState(() {
            spokenText = result.recognizedWords.trim().toLowerCase();
            isListening = false;
          });
        },
        localeId: 'en_US',
      );
    }
  }

  void checkPronunciation(String word) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text("Phát âm của bạn"),
          content: spokenText.isNotEmpty
              ? Text("Bạn đã nói: \"$spokenText\"")
              : const Text("Không nghe thấy gì!"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (spokenText.trim().toLowerCase() == word.trim().toLowerCase()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("🎉 Chính xác!")),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("❌ Bạn đã nói: \"$spokenText\"")),
                  );
                }
              },
              child: const Text("Đóng"),
            ),
          ],
        );
      },
    );
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
              final definition =
              await DictionaryService.fetchDefinition(word);
              final vietnamese =
              await DictionaryService.translateToVietnamese(word);
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text(word),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "📘 Tiếng Anh: ${definition ?? "Không có dữ liệu."}\n\n🇻🇳 Tiếng Việt: ${vietnamese ?? "Không có dữ liệu."}",
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.mic),
                        label: const Text("Thử phát âm"),
                        onPressed: () {
                          startListening();
                          // Chờ kết quả và so sánh với từ
                          Future.delayed(const Duration(seconds: 3), () {
                            checkPronunciation(word); // Truyền từ vào
                          });
                        },
                      ),
                    ],
                  ),
                ),
              );
              await TextToSpeechService.speakEnglish(
                  "$word. $definition");
              await TextToSpeechService.speakVietnamese(
                  "$word. $vietnamese");
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
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasData &&
                            snapshot.data != null) {
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
                    onPressed: () => ref
                        .read(favoriteWordsProvider.notifier)
                        .toggleFavorite(word),
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
