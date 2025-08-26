//
//  WelcomeView.swift
//  QuizAppDynamox
//
//  Created by Fabio Avila Oliveira on 25/08/25.
//

import SwiftUI

struct WelcomeView: View {
    @StateObject private var viewModel = WelcomeViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                Text("Quiz Challenge")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                
                Image(systemName: "brain.head.profile")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 120)
                    .foregroundColor(.blue)
                
                TextField("Enter your name", text: $viewModel.playerName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 40)
                
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                
                ButtonView(title: "Start Quiz",
                          isLoading: viewModel.isLoading,
                          action: viewModel.startQuiz)
                    .padding(.horizontal, 40)
                
                Spacer()
            }
            .padding(.top, 80)
            .navigationDestination(isPresented: $viewModel.navigateToQuiz) {
                if let player = PersistenceService().getPlayer(byId: viewModel.playerName) {
                    QuizView(player: player)
                }
            }
        }
    }
}

#Preview {
    WelcomeView()
}
