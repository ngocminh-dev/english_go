import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:english_go/providers/theme_provider.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late stt.SpeechToText _speech;
  late FlutterTts _tts;
  bool _isListening = false;
  String _lastWords = "";

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _tts = FlutterTts();
    _tts.setLanguage("vi-VN");
    _tts.setSpeechRate(0.5);
  }

  void _startListening() async {
    bool available = await _speech.initialize();

    if (available) {
      final locales = await _speech.locales();
      final vietnameseLocale = locales.firstWhere(
            (locale) => locale.localeId.contains('vi'),
        orElse: () => locales.first,
      );

      setState(() => _isListening = true);

      _speech.listen(
        localeId: vietnameseLocale.localeId,
        onResult: (result) {
          if (result.finalResult) {
            setState(() {
              _lastWords = result.recognizedWords.toLowerCase();
            });
            _handleVoiceCommand(_lastWords);
          }
        },
      );
    } else {
      debugPrint("Speech recognition không khả dụng trên thiết bị này.");
    }
  }

  Future<void> _speak(String text) async {
    await _tts.stop();
    await _tts.speak(text);
  }

  void _handleVoiceCommand(String command) {
    if (command.contains('từ vựng')) {
      _speak("Đang mở từ vựng");
      Navigator.pushNamed(context, '/vocabulary');
      _speech.stop();
    } else if (command.contains('ngữ pháp')) {
      _speak("Đang mở ngữ pháp");
      Navigator.pushNamed(context, '/grammar');
      _speech.stop();
    } else if (command.contains('kiểm tra')) {
      _speak("Đang mở chế độ Quiz");
      Navigator.pushNamed(context, '/quiz');
      _speech.stop();
    } else if (command.contains('yêu thích')) {
      _speak("Đang mở danh sách yêu thích");
      Navigator.pushNamed(context, '/favorites');
      _speech.stop();
    } else {
      _speak("Xin lỗi, tôi chưa hiểu lệnh vừa rồi");
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeProvider);
    final isDark = themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Ứng dụng học tiếng Anh"),
        actions: [
          IconButton(
            icon: Icon(_isListening ? Icons.hearing : Icons.mic),
            tooltip: "Điều khiển bằng giọng nói",
            onPressed: _startListening,
          ),
          IconButton(
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
            onPressed: () {
              ref.read(themeProvider.notifier).toggleTheme();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Chọn chế độ học",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 12),
            if (_lastWords.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.yellow.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "Bạn vừa nói: \"$_lastWords\"",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: 0.95,
                children: [
                  _buildAnimatedMenuCard(
                    context,
                    icon: Icons.menu_book,
                    label: "Từ vựng",
                    onTap: () => Navigator.pushNamed(context, '/vocabulary'),
                  ),
                  _buildAnimatedMenuCard(
                    context,
                    icon: Icons.rule,
                    label: "Ngữ pháp",
                    onTap: () => Navigator.pushNamed(context, '/grammar'),
                  ),
                  _buildAnimatedMenuCard(
                    context,
                    icon: Icons.quiz,
                    label: "Quiz",
                    onTap: () => Navigator.pushNamed(context, '/quiz'),
                  ),
                  _buildAnimatedMenuCard(
                    context,
                    icon: Icons.favorite,
                    label: "Yêu thích",
                    onTap: () => Navigator.pushNamed(context, '/favorites'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedMenuCard(
      BuildContext context, {
        required IconData icon,
        required String label,
        required VoidCallback onTap,
      }) {
    return InkWell(
      borderRadius: BorderRadius.circular(25),
      onTap: onTap,
      child: Ink(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).primaryColor.withOpacity(0.85),
              Theme.of(context).primaryColor.withOpacity(0.65),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).primaryColor.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 48, color: Colors.white),
              const SizedBox(height: 12),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
