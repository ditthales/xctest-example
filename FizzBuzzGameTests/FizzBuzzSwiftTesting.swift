//
//  FizzBuzzSwiftTesting.swift
//  FizzBuzzGameTests
//
//  Created by ditthales on 17/02/25.
//

@testable import FizzBuzzGame
import Testing
import UIKit

@Suite("Brain Tests")
struct BrainTests {
    @Test
    func sayFizz() {
        let brain = FizzBuzzBrain()
        let result = brain.correctMove(forNumber: 3)
        #expect(result == Move.fizz)
    }

    @Test
    func sayBuzz() {
        let brain = FizzBuzzBrain()
        let result = brain.correctMove(forNumber: 5)
        #expect(result == Move.buzz)
    }

    @Test
    func sayFizzBuzz() {
        let brain = FizzBuzzBrain()
        let result = brain.correctMove(forNumber: 15)
        #expect(result == Move.fizzBuzz)
    }

    @Test
    func numberIsOne() {
        let brain = FizzBuzzBrain()
        let result = brain.correctMove(forNumber: 1)
        #expect(result == Move.number)
    }
}

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


