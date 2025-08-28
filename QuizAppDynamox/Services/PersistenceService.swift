//
//  PersistenceNetwork.swift
//  QuizAppDynamox
//
//  Created by Fabio Avila Oliveira on 25/08/25.
//

import Foundation
import RealmSwift

protocol PersistenceServiceProtocol {
    func savePlayer(_ player: Player) throws
    func getPlayer(byId id: String) -> Player?
    func getAllPlayers() -> [Player]
    func saveQuizResult(_ result: QuizResult) throws
    func getQuizResults() -> [QuizResult]
    func getQuizResults(forPlayerId playerId: String) -> [QuizResult]
}

class PersistenceService: PersistenceServiceProtocol {
    private var realm: Realm
    
    init() {
        do {
            realm = try Realm()
        } catch {
            fatalError("Failed to initialize Realm: \(error)")
        }
    }
    
    func createAndSavePlayer(withName name: String) throws -> Player {
            let newPlayer = Player()
            newPlayer.id = UUID().uuidString
            newPlayer.name = name
            
            try savePlayer(newPlayer)
            
            return newPlayer
        }
    
    func getPlayer(byId id: String) -> Player? {
        return realm.object(ofType: Player.self, forPrimaryKey: id)
    }
    
    func savePlayer(_ player: Player) throws {
        try realm.write {
            realm.add(player, update: .modified)
        }
    }
    
    
    func getAllPlayers() -> [Player] {
        return Array(realm.objects(Player.self))
    }
    
    func saveQuizResult(_ result: QuizResult) throws {
        try realm.write {
            realm.add(result)
        }
    }
    
    func getQuizResults() -> [QuizResult] {
        return Array(realm.objects(QuizResult.self).sorted(byKeyPath: "date", ascending: false))
    }
    
    func getQuizResults(forPlayerId playerId: String) -> [QuizResult] {
        return Array(realm.objects(QuizResult.self)
            .filter("playerId == %@", playerId)
            .sorted(byKeyPath: "date", ascending: false))
    }
}
