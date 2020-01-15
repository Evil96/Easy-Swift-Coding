//
//  Habit.swift
//  Habits
//
//  Created by Edgar Vilchis on 14/01/20.
//  Copyright © 2020 Edgar Vilchis. All rights reserved.
//

import Foundation

struct Habit: Codable, Identifiable, Hashable {
    let id = UUID()
    let name: String
    let type: String
    var amount: Int
}
