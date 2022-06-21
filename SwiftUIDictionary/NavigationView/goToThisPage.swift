//
//  goToThisPage.swift
//  SwiftUIDictionary
//
//  Created by 박성수 on 2022/04/22.
//

import SwiftUI

struct goToThisPage: View {
    var body: some View {
        Text("This is goToThisPage")
            .navigationTitle("Here is goToThisPage")
    }
}

struct goToThisPage_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            goToThisPage()
        }
        
    }
}
