//
//  SearchTempView.swift
//  SwiftUIDictionary
//
//  Created by 박성수 on 2023/03/18.
//

import SwiftUI

struct SearchTempView: View {
    @StateObject var searchManager = SearchManager()
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    TextField("Text", text: $searchManager.searchText)
                        .padding()
                    Spacer()
                    Button {
                        searchManager.search()
                    } label: {
                        Image(systemName: "magnifyingglass")
                    }
                    .padding()
                }
                .background (
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 1)
                        .opacity(0.5)
                )
                .padding()
                
                List($searchManager.filteredData, id: \.self) { item in
                    NavigationLink(destination: EmptyView()) {
                        Text(item.wrappedValue)
                    }
                }
                Spacer()
            }
            
        }
    }
}

struct SearchTempView_Previews: PreviewProvider {
    static var previews: some View {
        SearchTempView()
    }
}
