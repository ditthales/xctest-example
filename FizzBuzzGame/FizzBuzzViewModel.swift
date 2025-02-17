//
//  FizzBuzzViewModel.swift
//  FizzBuzzXCTest
//
//  Created by ditthales on 04/02/25.
//
import UIKit

class FizzBuzzViewModel {
    
    enum State {
        case playing, gameOver
    }
        
    var initialLives: Int
    var remainingLives: Int
    var colorBackground: String
    var gameScore: Int
    
    var state: State {
        if game.remainingLives > 0 {
            return .playing
        } else {
            return .gameOver
        }
    }
    
    
    // how to test a private var?
    private var game: GameProtocol
    
    init(game: GameProtocol = Game()) {
        self.game = game
        self.gameScore = game.score
        self.initialLives = game.totalLives
        self.remainingLives = game.remainingLives
        self.colorBackground = "Main-Background"
        
    }
    
    func playButton(move: Move) {
        verifyIfShouldAnimate(move: move)
        game.playRound(withMove: move)

        updateInfoFromModel()
    }
    

    func verifyIfShouldAnimate(move: Move) {
        if state == .gameOver {
            gameOverAnimation()
            return
        }
        
        if !game.isPlayCorrect(move: move) {
            wrongMoveAnimation()
        }
    }
    
    func updateInfoFromModel() {
        self.gameScore = game.score
        self.initialLives = game.totalLives
        self.remainingLives = game.remainingLives
    }
    
    func numberPressed () {
        playButton(move: .number)
    }
    
    func champagnePressed () {
        playButton(move: .fizz)
    }
    
    func lightningPressed () {
        playButton(move: .buzz)
    }
    
    func spacePressed () {
        playButton(move: .fizzBuzz)
    }
    
    func playAgainPressed () {
        self.colorBackground = "Main-Background"
        let newGame = Game()
        self.game = newGame
        updateInfoFromModel()
        
    }
    
    func gameOverAnimation() {
        self.colorBackground = "Fail-Background"
    }
    
    func wrongMoveAnimation() {
        self.colorBackground = "Fail-Background"
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.colorBackground = "Main-Background"
        }
    }
    
    
}

