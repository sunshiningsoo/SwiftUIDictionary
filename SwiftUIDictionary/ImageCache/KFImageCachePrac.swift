//
//  ImageCachePrac.swift
//  SwiftUIDictionary
//
//  Created by 박성수 on 2023/07/10.
//

import SwiftUI
import Kingfisher

struct KFImageCachePrac: View {
    var body: some View {
        KFImage(URL(string: "https://randomuser.me/api/portraits/men/50.jpg"))
            .renderingMode(.original)
            .onSuccess { r in
                print("success", r)
            }
            .onFailure { r in
                print("failure", r)
            }
    }
}

struct ImageCachePrac_Previews: PreviewProvider {
    static var previews: some View {
        KFImageCachePrac()
    }
}
