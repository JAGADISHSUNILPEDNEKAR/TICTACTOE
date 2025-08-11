import Foundation

enum Player: String, CaseIterable {
    case x = "X"
    case o = "O"
    
    var opposite: Player {
        switch self {
        case .x:
            return .o
        case .o:
            return .x
        }
    }
    
    var displayName: String {
        switch self {
        case .x:
            return "Player X"
        case .o:
            return "Player O"
        }
    }
}