//
//  NavigationViewPrac.swift
//  SwiftUIDictionary
//
//  Created by 박성수 on 2022/04/22.
//

import SwiftUI

struct NavigationViewPrac: View {
    var body: some View {
        NavigationView{
            NavigationLink(destination:goToThisPage()){
                Text("click")
                    .padding()
                    .clipShape(Circle())
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(20)
            }
            .navigationTitle("Navigation")
        }
        
    }
}

struct NavigationViewPrac_Previews: PreviewProvider {
    static var previews: some View {
        NavigationViewPrac()
    }
}
