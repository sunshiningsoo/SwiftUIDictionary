//
//  Text.swift
//  SwiftUIDictionary
//
//  Created by 박성수 on 2022/04/15.
//

import SwiftUI

struct TextPrac: View {
    var body: some View {
        VStack{
            Text("this is text")
                .background(.red)
                .padding()
            Text("this is text")
                .padding()
                .background(.red)
            Text("this is text")
                .bold()
                .font(.system(size:40))
                .foregroundColor(Color.blue)
            Text("this is text")
                .font(.system(size:40, weight: .thin))
                .foregroundColor(Color.blue)
                .italic()
                .underline()
        }
    }
}

struct Text_Previews: PreviewProvider {
    static var previews: some View {
        TextPrac()
    }
}
