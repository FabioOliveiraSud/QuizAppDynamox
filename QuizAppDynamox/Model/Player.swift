//
//  Player.swift
//  QuizAppDynamox
//
//  Created by Fabio Avila Oliveira on 25/08/25.
//

import RealmSwift

class Player: Object, Identifiable {
    @Persisted(primaryKey: true) var id: String = UUID().uuidString
    @Persisted var name: String
    @Persisted var score: Int = 0
    @Persisted var date: Date = Date()
    
    convenience init(name: String) {
        self.init()
        self.name = name
    }
}
