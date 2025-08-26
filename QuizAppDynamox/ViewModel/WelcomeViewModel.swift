//
//  WelcomeViewModel.swift
//  QuizAppDynamox
//
//  Created by Fabio Avila Oliveira on 25/08/25.
//

import Foundation
import Combine

class WelcomeViewModel: ObservableObject {
    @Published var playerName = ""
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var navigateToQuiz = false
    
    private let persistenceService: PersistenceServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(persistenceService: PersistenceServiceProtocol = PersistenceService()) {
        self.persistenceService = persistenceService
    }
    
    func startQuiz() {
        guard !playerName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            errorMessage = "Please enter your name to start the quiz"
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        let player = Player(name: playerName)
        do {
            try persistenceService.savePlayer(player)
            isLoading = false
            navigateToQuiz = true
        } catch {
            isLoading = false
            errorMessage = "Failed to save player information"
        }
    }
}
