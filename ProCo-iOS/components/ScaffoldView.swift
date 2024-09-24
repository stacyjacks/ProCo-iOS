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
            Text(title)
                .foregroundColor(.white)
                .padding()
                .font(.headline)
            view
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(purpleGradient)
    }
}

#Preview {
    ScaffoldView(title: "Today's goal", view: EmptyView())
}
