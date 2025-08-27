//
//  ButtonView.swift
//  QuizAppDynamox
//
//  Created by Fabio Avila Oliveira on 25/08/25.
//

import SwiftUI

struct ButtonView: View {
    var title: String
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            print("Botão pressionado!")
        }) {
            Text("")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.accentColor)
                .cornerRadius(12)
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 4)
        }
        .padding()
    }
}

#Preview {
    ButtonView(title: "", action: { })
}
