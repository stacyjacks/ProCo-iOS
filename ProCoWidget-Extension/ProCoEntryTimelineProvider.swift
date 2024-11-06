//
//  ProCoEntryTimelineProvider.swift
//  ProCo-iOS
//
//  Created by Anastasia on 6/11/24.
//

import WidgetKit
import SwiftData

struct ProCoEntryTimelineProvider: TimelineProvider {
    @MainActor func placeholder(in context: Context) -> ProCoEntry {
        ProCoEntry(date: Date(), goalData: getData())
    }
    
    @MainActor func getSnapshot(in context: Context, completion: @escaping (ProCoEntry) -> Void) {
        completion(ProCoEntry(date: Date(), goalData: getData()))
    }
    
    @MainActor func getTimeline(in context: Context, completion: @escaping (Timeline<ProCoEntry>) -> Void) {
        let entry = ProCoEntry(date: Date(), goalData: getData())
        
        completion(Timeline(entries: [entry], policy: .atEnd))
    }
    
    @MainActor
    private func getData() -> [GoalData] {
        guard let modelContainer =
            try? ModelContainer(for: GoalData.self, Input.self, Saved.self)
        else {
            return [] // to do improve later
        }
        
        let descriptor = FetchDescriptor<GoalData>()
        
        do {
            return try modelContainer.mainContext.fetch(descriptor)
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
}
