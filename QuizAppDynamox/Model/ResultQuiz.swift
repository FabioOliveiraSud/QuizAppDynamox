//
//  ResultQuiz.swift
//  QuizAppDynamox
//
//  Created by Fabio Avila Oliveira on 25/08/25.
//

import RealmSwift

class QuizResult: Object, Identifiable {
    @Persisted(primaryKey: true) var id: String = UUID().uuidString
    @Persisted var playerId: String
    @Persisted var playerName: String
    @Persisted var score: Int
    @Persisted var totalQuestions: Int
    @Persisted var date: Date = Date()
    
    convenience init(playerId: String, playerName: String, score: Int, totalQuestions: Int) {
        self.init()
        self.playerId = playerId
        self.playerName = playerName
        self.score = score
        self.totalQuestions = totalQuestions
    }
}
