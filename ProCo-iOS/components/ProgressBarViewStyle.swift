//
//  ProgressBarViewStyle.swift
//  ProCo-iOS
//
//  Created by Anastasia on 19/9/24.
//

import SwiftUI

struct ProgressBarViewStyle: ProgressViewStyle {
    let current: Int
    
    func makeBody(configuration: Configuration) -> some View {
        let progress = configuration.fractionCompleted ?? 0
        let height = 20.0

        GeometryReader { geometry in
            VStack {
                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                    .fill(.lightPurple)
                    .overlay(alignment: .leading) {
                        RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                            .fill(.darkPurple)
                            .frame(width: geometry.size.width * CGFloat(progress))
                            .overlay(
                                alignment: .trailing,
                                content: {
                                    Text(String(current))
                                        .foregroundColor(.white)
                                        .padding(.XS)
                                })
                    }
            }
        }.frame(height: height)
    }
}
