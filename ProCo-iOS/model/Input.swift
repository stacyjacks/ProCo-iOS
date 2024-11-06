//
//  Input.swift
//  ProCo-iOS
//
//  Created by Anastasia on 19/9/24.
//

import Foundation
import SwiftData

@Model
class Input: Identifiable {
    var id: Int
    var input: Float
    var time: String
    
    init(id: Int, input: Float, time: String) {
        self.id = id
        self.input = input
        self.time = time
    }
}
