import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeechService {
  static final FlutterTts _tts = FlutterTts();

  static Future<void> speakEnglish(String text) async {
    await _tts.setLanguage("en-US");
    await _tts.setPitch(1.0);
    await _tts.setSpeechRate(0.5);
    await _tts.speak("English: $text");
    await _tts.awaitSpeakCompletion(true);
  }
  static Future<void> speakVietnamese(String text) async {
    await _tts.setLanguage("vi-VN");
    await _tts.setPitch(1.0);
    await _tts.setSpeechRate(0.5);
    await _tts.speak("Tiếng Việt: $text");
    await _tts.awaitSpeakCompletion(true);
  }

  static Future<void> stop() async {
    await _tts.stop();
  }
}
