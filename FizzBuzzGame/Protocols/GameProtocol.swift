//
//  AppDelegate.swift
//  FizzBuzzXCTest
//
//  Created by ditthales on 04/02/25.
//

import Foundation

protocol GameProtocol {
    var score: Int { get }
    var totalLives: Int { get }
    var remainingLives: Int { get }
    
    func isPlayCorrect(move: Move) -> Bool
    
    func playRound(withMove move: Move)
    
}
