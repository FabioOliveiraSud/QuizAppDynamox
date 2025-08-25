//
//  Answer.swift
//  QuizAppDynamox
//
//  Created by Fabio Avila Oliveira on 25/08/25.
//

import Foundation

struct AnswerRequest: Codable {
    let answer: String
}

struct AnswerResponse: Codable {
    let result: Bool
}
