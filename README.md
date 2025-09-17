# 🎮 Tic-Tac-Toe iOS

A modern, feature-rich Tic-Tac-Toe game built with SwiftUI, featuring intelligent AI opponents and smooth animations.

![iOS](https://img.shields.io/badge/iOS-15.0+-blue.svg)
![Swift](https://img.shields.io/badge/Swift-5.0+-orange.svg)
![SwiftUI](https://img.shields.io/badge/SwiftUI-2.0+-green.svg)
![License](https://img.shields.io/badge/License-MIT-yellow.svg)

## ✨ Features

### 🎯 Game Modes
- **Player vs Player** - Classic local multiplayer
- **Player vs Computer** - Challenge AI opponents with varying difficulty levels

### 🤖 AI Difficulty Levels
- **Easy** - Random move selection for casual play
- **Medium** - Strategic rule-based AI that blocks wins and takes opportunities
- **Hard** - Unbeatable minimax algorithm implementation

### 🎨 User Interface
- Clean, modern SwiftUI design
- Smooth animations and transitions
- Winning line highlighting
- Real-time game status updates
- Intuitive touch controls

### 📱 Technical Features
- **MVVM Architecture** - Clean separation of concerns
- **Combine Framework** - Reactive programming patterns
- **ObservableObject** - State management
- **Custom AI Engine** - Multiple difficulty algorithms
- **Responsive Design** - Adapts to different screen sizes

## 🏗️ Architecture

The app follows a clean MVVM (Model-View-ViewModel) architecture pattern:

```
├── Models/
│   ├── GameModel.swift      # Core game logic and state
│   ├── Player.swift         # Player enumeration
│   └── GameMode.swift       # Game modes and difficulty levels
├── ViewModels/
│   └── GameViewModel.swift  # Business logic and state management
├── Views/
│   ├── ContentView.swift    # Main game container
│   ├── GameBoardView.swift  # 3x3 grid layout
│   ├── GameCellView.swift   # Individual cell component
│   ├── GameStatusView.swift # Status display
│   └── GameModePickerView.swift # Mode selection interface
└── AI/
    └── GameAI.swift         # AI algorithms and strategies
```

## 🚀 Getting Started

### Prerequisites
- Xcode 13.0 or later
- iOS 15.0 or later
- Swift 5.0 or later

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/tic-tac-toe-ios.git
   cd tic-tac-toe-ios
   ```

2. **Open in Xcode**
   ```bash
   open TicTacToe.xcodeproj
   ```

3. **Build and Run**
   - Select your target device or simulator
   - Press `Cmd + R` to build and run

## 🎮 How to Play

### Starting a Game
1. Launch the app
2. Select your preferred game mode:
   - **Player vs Player** for local multiplayer
   - **Player vs Computer** for AI challenge
3. If playing against AI, choose difficulty level
4. Tap "Start Game"

### Gameplay
- Player X always goes first
- Tap any empty cell to place your mark
- First player to get three marks in a row wins
- Game automatically detects wins and draws
- Winning cells are highlighted in green

### Game Controls
- **New Game** - Start fresh with current settings
- **Change Mode** - Switch between game modes
- **Auto-save** - Game state persists during app lifecycle

## 🤖 AI Implementation

### Easy AI
- **Strategy**: Random move selection
- **Difficulty**: Beginner-friendly
- **Implementation**: Simple random selection from available positions

### Medium AI
- **Strategy**: Rule-based decision making
- **Logic Priority**:
  1. Win if possible
  2. Block opponent's winning move
  3. Take center position
  4. Take corner positions
  5. Take any available position

### Hard AI
- **Strategy**: Minimax algorithm with alpha-beta pruning
- **Behavior**: Mathematically optimal play
- **Result**: Unbeatable - will win or draw every game
- **Depth**: Evaluates all possible game states

## 🔧 Technical Details

### Key Components

#### GameModel
```swift
class GameModel: ObservableObject {
    @Published var board: [Player?]
    @Published var currentPlayer: Player
    @Published var gameState: GameState
    // Core game logic implementation
}
```

#### GameViewModel
```swift
class GameViewModel: ObservableObject {
    @Published var gameModel: GameModel
    @Published var isThinking: Bool
    // Handles UI interactions and AI coordination
}
```

#### GameAI
```swift
class GameAI {
    func getBestMove(board: [Player?], difficulty: Difficulty, aiPlayer: Player) -> Int?
    // Implements multiple AI strategies
}
```

### State Management
- Uses `@Published` properties for reactive UI updates
- Combine framework for handling async AI moves
- Clean separation between game logic and presentation

### Animation System
- SwiftUI native animations for smooth transitions
- Custom timing for AI move delays
- Visual feedback for winning combinations

## 🎨 Customization

### Themes
The app uses a clean, modern design that can be easily customized:

- **Colors**: Modify in individual view files
- **Fonts**: System fonts with custom weights
- **Animations**: Adjustable timing in view implementations

### AI Difficulty
Want to add new difficulty levels? Extend the `Difficulty` enum and implement new strategies in `GameAI.swift`:

```swift
enum Difficulty: String, CaseIterable {
    case easy = "Easy"
    case medium = "Medium"
    case hard = "Hard"
    case expert = "Expert" // Your new difficulty
}
```

## 📱 Screenshots

*Add your app screenshots here showcasing:*
- Main game interface
- Mode selection screen
- Winning state
- AI thinking indicator

## 🧪 Testing

The modular architecture makes the app highly testable:

- **Unit Tests**: Test game logic in isolation
- **AI Tests**: Verify AI behavior and move selection
- **Integration Tests**: Test ViewModel coordination
- **UI Tests**: Automated gameplay scenarios

## 📈 Performance

- **Memory Efficient**: Lightweight data structures
- **Battery Optimized**: Minimal background processing
- **Responsive**: 60fps animations and interactions
- **AI Optimized**: Efficient minimax implementation

## 🔮 Future Enhancements

- [ ] Online multiplayer support
- [ ] Game statistics and win tracking
- [ ] Custom themes and color schemes
- [ ] Haptic feedback integration
- [ ] Game replay system
- [ ] Tournament mode
- [ ] Accessibility improvements
- [ ] Apple Watch companion app

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

### Development Guidelines
1. Follow Swift style conventions
2. Maintain MVVM architecture
3. Add unit tests for new features
4. Update documentation as needed

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- SwiftUI community for inspiration and best practices
- Apple's Human Interface Guidelines for design principles
- Minimax algorithm implementations and optimizations

## 📞 Support

Having issues? Found a bug? Have a feature request?

- 🐛 [Report Bug](https://github.com/yourusername/tic-tac-toe-ios/issues)
- 💡 [Request Feature](https://github.com/yourusername/tic-tac-toe-ios/issues)
- 📧 [Contact Developer](mailto:your.email@example.com)

---

**Built with ❤️ using SwiftUI**

*Enjoy playing Tic-Tac-Toe! 🎮*
