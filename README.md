# English Go 🌟

Chào mừng bạn đến với **English Go** — một ứng dụng Flutter giúp bạn học từ vựng, ngữ pháp và làm quiz trắc nghiệm cực kỳ sinh động và thú vị!

---

## ✨ Tính Năng

- Học từ vựng tiếng Anh qua danh sách từ tự động (API).
- Hiển thị ảnh minh họa tự động bằng Unsplash API.
- Dịch nghĩa từ vựng sang tiếng Việt (Dictionary API).
- Lưu lại từ vựng yêu thích.
- Chức năng học Ngữ Pháp chia theo cấp độ (Beginner, Intermediate, Advanced).
- Quiz trắc nghiệm tương tác.

---

## 🚀 Cài Đặt

### 1. Clone project
```bash
git https://github.com/ngocminh-dev/english_go.git
cd english-go
```

### 2. Cài đặt Flutter package
```bash
flutter pub get
```

### 3. Cấu hình Unsplash API Key
Do dùng cho mục đích học tập và để giảng viên dễ dàng khởi chạy 
nên API của Unsplash mình để ở trong code luôn

---

### 4. Chạy project
```bash
flutter run
```

🎉 Hoàn thành! Bạn có thể trải nghiệm ngay trên thời gian thật!

---

## 🏢 Cấu trúc thư mục

```
lib
├── main.dart
├── providers
│   ├── theme_provider.dart
│   └── vocabulary_provider.dart
├── screens
│   ├── favorite_screen.dart
│   ├── grammar_screen.dart
│   ├── home_screen.dart
│   ├── quiz_screen.dart
│   └── vocabulary_screen.dart
├── services
│   ├── dictionary_api.dart
│   ├── grammar_service.dart
│   ├── image_api.dart
│   ├── text_to_speech_service.dart
│   └── vocabulary_api.dart
└── theme.dart
```
---

## 🔧 Build Release (Android)
```bash
flutter build apk --release
```

---

## 🌟 Góp ý & Phát triển

Nếu bạn muốn góp ý hay đề xuất tính năng mới, vui lòng tạo Issue hoặc Pull Request!

---

Chúc bạn học tập vui vẻ và thật nhiều từ vựng mới! 🚀🌟

---

❤️ Built with Flutter by ngocminh-dev.

