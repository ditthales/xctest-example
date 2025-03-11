//
//  FizzBuzzBrainTests.swift
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