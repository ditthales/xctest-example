//
//  FizzBuzzBrain.swift
//  FizzBuzzXCTest
//
//  Created by ditthales on 04/02/25.
//

import Foundation

class FizzBuzzBrain: BrainProtocol {
    private func isDivisibleBy(divisor: Int, number: Int) -> Bool{
        return number % divisor == 0
    }
    
    func correctMove(forNumber number: Int) -> Move {
        if isDivisibleBy(divisor: 15, number: number){
            return .fizzBuzz
        }else if isDivisibleBy(divisor: 5, number: number){
            return .buzz
        }else if isDivisibleBy(divisor: 3, number: number){
            return .fizz
        }else{
            return .number
        }
        
    }
    
}

