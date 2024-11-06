//
//  ProCoWidgetExtension.swift
//  ProCo-iOS
//
//  Created by Anastasia on 6/11/24.
//

import WidgetKit
import SwiftUI

@main
struct ProCoWidgetExtension: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: "ProCoWidget-Extension",
            provider: ProCoEntryTimelineProvider()
        ) { entry in
            ProCoWidgetView(entry: entry)
        }
        .configurationDisplayName("ProCo")
        .description("Current")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}
