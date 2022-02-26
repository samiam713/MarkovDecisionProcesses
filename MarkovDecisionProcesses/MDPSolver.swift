//
//  MDPSolver.swift
//  MarkovDecisionProcesses
//
//  Created by Samuel Donovan on 2/26/22.
//

import Foundation

struct StateSuccessorData<State, Action> {
    var action: Action
    var leadsTo: [(state: State, prob: Double, reward: Double)]
}

class MDPSolver<State: Hashable, Action> {

    var current: [State:(optimal:Double, action: Action)]
    let getSuccessors: (State) -> [StateSuccessorData<State, Action>]
    
    init(getSuccessors: @escaping (State) -> [StateSuccessorData<State, Action>], initialGuesses: [State:(optimal:Double, action: Action)]) {
        self.getSuccessors = getSuccessors
        self.current = initialGuesses
    }
    
    func getCurrentValue(state: State) -> Double {
        // if it's non-terrminal return its value,
        // else it's the .done state and we return 0
        return current[state]?.optimal ?? 0.0
    }
    
    func getOptimalCost(successorData: StateSuccessorData<State,Action>) -> Double {
        var expectedVal = 0.0
        for leads in successorData.leadsTo {
            expectedVal+=leads.prob*(leads.reward + getCurrentValue(state: leads.state))
        }
        return expectedVal
    }
    
    func predictOptimal(state: State) -> (Double, Action) {
        
        var optimalAction: Action? = nil
        var optimalCost = -Double.greatestFiniteMagnitude
        
        for stateSuccessorData in getSuccessors(state) {
            let optimal = getOptimalCost(successorData: stateSuccessorData)
            if optimal > optimalCost {
                optimalCost = optimal
                optimalAction = stateSuccessorData.action
            }
        }
        
        return (optimalCost, optimalAction!)
    }
    
    func advance() {
        var newCurrent = [State:(optimal:Double, action: Action)]()
        for (key, _) in current {
            newCurrent[key] = predictOptimal(state: key)
        }
        current = newCurrent
    }
    
    func prettyPrint() {
        for (state, (optimal, double)) in current {
            print(state, optimal, double)
        }
        print()
    }
}
