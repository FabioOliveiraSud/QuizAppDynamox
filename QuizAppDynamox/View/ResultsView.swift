//
//  ResultsView.swift
//  QuizAppDynamox
//
//  Created by Fabio Avila Oliveira on 25/08/25.
//

import SwiftUI

struct ResultsView: View {
    @StateObject private var viewModel: ResultsViewModel
    @Environment(\.dismiss) private var dismiss
    
    init(playerId: String, playerName: String, score: Int, totalQuestions: Int) {
        _viewModel = StateObject(wrappedValue: ResultsViewModel(
            playerId: playerId,
            playerName: playerName,
            score: score,
            totalQuestions: totalQuestions
        ))
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                VStack(spacing: 15) {
                    Text("Quiz Completed!")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text("\(viewModel.playerName)")
                        .font(.title2)
                    
                    ZStack {
                        Circle()
                            .stroke(Color.gray.opacity(0.3), lineWidth: 10)
                            .frame(width: 150, height: 150)
                        
                        Circle()
                            .trim(from: 0, to: CGFloat(viewModel.score) / CGFloat(viewModel.totalQuestions))
                            .stroke(Color.blue, lineWidth: 10)
                            .frame(width: 150, height: 150)
                            .rotationEffect(.degrees(-90))
                        
                        VStack {
                            Text("\(viewModel.score)")
                                .font(.system(size: 40, weight: .bold))
                            
                            Text("/ \(viewModel.totalQuestions)")
                                .font(.title3)
                        }
                    }
                    
                    Text("You scored \(viewModel.score) out of \(viewModel.totalQuestions)")
                        .font(.headline)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.blue, lineWidth: 2)
                )
                .padding()
                
                if !viewModel.previousResults.isEmpty {
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
                
                VStack(spacing: 15) {
                    Button(action: { dismiss() }) {
                        Text("Jogar Novamente")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(.accent)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                    
                    Button("Back to Home") {
                        dismiss()
                    }
                    .foregroundColor(.blue)
                }
                .padding()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ResultsView(playerId: "playerId", playerName: "playerName", score: 0, totalQuestions: 0)
}
