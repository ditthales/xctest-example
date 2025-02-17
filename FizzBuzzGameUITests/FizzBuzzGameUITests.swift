//
//  FizzBuzzXCTestUITests.swift
//  FizzBuzzXCTestUITests
//
//  Created by ditthales on 04/02/25.
//

import XCTest

final class FizzBuzzGameUITests: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        app.launch()
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGameStartsWithCorrectUIElements() throws {
        // Verifica se o rótulo de vidas existe
        let livesLabel = app.staticTexts["livesLabel"]
        XCTAssertTrue(livesLabel.exists, "O label de vidas deveria existir.")
        
        // Verifica se o botão de número existe
        let numberButton = app.buttons.element(boundBy: 0) // Pega o primeiro botão na tela
        XCTAssertTrue(numberButton.exists, "O botão de número deveria existir.")
    }
    
    func testPressingNumberButtonUpdatesScore() throws {
        let numberButton = app.buttons.element(boundBy: 0)
        let initialTitle = numberButton.label
        
        numberButton.tap() // Simula o toque no botão
        
        let updatedTitle = numberButton.label
        XCTAssertNotEqual(initialTitle, updatedTitle, "O título do botão deveria ter mudado após o toque.")
    }
    
    func testGameOverScreenAppears() throws {
        // Simula um número de toques suficiente para perder todas as vidas
        for _ in 0..<5 {
            let numberButton = app.buttons.element(boundBy: 0)
            numberButton.tap()
        }
        
        // Verifica se a tela de Game Over apareceu
        let gameOverLabel = app.staticTexts["GAME OVER"]
        XCTAssertTrue(gameOverLabel.exists, "A tela de Game Over deveria aparecer após perder todas as vidas.")
    }
}
