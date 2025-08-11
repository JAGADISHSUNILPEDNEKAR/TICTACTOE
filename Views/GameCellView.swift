import SwiftUI

struct GameCellView: View {
    let player: Player?
    let isWinningCell: Bool
    let isDisabled: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(backgroundColor)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(borderColor, lineWidth: 2)
                    )
                
                if let player = player {
                    Text(player.rawValue)
                        .font(.system(size: 50, weight: .bold, design: .rounded))
                        .foregroundColor(textColor)
                        .scaleEffect(isWinningCell ? 1.2 : 1.0)
                        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isWinningCell)
                }
            }
        }
        .disabled(isDisabled || player != nil)
        .animation(.easeInOut(duration: 0.2), value: player)
    }
    
    private var backgroundColor: Color {
        if isWinningCell {
            return Color.green.opacity(0.3)
        } else if player != nil {
            return Color.gray.opacity(0.1)
        } else {
            return Color.white
        }
    }
    
    private var borderColor: Color {
        if isWinningCell {
            return Color.green
        } else {
            return Color.gray.opacity(0.3)
        }
    }
    
    private var textColor: Color {
        guard let player = player else { return .clear }
        
        if isWinningCell {
            return Color.green.opacity(0.8)
        } else if player == .x {
            return Color.blue
        } else {
            return Color.red
        }
    }
}