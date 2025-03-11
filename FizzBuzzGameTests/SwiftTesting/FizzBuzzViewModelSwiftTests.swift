//
//  FizzBuzzViewModelSwiftTests.swift
//  FizzBuzzGameTests
//
//  Created by ditthales on 17/02/25.
//

@testable import FizzBuzzGame
import Testing
import UIKit

@Suite("ViewModel Tests")
struct ViewModelTests {
    var viewModel: FizzBuzzViewModel!
    var gameSpy: GameSpy!
    
    init() {
        gameSpy = GameSpy()
        viewModel = FizzBuzzViewModel(game: gameSpy)
    }
    
    @Test
    func testIfBeginsWithLives() {
        #expect(viewModel.initialLives > 0)
    }
    
    @Test
    func testIfBeginsWithPlayingState() {
        let expectedState: FizzBuzzViewModel.State = .playing
        
        #expect(viewModel.state == expectedState)
    }
    
    @Test
    func testIfStateIsPlayingWhenHasLives() {
        gameSpy.remainingLives = 1
        
        let expectedState: FizzBuzzViewModel.State = .playing
        
        #expect(viewModel.state == expectedState)
    }
    
    @Test
    func testIfStateChangesToGameOverWhenNoLives() {
        gameSpy.remainingLives = 0
        
        let expectedState: FizzBuzzViewModel.State = .gameOver
        
        #expect(viewModel.state == expectedState)
        
    }
    
    @Test
    func testIfPlayButtonIsCallingPlayRound() {
        viewModel.playButton(move: .fizz)
        
        #expect(gameSpy.isPlayRoundCalled)
        #expect(gameSpy.isPlayCorrectCalled)
    }
    

    @Test
    func testIfUpdateInfoFromModelWorks() {
        viewModel.gameScore = 1
        viewModel.initialLives = 5
        viewModel.remainingLives = 4
        
        let expectedGameScore = 5
        let expectedInitialLives = 3
        let expectedRemainingLies = 2
        
        gameSpy.score = expectedGameScore
        gameSpy.totalLives = expectedInitialLives
        gameSpy.remainingLives = expectedRemainingLies
        
        
        viewModel.updateInfoFromModel()
        
        
        #expect(viewModel.gameScore == expectedGameScore)
        #expect(viewModel.initialLives == expectedInitialLives)
        #expect(viewModel.remainingLives == expectedRemainingLies)
        
    }
    
    @Test
    func testIfNumberPressedWillIncreaseScoreWhenExpected() {
        gameSpy.expectedCorrectMove = .number
        let currentScore = viewModel.gameScore
        
        viewModel.numberPressed()
        
        let expectedScore = currentScore + 1
        #expect(viewModel.gameScore == expectedScore)
        
    }
    
    @Test
    func testIfChampagnePressedWillIncreaseScoreWhenExpected() {
        gameSpy.expectedCorrectMove = .fizz
        let currentScore = viewModel.gameScore
        
        viewModel.champagnePressed()
        
        let expectedScore = currentScore + 1
        #expect(viewModel.gameScore == expectedScore)
        
    }
    
    @Test
    func testIfLightningPressedWillIncreaseScoreWhenExpected() {
        gameSpy.expectedCorrectMove = .buzz
        let currentScore = viewModel.gameScore
        
        viewModel.lightningPressed()
        
        let expectedScore = currentScore + 1
        #expect(viewModel.gameScore == expectedScore)
        
    }
    
    @Test
    func testIfSpacePressedWillIncreaseScoreWhenExpected() {
        gameSpy.expectedCorrectMove = .fizzBuzz
        let currentScore = viewModel.gameScore
        
        viewModel.spacePressed()
        
        let expectedScore = currentScore + 1
        #expect(viewModel.gameScore == expectedScore)
        
    }
    
    
    @Test
    func testIfPlayAgainResetsGame() {
        gameSpy.expectedCorrectMove = .number
        let expectedScore = viewModel.gameScore
        
        viewModel.playButton(move: .number)
        
        viewModel.playAgainPressed()
        #expect(viewModel.gameScore == expectedScore)
    }
    
    
    @Test
    func testIfViewModelWillChangeState() {
        gameSpy.remainingLives = 1
        gameSpy.expectedCorrectMove = .fizz
        
        viewModel.lightningPressed()
   
        #expect(viewModel.state == .gameOver)
    }
    
    @Test
    func testIfBackgroundViewWillChangeOnWrongMove() {
        gameSpy.expectedCorrectMove = .fizzBuzz
        let currentBackground = viewModel.colorBackground
        
        viewModel.numberPressed()
        
        #expect(viewModel.colorBackground != currentBackground)
        
    }
    
    @Test
    func TestIfBackgroundWontChangeOnRightMove() {
        gameSpy.expectedCorrectMove = .buzz
        let expectedBackground = viewModel.colorBackground
        
        viewModel.lightningPressed()
        
        #expect(viewModel.colorBackground == expectedBackground)
        
    }
    
    @Test
    func testIfBackgroundWillChangeOnGameOver() {
        let currentBackground = viewModel.colorBackground
        gameSpy.remainingLives = 1
        gameSpy.expectedCorrectMove = .fizz
        
        viewModel.numberPressed()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            #expect(self.viewModel.colorBackground != currentBackground)
        }
        
    }
    
    @Test
    func testIfBackgroundWillChangeOnPlayAgain() {
        let failBg = "Fail-Background"
        viewModel.colorBackground = failBg
        
        viewModel.playAgainPressed()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            #expect(self.viewModel.colorBackground != failBg)
        }
    }
} 