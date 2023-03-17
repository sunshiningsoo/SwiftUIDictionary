//
//  StateObjectForEachViewPrac.swift
//  SwiftUIDictionary
//
//  Created by 박성수 on 2023/03/18.
//

import SwiftUI

struct StateObjectForEachViewPrac: View {
    var body: some View {
        NavigationView {
            TabView {
                SearchTempView()
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }
                
                SettingTempView()
                    .tabItem {
                        Image(systemName: "gear")
                        Text("Setting")
                    }
            }
        }
    }
}

struct StateObjectForEachViewPrac_Previews: PreviewProvider {
    static var previews: some View {
        StateObjectForEachViewPrac()
    }
}
