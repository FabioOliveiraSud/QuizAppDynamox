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
                
                Image("image")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 120)
                    .foregroundColor(.accentColor)
                
                Text("Quiz")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.accentColor)
                
                TextField("Nome", text: $viewModel.playerName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
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
                
                //.padding(.top, 80)
                .navigationDestination(isPresented: $viewModel.navigateToQuiz) {
                    let service = PersistenceService()
                    let player: Player
                    if let existingPlayer = service.getPlayer(byId: viewModel.playerName) {
                        QuizView(player: existingPlayer)
                    } else {
                        // Cria e salva um novo player
                        let player = try! service.createAndSavePlayer(withName: viewModel.playerName)
                        QuizView(player: player)
                    }
                }
                
            }
            


        }
    }
}

#Preview {
    WelcomeView()
}
