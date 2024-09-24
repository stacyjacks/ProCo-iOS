//
//  ProCoApp.swift
//  ProCo-iOS
//
//  Created by Anastasia on 19/9/24.
//

import SwiftUI
import SwiftData

@main
struct ProCoApp: App {
    var body: some Scene {
        WindowGroup {
            DashboardView()
        }
        .modelContainer(for: [GoalData.self, Input.self, Saved.self])
    }
}
