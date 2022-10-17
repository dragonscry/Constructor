//
//  BasketView.swift
//  Constructor
//
//  Created by Denys on 03.10.2022.
//

import SwiftUI

struct BasketView: View {
    
    @State var count: Int
    
    var height: CGFloat
    var width: CGFloat
    
    var body: some View {
        ZStack {
            Image(systemName: "cart")
                .resizable()
                .scaledToFit()
//            if count > 0 {
                Text("\(count)")
                    .fontWeight(.bold)
                    .font(.system(size: height/3))
                    .foregroundColor(.white)
                    .padding(.horizontal, 3)
                    .background {
                        Capsule()
                            .fill(Color.red)
                    }
                    .offset(x: width/2, y: -height/2)
//            }


        }
        .frame(width: width, height: height)
    }
}

struct BasketView_Previews: PreviewProvider {
    static var previews: some View {
        BasketView(count: 1, height: 30, width: 30)
    }
}
