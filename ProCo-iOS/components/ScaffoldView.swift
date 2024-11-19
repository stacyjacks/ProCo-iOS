//
//  ScaffoldView.swift
//  ProCo-iOS
//
//  Created by Anastasia on 19/9/24.
//

import SwiftUI

struct ScaffoldView<Content: View>: View {
    var title: String
    let view: Content
    
    var body: some View {
        VStack {
            view
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(title)
                    .foregroundColor(.darkPurple)
                    .font(.headline)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(purpleGradient)
    }
}

#Preview {
    NavigationStack {
        ScaffoldView(title: "Today's goal", view: EmptyView())
    }
}
