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
        NavigationStack {
            VStack(spacing: 30) {
                Text("Dynamox Quiz")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.accentColor)
                
                Image(systemName: "brain.head.profile")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 120)
                    .foregroundColor(.accentColor)
                
                TextField("Enter your name", text: $viewModel.playerName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 40)
                
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                
                Button(action: viewModel.startQuiz) {
                    Text("Iniciar Quiz")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(.accent)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .padding(.top, 80)
            .navigationDestination(isPresented: $viewModel.navigateToQuiz) {
                let player = PersistenceService().getPlayer(byId: viewModel.playerName)
                    if let player {
                        QuizView(player: player)
                    } else {
                        Text("Nenhum jogador encontrado para ID: \(viewModel.playerName)")
                    }
            }
        }
    }
}

#Preview {
    WelcomeView()
}
