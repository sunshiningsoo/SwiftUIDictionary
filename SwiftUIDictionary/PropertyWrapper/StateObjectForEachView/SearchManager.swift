//
//  SearchManager.swift
//  SwiftUIDictionary
//
//  Created by 박성수 on 2023/03/18.
//

import Foundation

class SearchManager: ObservableObject {
    @Published var searchText: String = "" {
        didSet {
            reset()
            search()
        }
    }
    var searchData: [String] = ["호랑이", "사자", "거북이", "사슴", "맹수", "맹금류"]
    var filteredData: [String] = []
    
    init() {
        filteredData = searchData
    }
    
    func search() {
        if !searchText.isEmpty {
            searchData.forEach { word in
                if word.contains(searchText) {
                    filteredData.append(word)
                }
            }
            filteredData = filteredData.sorted { $0 < $1 }
        } else {
            filteredData = searchData
        }
    }
    
    private func reset() {
        filteredData = []
    }
    
}
