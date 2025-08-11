import Foundation

enum GameMode: String, CaseIterable {
    case playerVsPlayer = "Player vs Player"
    case playerVsComputer = "Player vs Computer"
    
    var displayName: String {
        self.rawValue
    }
}

enum Difficulty: String, CaseIterable {
    case easy = "Easy"
    case medium = "Medium"
    case hard = "Hard"
    
    var displayName: String {
        self.rawValue
    }
}