import SwiftUI
import Combine

class GameViewModel: ObservableObject {
    @Published var gameModel: GameModel
    @Published var showingModeSelection = true
    @Published var isThinking = false
    
    private let gameAI = GameAI()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        self.gameModel = GameModel()
        setupBindings()
    }
    
    private func setupBindings() {
        // Listen for computer's turn
        gameModel.$currentPlayer
            .combineLatest(gameModel.$gameState, gameModel.$gameMode)
            .sink { [weak self] currentPlayer, gameState, gameMode in
                guard let self = self else { return }
                
                if case .playing = gameState,
                   gameMode == .playerVsComputer,
                   currentPlayer == .o {
                    self.makeComputerMove()
                }
            }
            .store(in: &cancellables)
    }
    
    func handleCellTap(at position: Int) {
        // Prevent moves during computer's turn
        if gameModel.gameMode == .playerVsComputer && 
           gameModel.currentPlayer == .o && 
           isThinking {
            return
        }
        
        // Make the move
        _ = gameModel.makeMove(at: position)
    }
    
    private func makeComputerMove() {
        isThinking = true
        
        // Add a small delay to make it feel more natural
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            guard let self = self else { return }
            
            if let position = self.gameAI.getBestMove(
                board: self.gameModel.board,
                difficulty: self.gameModel.difficulty,
                aiPlayer: .o
            ) {
                _ = self.gameModel.makeMove(at: position)
            }
            
            self.isThinking = false
        }
    }
    
    func startNewGame() {
        gameModel.reset()
    }
    
    func changeGameMode() {
        showingModeSelection = true
        gameModel.reset()
    }
    
    func confirmGameMode(_ mode: GameMode, difficulty: Difficulty) {
        gameModel.gameMode = mode
        gameModel.difficulty = difficulty
        showingModeSelection = false
        gameModel.reset()
    }
    
    var statusText: String {
        switch gameModel.gameState {
        case .notStarted:
            return "Tap to start"
        case .playing:
            if gameModel.gameMode == .playerVsComputer {
                if gameModel.currentPlayer == .x {
                    return "Your turn"
                } else {
                    return isThinking ? "Computer thinking..." : "Computer's turn"
                }
            } else {
                return "\(gameModel.currentPlayer.displayName)'s turn"
            }
        case .won(let player):
            if gameModel.gameMode == .playerVsComputer {
                return player == .x ? "You won! 🎉" : "Computer won! 🤖"
            } else {
                return "\(player.displayName) wins! 🎉"
            }
        case .draw:
            return "It's a draw! 🤝"
        }
    }
    
    var isGameOver: Bool {
        switch gameModel.gameState {
        case .won, .draw:
            return true
        default:
            return false
        }
    }
}