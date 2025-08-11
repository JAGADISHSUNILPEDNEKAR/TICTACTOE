import Foundation

enum GameState {
    case notStarted
    case playing
    case won(Player)
    case draw
}

struct Move {
    let player: Player
    let position: Int
}

class GameModel: ObservableObject {
    @Published var board: [Player?] = Array(repeating: nil, count: 9)
    @Published var currentPlayer: Player = .x
    @Published var gameState: GameState = .notStarted
    @Published var gameMode: GameMode = .playerVsPlayer
    @Published var difficulty: Difficulty = .medium
    
    private let winPatterns: [[Int]] = [
        // Horizontal
        [0, 1, 2],
        [3, 4, 5],
        [6, 7, 8],
        // Vertical
        [0, 3, 6],
        [1, 4, 7],
        [2, 5, 8],
        // Diagonal
        [0, 4, 8],
        [2, 4, 6]
    ]
    
    init() {
        startNewGame()
    }
    
    func startNewGame() {
        board = Array(repeating: nil, count: 9)
        currentPlayer = .x
        gameState = .playing
    }
    
    func makeMove(at position: Int) -> Bool {
        // Check if move is valid
        guard position >= 0 && position < 9,
              board[position] == nil,
              case .playing = gameState else {
            return false
        }
        
        // Make the move
        board[position] = currentPlayer
        
        // Check for win or draw
        if checkWin(for: currentPlayer) {
            gameState = .won(currentPlayer)
        } else if checkDraw() {
            gameState = .draw
        } else {
            // Switch player
            currentPlayer = currentPlayer.opposite
        }
        
        return true
    }
    
    func checkWin(for player: Player) -> Bool {
        for pattern in winPatterns {
            if pattern.allSatisfy({ board[$0] == player }) {
                return true
            }
        }
        return false
    }
    
    func checkDraw() -> Bool {
        return board.allSatisfy { $0 != nil }
    }
    
    func getWinningLine() -> [Int]? {
        guard case .won(let player) = gameState else { return nil }
        
        for pattern in winPatterns {
            if pattern.allSatisfy({ board[$0] == player }) {
                return pattern
            }
        }
        return nil
    }
    
    func getAvailablePositions() -> [Int] {
        return board.enumerated()
            .filter { $0.element == nil }
            .map { $0.offset }
    }
    
    func isPositionOccupied(_ position: Int) -> Bool {
        return board[position] != nil
    }
    
    func reset() {
        startNewGame()
    }
}