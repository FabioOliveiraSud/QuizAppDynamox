//
//  APINetwork.swift
//  QuizAppDynamox
//
//  Created by Fabio Avila Oliveira on 25/08/25.
//

import Foundation
import Alamofire
import Combine

protocol APIServiceProtocol {
    func fetchQuestion() -> AnyPublisher<Question, Error>
    func submitAnswer(questionId: String, answer: String) -> AnyPublisher<Bool, Error>
}

class APIService: APIServiceProtocol {
    private let baseURL = "https://quiz-api-bwi5hjqyaq-uc.a.run.app"
    
    func fetchQuestion() -> AnyPublisher<Question, Error> {
        let url = "\(baseURL)/question"
        
        return AF.request(url, method: .get)
            .validate()
            .publishDecodable(type: Question.self)
            .value()
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
    
    func submitAnswer(questionId: String, answer: String) -> AnyPublisher<Bool, Error> {
        let url = "\(baseURL)/answer?questionId=\(questionId)"
        let answerRequest = AnswerRequest(answer: answer)
        
        return AF.request(url, method: .post, parameters: answerRequest, encoder: JSONParameterEncoder.default)
            .validate()
            .publishDecodable(type: AnswerResponse.self)
            .value()
            .map { $0.result }
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
}
