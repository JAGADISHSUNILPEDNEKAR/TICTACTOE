import Foundation

class GameAI {
    private let winPatterns: [[Int]] = [
        [0, 1, 2], [3, 4, 5], [6, 7, 8], // Horizontal
        [0, 3, 6], [1, 4, 7], [2, 5, 8], // Vertical
        [0, 4, 8], [2, 4, 6]             // Diagonal
    ]
    
    func getBestMove(board: [Player?], difficulty: Difficulty, aiPlayer: Player) -> Int? {
        switch difficulty {
        case .easy:
            return getRandomMove(board: board)
        case .medium:
            return getMediumMove(board: board, aiPlayer: aiPlayer)
        case .hard:
            return getHardMove(board: board, aiPlayer: aiPlayer)
        }
    }
    
    // MARK: - Easy AI (Random)
    private func getRandomMove(board: [Player?]) -> Int? {
        let availablePositions = board.enumerated()
            .filter { $0.element == nil }
            .map { $0.offset }
        
        guard !availablePositions.isEmpty else { return nil }
        return availablePositions.randomElement()
    }
    
    // MARK: - Medium AI (Rule-based)
    private func getMediumMove(board: [Player?], aiPlayer: Player) -> Int? {
        let humanPlayer = aiPlayer.opposite
        
        // 1. Try to win
        if let winningMove = findWinningMove(board: board, player: aiPlayer) {
            return winningMove
        }
        
        // 2. Block opponent's win
        if let blockingMove = findWinningMove(board: board, player: humanPlayer) {
            return blockingMove
        }
        
        // 3. Take center if available
        if board[4] == nil {
            return 4
        }
        
        // 4. Take a corner
        let corners = [0, 2, 6, 8]
        let availableCorners = corners.filter { board[$0] == nil }
        if !availableCorners.isEmpty {
            return availableCorners.randomElement()
        }
        
        // 5. Take any available position
        return getRandomMove(board: board)
    }
    
    // MARK: - Hard AI (Minimax)
    private func getHardMove(board: [Player?], aiPlayer: Player) -> Int? {
        var bestScore = Int.min
        var bestMove: Int?
        
        for i in 0..<9 {
            if board[i] == nil {
                var newBoard = board
                newBoard[i] = aiPlayer
                let score = minimax(board: newBoard, depth: 0, isMaximizing: false, aiPlayer: aiPlayer)
                if score > bestScore {
                    bestScore = score
                    bestMove = i
                }
            }
        }
        
        return bestMove
    }
    
    private func minimax(board: [Player?], depth: Int, isMaximizing: Bool, aiPlayer: Player) -> Int {
        let humanPlayer = aiPlayer.opposite
        
        // Check terminal states
        if checkWin(board: board, player: aiPlayer) {
            return 10 - depth
        } else if checkWin(board: board, player: humanPlayer) {
            return depth - 10
        } else if isBoardFull(board: board) {
            return 0
        }
        
        if isMaximizing {
            var bestScore = Int.min
            for i in 0..<9 {
                if board[i] == nil {
                    var newBoard = board
                    newBoard[i] = aiPlayer
                    let score = minimax(board: newBoard, depth: depth + 1, isMaximizing: false, aiPlayer: aiPlayer)
                    bestScore = max(score, bestScore)
                }
            }
            return bestScore
        } else {
            var bestScore = Int.max
            for i in 0..<9 {
                if board[i] == nil {
                    var newBoard = board
                    newBoard[i] = humanPlayer
                    let score = minimax(board: newBoard, depth: depth + 1, isMaximizing: true, aiPlayer: aiPlayer)
                    bestScore = min(score, bestScore)
                }
            }
            return bestScore
        }
    }
    
    // MARK: - Helper Methods
    private func findWinningMove(board: [Player?], player: Player) -> Int? {
        for pattern in winPatterns {
            let positions = pattern.map { board[$0] }
            let playerCount = positions.filter { $0 == player }.count
            let emptyCount = positions.filter { $0 == nil }.count
            
            if playerCount == 2 && emptyCount == 1 {
                for index in pattern {
                    if board[index] == nil {
                        return index
                    }
                }
            }
        }
        return nil
    }
    
    private func checkWin(board: [Player?], player: Player) -> Bool {
        for pattern in winPatterns {
            if pattern.allSatisfy({ board[$0] == player }) {
                return true
            }
        }
        return false
    }
    
    private func isBoardFull(board: [Player?]) -> Bool {
        return board.allSatisfy { $0 != nil }
    }
}