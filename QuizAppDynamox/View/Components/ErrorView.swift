//
//  ErrorView.swift
//  QuizAppDynamox
//
//  Created by Fabio Avila Oliveira on 25/08/25.
//

import SwiftUI

struct ErrorView: View {
    let title: String
    let message: String
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack{
          VStack(spacing:16){
            Image(systemName:"exclamationmark.triangle.fill")
                .resizable().scaledToFit().frame(width:72,height:72)
            Text(title).font(.title2).bold().multilineTextAlignment(.center)
            Text(message).font(.body).multilineTextAlignment(.center).padding(.horizontal)
            HStack(spacing:12){
                Button(action: { dismiss ()}){
                    Text("Fechar").frame(maxWidth:120).padding().overlay(RoundedRectangle(cornerRadius:10).stroke())
                }
            }.padding(.horizontal)
        }.padding().background(RoundedRectangle(cornerRadius:14).fill(Color(UIColor.systemBackground)).shadow(radius:8))
    }
  }
}

#Preview {
    ErrorView(title: "Algo deu errado", message: "Erro ao carregar as perguntas")
}
