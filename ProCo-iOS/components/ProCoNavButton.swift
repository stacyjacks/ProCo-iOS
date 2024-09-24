//
//  ProCoNavButton.swift
//  ProCo-iOS
//
//  Created by Anastasia on 19/9/24.
//

import SwiftUI

struct ProCoNavButton: View {
    var string: String? = nil
    var icon: String? = nil
    var width: CGFloat? = .infinity
    
    var body: some View {
        if string != nil {
            Text(LocalizedStringKey(string!))
                .padding(.XS)
                .bold()
                .frame(maxWidth: width)
                .foregroundColor(.white)
                .background(Color.darkPurple)
                .cornerRadius(.S)
        } else {
            Image(systemName: icon!)
                .padding(.XS)
                .frame(maxWidth: width)
                .foregroundColor(.white)
                .background(Color.darkPurple)
                .cornerRadius(.S)
        }
    }
}

#Preview {
    ProCoNavButton(string: "plus")
}
