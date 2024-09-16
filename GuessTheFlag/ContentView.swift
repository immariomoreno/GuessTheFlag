//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Mario Moreno on 9/16/24.
//

import SwiftUI

struct ContentView: View {
    @State private var score = 0
    @State private var questionCount = 1
    @State private var showingFinalAlert = false
    @State private var alertMessage = ""
    @State private var showingScore = false
    @State private var scoreTitle = ""
    let totalAttempts = 8
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy",  "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    var remainingAttempts: Int {
        totalAttempts - questionCount
    }
    
    var body: some View {
        
        ZStack {
//            LinearGradient(colors: [.orange, .black], startPoint: .top, endPoint: .bottom)
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.16, blue: 0.30), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 700)
            
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)
                Text("You have \(remainingAttempts) \(remainingAttempts == 1 ? "attempt" : "attempts") left")
                    .font(.subheadline.weight(.heavy))
                    .foregroundStyle(.white)
                    .padding(.top, 10)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .clipShape(.capsule)
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                .alert(scoreTitle, isPresented: $showingScore) {
                    Button("Continue", action: askQuestion)
                } message: {
                    Text(alertMessage)
                }
                Spacer()
                Spacer()
                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                Spacer()
            }
            
            .padding()
        }
        .alert("Game Over", isPresented: $showingFinalAlert) {
            Button("Restart", action: resetGame)
        } message: {
            Text("Your final score is \(score) out of \(totalAttempts).")
        }

        .ignoresSafeArea()
       
       
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            score += 1
            scoreTitle = "Correct"
            alertMessage = "Well done! Your score is \(score)"
        } else {
            scoreTitle = "Wrong"
            alertMessage = "Wrong! That´s the flag of \(countries[number]). Your score is \(score)."
        }
        
        showingScore = true
        
        if questionCount >= totalAttempts {
            showingFinalAlert = true
        } else {
            questionCount += 1
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func resetGame() {
        score = 0
        questionCount = 0
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }

 
          
}


#Preview {
    ContentView()
}
