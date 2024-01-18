//
//  ContentView.swift
//  SnakeGame
//
//  Created by IVANKIS on 17.01.2024.
//

import SwiftUI

struct SnakeGameView: View {
    @ObservedObject var snakeGameModel = SnakeGameModel()
    var body: some View {
        VStack {
            HStack{
                Text("Snake Game        Score \(snakeGameModel.snakeBody.count - 1)")
                    .font(.title)
            }
            ZStack{
                Rectangle()
                    .fill(Color.gray.opacity(0.25))
                    .frame(width: 360, height: 600)
                    .overlay(
                        Rectangle()
                            .stroke(Color.gray, lineWidth: 2)
                                    )
                if snakeGameModel.gameOver {
                    Text("Game Over!")
                        .foregroundColor(.red)
                        .font(.title)
                        .padding()
                } else {
                    ForEach(Array(snakeGameModel.snakeBody.enumerated()), id: \.offset) { index, bodyPart in
                        Image(index == 0 ? "SnakeHead" : "SnakeBody")
                            .resizable()
                            .frame(width: snakeGameModel.snakeSize, height: snakeGameModel.snakeSize)
                            .position(bodyPart)
                    }
                }
                Image("FoodApple")
                    .resizable()
                    .frame(width: snakeGameModel.snakeSize, height: snakeGameModel.snakeSize)
                    .position(snakeGameModel.foodPosition)
            }
            .gesture(DragGesture()
                .onChanged { gesture in
                    snakeGameModel.handleSwipe(gesture)
                }
            )
                
            }
            Button(action: {
                if snakeGameModel.gameOver {
                    snakeGameModel.resetGame()
                } else {
                    snakeGameModel.startGame()
                }
            }) {
                Text(snakeGameModel.gameOver ? "Restart" : "Start")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
    }


#Preview {
    SnakeGameView()
}
