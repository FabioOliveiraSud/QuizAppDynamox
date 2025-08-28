//
//  QuestionView.swift
//  QuizAppDynamox
//
//  Created by Fabio Avila Oliveira on 25/08/25.
//

import SwiftUI

struct QuestionView: View {
    let question: Question
    @Binding var selectedAnswer: String?
    let isAnswerCorrect: Bool?
    let onSubmit: () -> Void
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text(question.statement)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.bottom, 10)
                    .foregroundStyle(.accent)
                
                ForEach(question.options, id: \.self) { option in
                    AnswerOptionView(
                        option: option,
                        isSelected: selectedAnswer == option,
                        isCorrect: isAnswerCorrect,
                        onSelect: { selectedAnswer = option }
                    )
                }
                
                if selectedAnswer != nil && isAnswerCorrect == nil {
                    Button(action: onSubmit) {
                        Text("Verificar Resposta")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(.accent)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                        
                        
                }
                
                if let isCorrect = isAnswerCorrect {
                    HStack {
                        Image(systemName: isCorrect ? "checkmark.circle.fill" : "xmark.circle.fill")
                            .foregroundColor(isCorrect ? .green : .red)
                        
                        Text(isCorrect ? "Correto!" : "Incorreto!")
                            .font(.headline)
                            .foregroundColor(isCorrect ? .green : .red)
                    }
                    .padding()
                    .transition(.scale)
                }
            }
            .padding()
        }
    }
}

struct AnswerOptionView: View {
    let option: String
    let isSelected: Bool
    let isCorrect: Bool?
    let onSelect: () -> Void
    
    var body: some View {
        Button(action: onSelect) {
            HStack {
                Text(option)
                    .foregroundColor(.primary)
                
                Spacer()
                
                if isSelected {
                    Image(systemName: "checkmark")
                        .foregroundColor(.blue)
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(borderColor, lineWidth: 2)
                    //.background(Color.gray)
            )
        }
        .disabled(isCorrect != nil)
    }
    
    private var borderColor: Color {
        if let isCorrect = isCorrect {
            if isSelected {
                return isCorrect ? .green : .red
            }
        } else if isSelected {
            return .blue
        }
        return .gray
    }
}

#Preview {
    QuestionView(question: Question(id: "1",
                                    statement: "Qual é a melhor empresa do mundo?",
                                    options: ["Google","Microsoft","Apple", "Dynamox"]),
                                    selectedAnswer: .constant(nil),
                                    isAnswerCorrect: nil, onSubmit: {} )
}
