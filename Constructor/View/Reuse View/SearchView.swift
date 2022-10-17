//
//  SearchView.swift
//  Constructor
//
//  Created by Denys on 29.08.2022.
//

import SwiftUI

struct SearchView: View {
    
    @Binding var searchText: String
    
    var body: some View {
    
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(
                        searchText.isEmpty ? Color.secondary : Color.black
                    )
                TextField("Search by name or symbol...", text: $searchText)
                    .foregroundColor(Color.black)
                    .disableAutocorrection(true)
                    .overlay(Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x: 10)
                        .foregroundColor(Color.black)
                        .opacity(searchText.isEmpty ? 0.0 : 1.0)
                        .onTapGesture {
                            UIApplication.shared.endEdtitng()
                            self.searchText = ""
                        }
                        , alignment: .trailing)
            }
            .font(.headline)
            .padding()
            .background(RoundedRectangle(cornerRadius: 25).fill(Color.gray.opacity(0.2))
                .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 0)
            )
            .padding()
        }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(searchText: .constant(""))
    }
}
