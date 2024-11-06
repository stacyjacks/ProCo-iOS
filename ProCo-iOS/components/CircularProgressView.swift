//
//  CircularProgressView.swift
//  ProCo-iOS
//
//  Created by Anastasia on 6/11/24.
//

import SwiftUI

struct CircularProgressView: View {
    let current: Float
    let goal: Float
    
    var body: some View {
        ZStack {
            ActivityProgressView(
                color: Color.black,
                current: Int(current),
                goal: Int(goal),
                progress: CGFloat(current / goal)
            )
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

struct ActivityProgressView: View {
    let color: Color
    let current: Int
    let goal: Int
    let progress: CGFloat
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 20)
                .opacity(0.1)
                .foregroundStyle(Color("darkPurple"))
            
            Circle()
                .trim(from: 0.0, to: progress)
                .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round))
                .foregroundStyle(Color("darkPurple"))
                .rotationEffect(Angle(degrees: 275.0))
            
            Text(
                "\(String(current)) of \(String(goal))"
            )
        }
    }
}

#Preview {
    CircularProgressView(current: 80, goal: 100)
}
