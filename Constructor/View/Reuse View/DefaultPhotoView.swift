//
//  DefaultPhotoView.swift
//  Constructor
//
//  Created by Denys on 27.06.2022.
//

import SwiftUI

struct DefaultPhotoView: View {
    
    let cornerRadius : CGFloat = 50
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius)
                .strokeBorder(Color.black, style: StrokeStyle(lineWidth: 4, lineCap: .butt, lineJoin: .bevel, miterLimit: 0, dash: [5,10], dashPhase: 0))
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(.gray.opacity(0.7))
            Text("Photo")
                .foregroundColor(.white)
            
        }
        .frame(width: 150, height: 150)
    }
}

struct DefaultPhotoView_Previews: PreviewProvider {
    static var previews: some View {
        DefaultPhotoView()
    }
}
