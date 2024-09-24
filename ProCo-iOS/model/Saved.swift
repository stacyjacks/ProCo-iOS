//
//  Saved.swift
//  ProCo-iOS
//
//  Created by Anastasia on 19/9/24.
//

import Foundation
import SwiftData

@Model
class Saved {
    var id: Int
    var name: String
    var grams: Float
    
    init(id: Int = 0, name: String = "", grams: Float = 0.0) {
        self.id = id
        self.name = name
        self.grams = grams
    }
}
