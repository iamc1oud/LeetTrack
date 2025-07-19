# DSA Prep Manager

A beautiful Flutter application designed to streamline your Data Structures and Algorithms (DSA) interview preparation. This app helps you organize important interview questions by topic, store pseudocode solutions, track your progress, and focus on what matters most.

<p align="center">
  <img src="https://img.shields.io/badge/Platform-Flutter-blue" alt="Platform">
  <img src="https://img.shields.io/badge/Language-Dart-blue" alt="Language">
  <img src="https://img.shields.io/badge/Storage-Hive-orange" alt="Storage">
  <img src="https://img.shields.io/badge/UI-Material%20Design-purple" alt="UI">
</p>

## 🌟 Features

### Topic Organization
- **Topic Management**: Create and organize DSA topics (Arrays, Linked Lists, Trees, Graphs, Dynamic Programming, etc.)
- **Custom Categories**: Customize your topic structure based on your preparation strategy
- **Topic Descriptions**: Add detailed descriptions for each topic to maintain context

### Question Management
- **Question Repository**: Add important interview questions under each topic
- **Difficulty Levels**: Mark questions as Easy, Medium, or Hard with visual indicators
- **Favorites System**: Star important questions for quick access and focused revision
- **Problem Links**: Add direct links to original problems (LeetCode, HackerRank, Codeforces, etc.)
- **Creation Dates**: Automatically track when questions were added

### Solution Storage
- **Code Solutions**: Store pseudocode or solution approaches with syntax highlighting
- **Notes Support**: Add personal notes, tips, or alternative approaches using Markdown
- **Multi-tab View**: Separate tabs for problem statement, solution, and notes

### User Experience
- **Beautiful UI**: Clean, modern interface with Material Design 3
- **Dark Mode**: Automatic theme switching based on system preferences
- **Responsive Design**: Works on various screen sizes
- **Swipe Actions**: Quick actions using swipe gestures on question cards

### Data Management
- **Local Storage**: All data stored locally using Hive database
- **No Backend Required**: Works completely offline without any server dependencies
- **Fast Performance**: Optimized for speed and responsiveness

## 📱 App Workflow

1. **Create Topics**: Start by creating topics for different DSA concepts
2. **Add Questions**: Add important interview questions under each topic
3. **Store Solutions**: Save your solution approaches and pseudocode
4. **Add Notes**: Include personal notes, tips, or alternative approaches
5. **Mark Favorites**: Star important questions for focused revision
6. **Review**: Use the favorites section for quick revision before interviews

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (2.0 or higher)
- Dart SDK (2.12 or higher)
- Any IDE with Flutter support (VS Code, Android Studio, etc.)

### Installation

1. Clone this repository
   ```bash
   git clone https://github.com/yourusername/dsa-prep-manager.git
   cd dsa-prep-manager
   ```

2. Install dependencies
   ```bash
   flutter pub get
   ```

3. Generate Hive adapters
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. Run the application
   ```bash
   flutter run
   ```

## 📦 Project Structure

```
lib/
├── main.dart                  # Entry point
├── models/                    # Data models
│   ├── topic.dart             # Topic model
│   └── question.dart          # Question model with difficulty enum
├── screens/                   # UI screens
│   ├── home_screen.dart       # Main screen with topics list
│   ├── topic_detail_screen.dart # Topic details with questions list
│   ├── question_detail_screen.dart # Question details with tabs
│   ├── add_question_screen.dart # Add/Edit question form
│   └── favorites_screen.dart  # Favorites collection
├── services/                  # Business logic
│   └── database_service.dart  # Hive database operations
└── theme/                     # UI theme
    └── app_theme.dart         # Light and dark theme definitions
```

## 📚 Dependencies

- **Database**
  - `hive`: ^2.2.3 - NoSQL database for local storage
  - `hive_flutter`: ^1.1.0 - Flutter integration for Hive
  - `hive_generator`: ^2.0.1 - Code generation for Hive
  - `build_runner`: ^2.4.8 - Code generation tool

- **UI Components**
  - `google_fonts`: ^6.1.0 - Beautiful typography
  - `flutter_slidable`: ^3.0.1 - Swipeable actions on cards
  - `flutter_markdown`: ^0.6.20 - Markdown rendering for notes
  - `flutter_syntax_view`: ^4.0.0 - Code syntax highlighting

- **Utilities**
  - `url_launcher`: ^6.2.5 - Opening external links
  - `uuid`: ^4.3.3 - Generating unique IDs

## 🖼️ Screenshots

[Screenshots will be added here]

## 🔮 Future Enhancements

- **Search Functionality**: Quick search across all questions and topics
- **Progress Tracking**: Track solved questions and completion rates
- **Company Tags**: Categorize questions by companies that ask them
- **Spaced Repetition**: Smart revision scheduling based on difficulty
- **Export/Import**: Share your question collection with others
- **Cloud Sync**: Optional cloud backup and synchronization
- **Statistics**: Visual analytics of your preparation progress
- **Custom Tags**: Create your own tagging system for questions
- **Interview Mode**: Practice with timed coding challenges

## 🤝 Contributing

Contributions are welcome! Feel free to open issues or submit pull requests.

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🙏 Acknowledgments

- Thanks to all the coding platforms providing quality DSA problems
- Flutter team for the amazing framework
- Hive database for efficient local storage solution
