//
//  main.swift
//  MarkovDecisionProcesses
//
//  Created by Samuel Donovan on 2/24/22.
//

import Foundation

let mdpSolver = MDPSolver(getSuccessors: PMBJgetSuccessors, initialGuesses: PMBJinitialGuesses)
for i in 0..<10 {
    print(i)
    mdpSolver.prettyPrint()
    mdpSolver.advance()
}
mdpSolver.prettyPrint()
