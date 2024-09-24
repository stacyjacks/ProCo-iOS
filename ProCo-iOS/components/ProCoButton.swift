//
//  ProCoButton.swift
//  ProCo-iOS
//
//  Created by Anastasia on 19/9/24.
//

import SwiftUI

struct ProCoButton: View {
    let action: () -> Void
    var string: String? = nil
    var icon: String? = nil
    var width: CGFloat? = .infinity
    
    var body: some View {
        Button(
            action: { action() },
            label: {
                if string != nil {
                    Text(LocalizedStringKey(string!))
                        .padding(.XS)
                        .bold()
                } else {
                    Image(systemName: icon!)
                        .padding(.XS)
                }
            }
        )
        .frame(maxWidth: width)
        .foregroundColor(.white)
        .background(Color.darkPurple)
        .cornerRadius(.S)
    }
}

#Preview {
    ProCoButton(action: {}, string: "save")
}
