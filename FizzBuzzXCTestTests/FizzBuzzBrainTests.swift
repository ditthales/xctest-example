//
//  FizzBuzzBrainTests.swift
//  FizzBuzzXCTestTests
//
//  Created by ditthales on 05/02/25.
//

@testable import FizzBuzzXCTest
import XCTest

final class FizzBuzzBrainTests: XCTestCase {
    
    let brain = FizzBuzzBrain()    
    
    func testSayFizz(){
        let result = brain.correctMove(forNumber: 3)
        XCTAssertEqual(result, Move.fizz)
    }
    
    func testSayBuzz(){
        let result = brain.correctMove(forNumber: 5)
        XCTAssertEqual(result, Move.buzz)
    }
    
    func testSayFizzBuzz(){
        let result = brain.correctMove(forNumber: 15)
        XCTAssertEqual(result, Move.fizzBuzz)
    }
    
    func testIfNumberIsOne(){
        let result = brain.correctMove(forNumber: 1)
        XCTAssertEqual(result, Move.number)
    }
    
    
    

}
