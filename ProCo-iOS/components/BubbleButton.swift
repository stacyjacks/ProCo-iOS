//
//  BubbleButton.swift
//  ProCo-iOS
//
//  Created by Anastasia on 12/11/24.
//

import SwiftUI

struct BubbleButton: View {
    let action: () -> Void
    let value: Float
    
    var body: some View {
        Button {
            action()
        } label: {
            Text("\(String(value)) gr")
                .fontWeight(.bold)
                .font(.system(size: CGFloat(maxFont(value: value))))
                .frame(minWidth: 60, maxWidth: 120, minHeight: 60, maxHeight: 120)
                .frame(
                    width: CGFloat(maxSize(value: value)),
                    height: CGFloat(maxSize(value: value))
                )
        }
        .foregroundColor(Color("darkPurple"))
        .background(
            Circle()
                .fill(.white)
                .shadow(radius: 10)
                .frame(minWidth: 60, maxWidth: 150, minHeight: 60, maxHeight: 150)
        )
        .padding(.S)
    }
    
    private func maxSize(value: Float) -> Float {
        if value > 120 {
            120
        } else if value < 60 {
            value * 5
        } else {
            value * 3.5
        }
    }
    
    private func maxFont(value: Float) -> Float {
        if value > 30 {
            30
        } else if value <= 15 {
            15
        } else {
            value * 0.9
        }
    }
}

#Preview {
    BubbleButton(
        action: {}, value: 20.0
    )
}
