//
//  QuizNetwork.swift
//  QuizAppDynamox
//
//  Created by Fabio Avila Oliveira on 25/08/25.
//

import Foundation
import Combine

protocol QuizServiceProtocol {
    func loadQuestion() -> AnyPublisher<Question, Error>
    func submitAnswer(questionId: String, answer: String) -> AnyPublisher<Bool, Error>
}

class QuizService: QuizServiceProtocol {
    private let apiService: APIServiceProtocol
    
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    func loadQuestion() -> AnyPublisher<Question, Error> {
        return apiService.fetchQuestion()
    }
    
    func submitAnswer(questionId: String, answer: String) -> AnyPublisher<Bool, Error> {
        return apiService.submitAnswer(questionId: questionId, answer: answer)
    }
}
