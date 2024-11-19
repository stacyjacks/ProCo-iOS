//
//  CircularProgressView.swift
//  ProCo-iOS
//
//  Created by Anastasia on 6/11/24.
//

import SwiftUI

struct CircularProgressView: View {
    let color: Color
    var lineWidth: CGFloat = 30
    let current: Float
    let goal: Float
    let bottomText: String
    
    var body: some View {
        ZStack {
            CompletedProgressView(
                color: color,
                lineWidth: lineWidth,
                current: Int(current),
                goal: Int(goal),
                progress: CGFloat(current / goal),
                bottomText: bottomText
            )
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

struct CompletedProgressView: View {
    let color: Color
    let lineWidth: CGFloat
    let current: Int
    let goal: Int
    let progress: CGFloat
    let bottomText: String
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: lineWidth)
                .opacity(0.4)
                .foregroundStyle(color)
            
            Circle()
                .trim(from: 0.0, to: progress)
                .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                .foregroundStyle(color)
                .rotationEffect(Angle(degrees: 275.0))
            VStack {
                Text("\(String(current)) / \(String(goal))")
                    .font(.system(size: 14))
                    .fontWeight(.bold)
                Text(bottomText)
                    .font(.system(size: 12))
            }
        }
    }
}

#Preview {
    CircularProgressView(
        color: Color("darkPurple"),
        lineWidth: 30,
        current: 80,
        goal: 100, bottomText: "grams"
    )
}
