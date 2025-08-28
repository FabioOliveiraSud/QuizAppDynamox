//
//  SplashView.swift
//  QuizAppDynamox
//
//  Created by Fabio Avila Oliveira on 27/08/25.
//

import SwiftUI

struct SplashView: View {
    @State private var isActive = false
    @State private var logoScale: CGFloat = 0.6
    @State private var logoOpacity: Double = 0.0

    var body: some View {
        if isActive {
            WelcomeView()
        } else {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.accentColor, Color.purple]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .scaleEffect(logoScale)
                    .opacity(logoOpacity)
                    .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
            }
            .onAppear {
                withAnimation(.easeInOut(duration: 1.2)) {
                    self.logoScale = 1.0
                    self.logoOpacity = 1.0
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation(.easeOut) {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

#Preview {
    SplashView()
}
