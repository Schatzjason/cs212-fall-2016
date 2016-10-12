//
//  RPSMove.swift
//  TwoViewControllers
//
//  Created by ccsfcomputers on 10/4/16.
//  Copyright © 2016 ccsfcomputers. All rights reserved.
//

import Foundation

enum RPSMove: Int {
    case Rock = 0, Paper = 1, Scissors = 2
}

extension RPSMove {
    func random() -> RPSMove {
        let randomValue = Int(arc4random()) % 3
        return RPSMove(rawValue: randomValue)!
    }
    
    var stringValue: String {
            switch self {
            case .Rock:
                return "Rock"
            case .Paper:
                return "Paper"
            case .Scissors:
                return "Scissors"
            }
    }

    init?(string: String) {
        switch string {
        case "Rock":
            self = .Rock
        default:
            return nil
        }
    }
}

