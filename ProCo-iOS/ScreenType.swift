//
//  ScreenType.swift
//  ProCo-iOS
//
//  Created by Anastasia on 19/9/24.
//

import Foundation

enum ScreenType {
    case AddGoal, AddSaved, AddInput
    
    var title: String {
        switch self {
        case .AddGoal:
            return "Set goal"
        case .AddSaved:
            return "New preset"
        case .AddInput:
            return "New input"
        }
    }
}
