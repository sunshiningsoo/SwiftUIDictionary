//
//  ImagePrac.swift
//  SwiftUIDictionary
//
//  Created by 박성수 on 2022/04/16.
//

import SwiftUI

struct ImagePrac: View {
    var body: some View {
        Image("flower")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .clipShape(Circle())
            .shadow(color: .black, radius: 10)
            .overlay(Circle().stroke(Color.blue, lineWidth: 5))
    }
}

struct ImagePrac_Previews: PreviewProvider {
    static var previews: some View {
        ImagePrac()
    }
}
