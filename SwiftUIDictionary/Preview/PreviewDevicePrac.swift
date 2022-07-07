//
//  PreviewDevicePrac.swift
//  SwiftUIDictionary
//
//  Created by 박성수 on 2022/07/07.
//

import SwiftUI

struct PreviewDevicePrac: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct PreviewDevicePrac_Previews: PreviewProvider {
    static var previews: some View {
        PreviewDevicePrac()
            .previewDevice(PreviewDevice(rawValue: "iPad Air (5th generation)"))
    }
}
