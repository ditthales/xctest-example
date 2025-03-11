//
//  FizzBuzzGameTests.swift
//  FizzBuzzGameTests
//
//  Created by ditthales on 17/02/25.
//

@testable import FizzBuzzGame
import Testing
import UIKit

@Suite("Game Tests")
struct GameTests {
    var brainSpy: BrainSpy!
    var game: Game!

    init() {
        brainSpy = BrainSpy()
        game = Game(brain: brainSpy)
    }
    
    // testes se o init da classe está conforme o esperado
    
    @Test
    func gameStartsAtOne(){
        #expect(game.score == 1)
    }
    
    @Test
    func gameStartsWithMoreThanOneTotalLive() {
        #expect(game.totalLives >= 1)
    }
    
    @Test
    func testIfGameStartsWithTotalLivesEqualToRemainingLives() {
        #expect(game.totalLives == game.remainingLives)
    }
    
    

    // teste se o brain.correctMove está sendo chamado
    @Test
    func testPlayRoundIsCallingCorrectMove() {
        let scoreCalled = game.score
        
        // when playRound is called
        game.playRound(withMove: .fizzBuzz)
       
        // then brain's correctMove is called with score
        #expect(brainSpy.isCorrectMoveCalled)
        #expect(brainSpy.numberCalledOnCorrectMove == scoreCalled)
    }
    
    @Test
    func testIfIsMoveCorrecReturnsTrueWhenExpected() {
        brainSpy.correctMoveReturnedMove = .fizz
        
        let result = game.isPlayCorrect(move: .fizz)
        
        #expect(result)
    }
    
    @Test
    func testIfIsMoveCorrecReturnsFalseWhenExpected() {
        brainSpy.correctMoveReturnedMove = .number
        
        let result = game.isPlayCorrect(move: .fizzBuzz)
        
        #expect(!result)
    }
    
    
    // testar se vidas restantes subtrai 1
    @Test
    func testPlayRoundIsCalledWithWrongMove() {
        // given correctMove returns different move than provided
        brainSpy.correctMoveReturnedMove = .number
        
        // when playRound is called with different move
        let currentRemainingLives = game.remainingLives
        let expectedScore = game.score
        
        game.playRound(withMove: .fizzBuzz)
        
        // then should subtract one from remaining lives
        let expectedRemainingLives = currentRemainingLives - 1
        #expect(game.remainingLives == expectedRemainingLives)
        #expect(game.score == expectedScore)
        
    }
    
    
    // testar se movimento correto
    @Test
    func testPlayRoundIsCalledWithRightMove() {
        brainSpy.correctMoveReturnedMove = .fizz
        
        let currentGameScore = game.score
        let expectecRemainingLives = game.remainingLives
        
        game.playRound(withMove: .fizz)
        
        let expectedScore = currentGameScore + 1
        #expect(self.game.score == expectedScore)
        #expect(self.game.remainingLives == expectecRemainingLives)
         

    }
} 