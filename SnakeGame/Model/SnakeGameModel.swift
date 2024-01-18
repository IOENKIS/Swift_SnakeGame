//
//  SnakeGameModel.swift
//  SnakeGame
//
//  Created by IVANKIS on 17.01.2024.
//

import Foundation
import SwiftUI

class SnakeGameModel: ObservableObject{
    enum SnakeDirection {
        case up, down, left, right
    }
    
    @Published var gameOver = false
    @Published var snakeDirection: SnakeDirection = .down
    @Published var foodPosition = CGPoint(x: 200, y: 400)
    @Published var snakeBody: [CGPoint] = [CGPoint(x: 200, y: 200)]
    @Published var isGameActive = false
    var gameTimer: Timer?
    let snakeSize: CGFloat = 40
    var bodyPosition: CGPoint = .zero

    
    func moveSnake() {
        guard !gameOver else { return }

        var newHead = CGPoint(x: 0, y: 0)
        
        switch snakeDirection {
        case .up:
            newHead = CGPoint(x: snakeBody[0].x, y: snakeBody[0].y - snakeSize)
        case .down:
            newHead = CGPoint(x: snakeBody[0].x, y: snakeBody[0].y + snakeSize)
        case .left:
            newHead = CGPoint(x: snakeBody[0].x - snakeSize, y: snakeBody[0].y)
        case .right:
            newHead = CGPoint(x: snakeBody[0].x + snakeSize, y: snakeBody[0].y)
        }

        if newHead.x < snakeSize || newHead.x > 360 || newHead.y < snakeSize || newHead.y > 600 {
                endGame()
                return
            }

        if snakeBody.contains(newHead) {
            endGame()
            return
        }

        if newHead == foodPosition {
            snakeBody.insert(newHead, at: 0)
            generateNewFoodPosition()
        } else {
            snakeBody.insert(newHead, at: 0)
            snakeBody.removeLast()
        }

        
        if snakeBody.count > 1 {
            bodyPosition = snakeBody[1]
        }
    }
    
    func generateNewFoodPosition() {
        let maxX = 360 - snakeSize
        let maxY = 600 - snakeSize
        var newX: CGFloat
        var newY: CGFloat
        
        repeat {
            newX = CGFloat.random(in: snakeSize..<maxX).rounded(toNearest: snakeSize)
            newY = CGFloat.random(in: snakeSize..<maxY).rounded(toNearest: snakeSize)
        } while snakeBody.contains(CGPoint(x: newX, y: newY))
        
        foodPosition = CGPoint(x: newX, y: newY)
    }

    func startGame() {
            guard !isGameActive else { return }
            
            isGameActive = true
            gameTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
                DispatchQueue.main.async {
                    self.moveSnake()
                }
            }
        }
    
    func endGame() {
        isGameActive = false
        gameOver = true
        gameTimer?.invalidate()
    }

    func resetGame() {
        snakeBody = [CGPoint(x: 200, y: 200)]
        foodPosition = CGPoint(x: 200, y: 400)
        gameOver = false
        snakeDirection = .down
        isGameActive = false
        gameTimer?.invalidate()
        startGame()
    }
}

extension CGFloat {
    func rounded(toNearest nearest: CGFloat) -> CGFloat {
        return (self / nearest).rounded() * nearest
    }
}
