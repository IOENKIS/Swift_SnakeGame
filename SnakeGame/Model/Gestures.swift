//
//  Gestures.swift
//  SnakeGame
//
//  Created by IVANKIS on 17.01.2024.
//

import Foundation
import SwiftUI

extension SnakeGameModel {
    func handleSwipe(_ gesture: DragGesture.Value) {
        let gestureTranslation = CGPoint(x: gesture.translation.width, y: gesture.translation.height)


        if abs(gestureTranslation.x) > abs(gestureTranslation.y) {
            // Horizontal swipe
            if gestureTranslation.x > 0 && snakeDirection != .left {
                snakeDirection = .right
            } else if gestureTranslation.x < 0 && snakeDirection != .right {
                snakeDirection = .left
            }
        } else {
            // Vertical swipe
            if gestureTranslation.y > 0 && snakeDirection != .up {
                snakeDirection = .down
            } else if gestureTranslation.y < 0 && snakeDirection != .down {
                snakeDirection = .up
            }
        }
    }
}
