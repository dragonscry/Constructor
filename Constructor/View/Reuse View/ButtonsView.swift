//
//  ButtonsView.swift
//  Constructor
//
//  Created by Denys on 27.06.2022.
//

import SwiftUI

// Default button
struct DefaultButton: View {
    
    let text: String
    
    var body: some View {
        Text("\(text.uppercased())")
            .padding(.horizontal, 5)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.black)
            )
    }
}

struct ButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        DefaultButton(text: "Save")
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
