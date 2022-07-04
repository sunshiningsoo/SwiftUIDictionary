//
//  PreviewLayoutPrac.swift
//  SwiftUIDictionary
//
//  Created by 박성수 on 2022/07/04.
//

import SwiftUI

struct PreviewLayoutPrac: View {
    var body: some View {
        HStack {
            Image("flower")
                .resizable()
                .frame(width: 100, height: 100)
                .aspectRatio(contentMode: .fit)
            Spacer()
            Text("this is flower")
                .foregroundColor(.white)
                .padding()
        }
        .cornerRadius(10)
    }
}

struct PreviewLayoutPrac_Previews: PreviewProvider {
    static var previews: some View {
        PreviewLayoutPrac()
            .background(.red)
            .previewLayout(.sizeThatFits)
        // preview is shown only with usable frame
    }
}
