//
//  BrainSpy.swift
//  FizzBuzzXCTest
//
//  Created by ditthales on 04/02/25.
//

import Foundation
@testable import FizzBuzzGame

class BrainSpy: BrainProtocol {
    
    var isCorrectMoveCalled : Bool = false
    var numberCalledOnCorrectMove : Int?
    var correctMoveReturnedMove : Move = .fizz
    
    func correctMove(forNumber number: Int) -> Move {
        numberCalledOnCorrectMove = number
        isCorrectMoveCalled = true
        
        return correctMoveReturnedMove
    }
    
}
