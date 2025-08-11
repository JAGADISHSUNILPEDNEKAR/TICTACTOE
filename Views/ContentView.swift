import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = GameViewModel()
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                colors: [Color.blue.opacity(0.05), Color.purple.opacity(0.05)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 20) {
                // Title
                HStack {
                    Image(systemName: "gamecontroller.fill")
                        .font(.largeTitle)
                        .foregroundColor(.blue)
                    
                    Text("Tic-Tac-Toe")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
                .padding(.top, 20)
                
                // Game Mode Display
                HStack {
                    Image(systemName: viewModel.gameModel.gameMode == .playerVsPlayer ? "person.2.fill" : "person.crop.circle.badge.checkmark")
                        .foregroundColor(.secondary)
                    
                    Text(viewModel.gameModel.gameMode.displayName)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    if viewModel.gameModel.gameMode == .playerVsComputer {
                        Text("•")
                            .foregroundColor(.secondary)
                        Text(viewModel.gameModel.difficulty.displayName)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.horizontal, 15)
                .padding(.vertical, 8)
                .background(Capsule().fill(Color.gray.opacity(0.1)))
                
                // Status
                GameStatusView(
                    statusText: viewModel.statusText,
                    isGameOver: viewModel.isGameOver,
                    currentPlayer: viewModel.gameModel.currentPlayer
                )
                
                // Game Board
                GameBoardView(viewModel: viewModel)
                    .frame(maxWidth: 400)
                    .disabled(viewModel.showingModeSelection)
                
                Spacer()
                
                // Control Buttons
                HStack(spacing: 20) {
                    Button(action: {
                        viewModel.changeGameMode()
                    }) {
                        Label("Change Mode", systemImage: "arrow.triangle.2.circlepath")
                            .font(.body)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 12)
                            .background(Color.orange.opacity(0.2))
                            .foregroundColor(.orange)
                            .cornerRadius(10)
                    }
                    
                    Button(action: {
                        viewModel.startNewGame()
                    }) {
                        Label("New Game", systemImage: "arrow.clockwise")
                            .font(.body)
                            .fontWeight(.semibold)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 12)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding(.bottom, 30)
            }
            .blur(radius: viewModel.showingModeSelection ? 3 : 0)
            .disabled(viewModel.showingModeSelection)
            
            // Mode Selection Sheet
            if viewModel.showingModeSelection {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        // Allow dismissing by tapping outside
                    }
                
                GameModePickerView(
                    isPresented: $viewModel.showingModeSelection,
                    onConfirm: viewModel.confirmGameMode
                )
                .background(Color.white)
                .cornerRadius(20)
                .shadow(radius: 20)
                .padding(30)
                .transition(.scale.combined(with: .opacity))
            }
        }
        .animation(.easeInOut, value: viewModel.showingModeSelection)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}