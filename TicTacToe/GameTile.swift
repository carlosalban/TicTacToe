//
//  GameTile.swift
//  TicTacToe
//
//  Created by Carlos Alban on 1/19/24.
//

import Foundation
import SwiftData

struct GameTile: Identifiable, Hashable {
    enum Value {
        case x, o, empty
    }
    
    let value: Value
    let id: Int
    
    init(id: Int, value: Value) {
        self.id = id
        self.value = value
    }
    
    var displayValue: String? {
        switch value {
        case .empty:
            return nil
        case .o:
            return "O"
        case .x:
            return "X"
        }
    }
}
