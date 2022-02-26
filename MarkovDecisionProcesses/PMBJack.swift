//
//  PMBJack.swift
//  MarkovDecisionProcesses
//
//  Created by Samuel Donovan on 2/26/22.
//

import Foundation

enum PMBJState: Hashable {
    case playing(Int)
    case done
}

enum PMBJAction {
    case hit
    case stand
    case null
}

func PMBJgetSuccessors(state: PMBJState) -> [StateSuccessorData<PMBJState, PMBJAction>] {
    switch state {
    case .playing(let val):
        var ans = [(state: PMBJState, prob: Double, reward: Double)]()
        var card = 2
        
        var canOverFlow = true
        while val+card < 6 {
            ans.append((PMBJState.playing(val+card), 1.0/3.0, 0.0))
            if card == 4 {
                canOverFlow = false
                break
            }
            card+=1
        }
        if canOverFlow {
            var probOverflow = Double(val - 1)/3.0
            if probOverflow > 1.0 {probOverflow = 1.0}
            ans.append((PMBJState.done,probOverflow,0.0))
        }
        return [
            StateSuccessorData(action: .stand, leadsTo: [(.done,1.0,Double(val))]),
            StateSuccessorData(action: .hit, leadsTo: ans)
        ]
    case .done:
        fatalError()
    }
}

let PMBJinitialGuesses: [PMBJState:(optimal:Double, action: PMBJAction)] = [
    .playing(0):(optimal: 0.0, action: .null),
    .playing(2):(optimal: 0.0, action: .null),
    .playing(3):(optimal: 0.0, action: .null),
    .playing(4):(optimal: 0.0, action: .null),
    .playing(5):(optimal: 0.0, action: .null),
]

