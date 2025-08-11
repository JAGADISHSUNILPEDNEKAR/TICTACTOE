import SwiftUI

struct GameBoardView: View {
    @ObservedObject var viewModel: GameViewModel
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 10) {
            ForEach(0..<9) { index in
                GameCellView(
                    player: viewModel.gameModel.board[index],
                    isWinningCell: isWinningCell(index),
                    isDisabled: viewModel.isGameOver || viewModel.isThinking
                ) {
                    viewModel.handleCellTap(at: index)
                }
                .aspectRatio(1, contentMode: .fit)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.gray.opacity(0.05))
        )
    }
    
    private func isWinningCell(_ index: Int) -> Bool {
        guard let winningLine = viewModel.gameModel.getWinningLine() else {
            return false
        }
        return winningLine.contains(index)
    }
}