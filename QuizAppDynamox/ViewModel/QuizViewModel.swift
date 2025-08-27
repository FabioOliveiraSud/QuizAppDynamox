//
//  QuizViewModel.swift
//  QuizAppDynamox
//
//  Created by Fabio Avila Oliveira on 25/08/25.
//

import Foundation
import Combine

class QuizViewModel: ObservableObject {
    @Published var currentQuestion: Question?
    @Published var selectedAnswer: String?
    @Published var isAnswerCorrect: Bool?
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var showResult = false
    @Published var score = 0
    @Published var currentQuestionIndex = 0
    
    private let player: Player
    private let quizService: QuizServiceProtocol
    private let persistenceService: PersistenceServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    private let totalQuestions = 10
    private var questions: [Question] = []
    
    init(player: Player,
         quizService: QuizServiceProtocol = QuizService(),
         persistenceService: PersistenceServiceProtocol = PersistenceService()) {
        self.player = player
        self.quizService = quizService
        self.persistenceService = persistenceService
        loadNextQuestion()
    }
    
    func loadNextQuestion() {
        guard currentQuestionIndex < totalQuestions else {
            finishQuiz()
            return
        }
        
        isLoading = true
        errorMessage = nil
        selectedAnswer = nil
        isAnswerCorrect = nil
        
        quizService.loadQuestion()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMessage = "Falha ao carregar pergunta: \(error.localizedDescription)"
                }
            } receiveValue: { [weak self] question in
                self?.isLoading = false
                self?.currentQuestion = question
                self?.questions.append(question)
            }
            .store(in: &cancellables)
    }
    
    func submitAnswer() {
        guard let question = currentQuestion, let answer = selectedAnswer else { return }
        
        isLoading = true
        quizService.submitAnswer(questionId: question.id, answer: answer)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMessage = "Falha ao verificar resposta: \(error.localizedDescription)"
                }
            } receiveValue: { [weak self] isCorrect in
                self?.isLoading = false
                self?.isAnswerCorrect = isCorrect
                
                if isCorrect {
                    self?.score += 1
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    self?.currentQuestionIndex += 1
                    self?.loadNextQuestion()
                }
            }
            .store(in: &cancellables)
    }
    
    private func finishQuiz() {
        let result = QuizResult(
            playerId: player.id,
            playerName: player.name,
            score: score,
            totalQuestions: totalQuestions
        )
        
        do {
            try persistenceService.saveQuizResult(result)
            showResult = true
        } catch {
            errorMessage = "Falha ao salvar o resultado do quiz"
        }
    }
    
    func selectAnswer(_ answer: String) {
        selectedAnswer = answer
    }
}
