//
//  SpacerPrac.swift
//  SwiftUIDictionary
//
//  Created by 박성수 on 2022/04/21.
//

import SwiftUI

struct SpacerPrac: View {
    var body: some View {
        VStack{
            Text("hello")
            Spacer()
            HStack{
                Text("hello")
                Spacer()
                Text("hello")
            }
            Spacer()
            Text("hello")
        }
    }
}

struct SpacerPrac_Previews: PreviewProvider {
    static var previews: some View {
        SpacerPrac()
    }
}
