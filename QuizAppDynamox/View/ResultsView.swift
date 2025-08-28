//
//  ResultsView.swift
//  QuizAppDynamox
//
//  Created by Fabio Avila Oliveira on 25/08/25.
//

import SwiftUI

struct ResultsView: View {
    @StateObject var viewModel: ResultsViewModel
    
    init(playerId: String, playerName: String, score: Int, totalQuestions: Int) {
        _viewModel = StateObject(wrappedValue: ResultsViewModel(
            playerId: playerId,
            playerName: playerName,
            score: score,
            totalQuestions: totalQuestions
        ))
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 30) {
                    summarySection
                    
                    if !viewModel.previousResults.isEmpty {
                        previousResultsSection
                    }
                    
                    playAgainButton
                }
                .padding()
            }
        }
    }
    
    private var summarySection: some View {
        VStack(spacing: 15) {
            Text("Quiz Completo!")
                .font(.title)
                .fontWeight(.bold)
            
            Text(viewModel.playerName)
                .font(.title2)
            
            scoreCircle
            
            Text("Você acertou \(viewModel.score) de \(viewModel.totalQuestions)")
                .font(.headline)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.accentColor, lineWidth: 2)
        )
        .padding(.horizontal)
    }
    
    private var scoreCircle: some View {
        ZStack {
            Circle()
                .stroke(Color.gray.opacity(0.3), lineWidth: 10)
            
            Circle()
                .trim(from: 0, to: CGFloat(viewModel.score) / CGFloat(viewModel.totalQuestions))
                .stroke(Color.accentColor, lineWidth: 10)
                .rotationEffect(.degrees(-90))
            
            VStack {
                Text("\(viewModel.score)")
                    .font(.system(size: 40, weight: .bold))
                
                Text("/ \(viewModel.totalQuestions)")
                    .font(.title3)
            }
        }
        .frame(width: 150, height: 150)
    }
    
    private var previousResultsSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Previous Results")
                .font(.headline)
            
            ForEach(viewModel.previousResults.prefix(3)) { result in
                HStack {
                    Text("\(result.score)/\(result.totalQuestions)")
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    Text(result.date, style: .date)
                        .foregroundColor(.secondary)
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
            }
        }
        .padding(.horizontal)
    }
    
    private var playAgainButton: some View {
        NavigationLink(destination: QuizView(
            player: Player(name: viewModel.playerName)
        )) {
            Text("Jogar Novamente")
                .frame(maxWidth: .infinity)
                .padding()
                .foregroundColor(.white)
                .background(.accent)
                .cornerRadius(10)
        }
        .padding(.horizontal)
    }

}

#Preview {
    ResultsView(
        playerId: "playerId",
        playerName: "Exemplo",
        score: 7,
        totalQuestions: 10
    )
}
