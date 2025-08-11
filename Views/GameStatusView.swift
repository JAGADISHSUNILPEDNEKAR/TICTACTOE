import SwiftUI

struct GameStatusView: View {
    let statusText: String
    let isGameOver: Bool
    let currentPlayer: Player
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                if !isGameOver {
                    Circle()
                        .fill(currentPlayer == .x ? Color.blue : Color.red)
                        .frame(width: 12, height: 12)
                        .overlay(
                            Circle()
                                .stroke(Color.white, lineWidth: 2)
                        )
                }
                
                Text(statusText)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
            .background(
                Capsule()
                    .fill(isGameOver ? Color.yellow.opacity(0.2) : Color.gray.opacity(0.1))
            )
            .overlay(
                Capsule()
                    .stroke(isGameOver ? Color.yellow.opacity(0.5) : Color.clear, lineWidth: 2)
            )
        }
        .animation(.easeInOut, value: isGameOver)
        .animation(.easeInOut, value: currentPlayer)
    }
}