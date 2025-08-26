//
//  QuizView.swift
//  QuizAppDynamox
//
//  Created by Fabio Avila Oliveira on 25/08/25.
//

import SwiftUI

struct QuizView: View {
    let player: Player
    @StateObject private var viewModel: QuizViewModel
    
    init(player: Player) {
        self.player = player
        _viewModel = StateObject(wrappedValue: QuizViewModel(player: player))
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("Question \(viewModel.currentQuestionIndex + 1)/10")
                    .font(.headline)
                
                Spacer()
                
                Text("Score: \(viewModel.score)")
                    .font(.headline)
                    .foregroundColor(.blue)
            }
            .padding()
            
            // Question content
            if viewModel.isLoading {
                LoadingView()
            } else if let errorMessage = viewModel.errorMessage {
                ErrorView
            } else if let question = viewModel.currentQuestion {
                QuestionView(
                    question: question,
                    selectedAnswer: $viewModel.selectedAnswer,
                    isAnswerCorrect: viewModel.isAnswerCorrect,
                    onSubmit: viewModel.submitAnswer
                )
            }
            
            Spacer()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(isPresented: $viewModel.showResult) {
            ResultsView(
                playerId: player.id,
                playerName: player.name,
                score: viewModel.score,
                totalQuestions: 10
            )
        }
    }
}
#Preview {
    QuizView(player: Player)
}
