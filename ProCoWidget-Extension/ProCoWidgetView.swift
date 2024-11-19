//
//  ProCoEntryView.swift
//  ProCo-iOS
//
//  Created by Anastasia on 6/11/24.
//

import SwiftUI
import WidgetKit

struct ProCoWidgetView: View {
    var entry: ProCoEntryTimelineProvider.Entry
    
    var body: some View {
        VStack {
            CircularProgressView(
                color: Color("darkPurple"),
                lineWidth: 20,
                current: entry.goalData.last?.current ?? 0.0,
                goal: entry.goalData.last?.goal ?? 0.0,
                bottomText: "grams"
            )
            .padding(.vertical)
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .center
        )
        .containerBackground(for: .widget) {
            Color.white
        }
    }
}

#Preview {
    ProCoWidgetView(
        entry: ProCoEntry(
            date: Date(),
            goalData: []
        )
)
}
