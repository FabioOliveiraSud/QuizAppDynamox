//
//  ResultsViewModel.swift
//  QuizAppDynamox
//
//  Created by Fabio Avila Oliveira on 25/08/25.
//

import Foundation
import Combine

class ResultsViewModel: ObservableObject {
    @Published var playerName: String
    @Published var score: Int
    @Published var totalQuestions: Int
    @Published var previousResults: [QuizResult] = []
    
    private let playerId: String
    private let persistenceService: PersistenceServiceProtocol
    
    init(playerId: String, playerName: String, score: Int, totalQuestions: Int,
         persistenceService: PersistenceServiceProtocol = PersistenceService()) {
        self.playerId = playerId
        self.playerName = playerName
        self.score = score
        self.totalQuestions = totalQuestions
        self.persistenceService = persistenceService
        
        loadPreviousResults()
    }
    
    private func loadPreviousResults() {
        previousResults = persistenceService.getQuizResults(forPlayerId: playerId)
    }
}
