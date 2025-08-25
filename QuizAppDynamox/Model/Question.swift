//
//  Question.swift
//  QuizAppDynamox
//
//  Created by Fabio Avila Oliveira on 25/08/25.
//

import Foundation

struct Question: Codable, Identifiable {
    let id: String
    let statement: String
    let options: [String]
    
    enum CodingKeys: String, CodingKey {
        case id, statement, options
    }
}
