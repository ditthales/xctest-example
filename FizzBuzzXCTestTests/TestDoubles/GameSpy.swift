//
//  GameSpy.swift
//  FizzBuzzXCTest
//
//  Created by ditthales on 04/02/25.
//

import Foundation

class GameSpy: GameProtocol {

    
    var score: Int
    var totalLives: Int
    var remainingLives: Int
    
    var isPlayRoundCalled: Bool = false
    var isPlayCorrectCalled: Bool = false
    var expectedCorrectMove: Move = .fizz
    
    init(score: Int = 1, initialLives: Int = 3, remainingLives: Int = 3) {
        self.score = score
        self.totalLives = initialLives
        self.remainingLives = remainingLives
    }
    
    func playRound(withMove move: Move) {
        isPlayRoundCalled = true
        
        if isPlayCorrect(move: move) {
            score += 1
        } else {
            remainingLives -= 1
        }
            
    }
    
    func isPlayCorrect(move: Move) -> Bool {
        isPlayCorrectCalled = true
        return move == expectedCorrectMove
    }
    
}
