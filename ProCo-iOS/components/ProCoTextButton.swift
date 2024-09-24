//
//  ProCoTextButton.swift
//  ProCo-iOS
//
//  Created by Anastasia on 19/9/24.
//

import SwiftUI

struct ProCoTextButton: View {
    let action: () -> Void
    let string: String
    var width: CGFloat? = .infinity
    
    var body: some View {
        Button(
            action: { action() },
            label: {
                Text(LocalizedStringKey(string))
                    .padding(.XS)
                    .bold()
            }
        )
        .frame(maxWidth: width)
        .foregroundColor(.darkPurple)
    }
}

#Preview {
    ProCoTextButton(
    action: {}, string: "cancel")
}
