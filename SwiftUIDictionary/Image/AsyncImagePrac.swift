//
//  AsyncImagePrac.swift
//  SwiftUIDictionary
//
//  Created by 박성수 on 2022/07/01.
//

import SwiftUI

struct AsyncImagePrac: View {
    let url: String = "https://cdn.pixabay.com/photo/2016/03/21/23/25/link-1271843__480.png"
    // This url is free image got from pixabay
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: url))
            // 비동기로 이미지를 불러오게 된다. 이미지가 불려오기 전에는 빈상태로 Text()만 뷰안에 그려지게 된다.
            Text("this will be load!")
        }
    }
}

struct AsyncImagePrac_Previews: PreviewProvider {
    static var previews: some View {
        AsyncImagePrac()
    }
}
