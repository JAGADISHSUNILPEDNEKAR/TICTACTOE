import SwiftUI

struct GameModePickerView: View {
    @Binding var isPresented: Bool
    @State private var selectedMode: GameMode = .playerVsPlayer
    @State private var selectedDifficulty: Difficulty = .medium
    let onConfirm: (GameMode, Difficulty) -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Select Game Mode")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top)
            
            VStack(spacing: 15) {
                ForEach(GameMode.allCases, id: \.self) { mode in
                    Button(action: {
                        selectedMode = mode
                    }) {
                        HStack {
                            Image(systemName: mode == .playerVsPlayer ? "person.2.fill" : "person.fill")
                                .font(.title2)
                            
                            Text(mode.displayName)
                                .font(.title3)
                                .fontWeight(.medium)
                            
                            Spacer()
                            
                            if selectedMode == mode {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                                    .font(.title2)
                            }
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(selectedMode == mode ? Color.blue.opacity(0.1) : Color.gray.opacity(0.05))
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(selectedMode == mode ? Color.blue : Color.clear, lineWidth: 2)
                        )
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding(.horizontal)
            
            if selectedMode == .playerVsComputer {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Difficulty Level")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    Picker("Difficulty", selection: $selectedDifficulty) {
                        ForEach(Difficulty.allCases, id: \.self) { difficulty in
                            Text(difficulty.displayName).tag(difficulty)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal)
                }
                .transition(.opacity)
            }
            
            Spacer()
            
            HStack(spacing: 20) {
                Button("Cancel") {
                    isPresented = false
                }
                .font(.title3)
                .padding(.horizontal, 30)
                .padding(.vertical, 12)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                
                Button("Start Game") {
                    onConfirm(selectedMode, selectedDifficulty)
                    isPresented = false
                }
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .padding(.horizontal, 30)
                .padding(.vertical, 12)
                .background(Color.blue)
                .cornerRadius(10)
            }
            .padding(.bottom)
        }
        .frame(maxWidth: 400)
        .animation(.easeInOut, value: selectedMode)
    }
}