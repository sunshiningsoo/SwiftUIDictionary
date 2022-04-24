//
//  GeometryReaderPrac.swift
//  SwiftUIDictionary
//
//  Created by 박성수 on 2022/04/24.
//

import SwiftUI

struct GeometryReaderPrac: View {
    var body: some View {
        GeometryReader{ geo in
            Image(systemName: "xmark")
                .foregroundColor(.blue)
                .position(x:geo.size.width/3, y:geo.size.height/2)
            Image(systemName: "xmark")
                .foregroundColor(.red)
                .font(.system(size: geo.size.width))
                .position(x:geo.size.width/2, y:geo.size.height/2)
        }
    }
}

struct GeometryReaderPrac_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReaderPrac()
    }
}
