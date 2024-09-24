//
//  GoalData.swift
//  ProCo-iOS
//
//  Created by Anastasia on 19/9/24.
//

import Foundation
import SwiftData

@Model
class GoalData {
    var goal: Float
    var current: Float
    
    init(goal: Float = 0.0, current: Float = 0.0) {
        self.goal = goal
        self.current = current
    }
}
