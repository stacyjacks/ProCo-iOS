//
//  Extensions.swift
//  ProCo-iOS
//
//  Created by Anastasia on 19/9/24.
//

import Foundation
import SwiftUI
import WidgetKit

extension CGFloat {
    /// 8 pt of spacing
    static var XS = 8.0
    
    /// 16 pt of spacing
    static var S = 16.0
    
    /// 24 pt of spacing
    static var M = 24.0
    
    /// 32 pt of spacing
    static var L = 32.0
    
    /// 40 pt of spacing
    static var XL = 40.0
}

extension Binding where Value == Bool {
    init<T>(value: Binding<T?>) {
        self.init {
            value.wrappedValue != nil
        }
        set: { newValue in
            if !newValue {
                value.wrappedValue = nil
            }
        }
    }
}

extension GoalData {
    func updateCurrent(_ input: [Input]) {
        self.current =
        if input.isEmpty {
            0.0
        } else {
            input.map { $0.input }.reduce(0, +)
        }
        
        modelContext?.insert(self)
        try? modelContext?.save()
        
        WidgetCenter.shared.reloadAllTimelines()
    }
}
