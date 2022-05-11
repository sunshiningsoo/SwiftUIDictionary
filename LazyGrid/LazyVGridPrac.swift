//
//  LazyVGridPrac.swift
//  SwiftUIDictionary
//
//  Created by 박성수 on 2022/05/11.
//

import SwiftUI

struct LazyVGridPrac: View {
    
    var data:[String] = Array(0...100).map{"\($0)번째"}
    
    // minimum의 100은 레이아웃의 최소 사이즈를 의미한다.
    // maximum은 레이아웃의 최대 사이즈를 의미한다.
//    var columns:[GridItem] = [GridItem(.adaptive(minimum: 100))]
    
    // .flexible을 사용한다면 각 아이폰의 화면 크기에 맞게 알아서 조절 된다.
    // 배열안에 GridItem을 추가할수록, 열이 한개씩 더 생기게 된다.
    var columns:[GridItem] = [GridItem(.flexible(minimum:100, maximum: 100)), GridItem(.flexible(minimum:100, maximum: 100))]
    
    var body: some View {
        ScrollView{
            LazyVGrid(columns: columns) {
                ForEach(data, id:\.self){ smallData in
                    VStack {
                        Capsule()
                        Text(smallData)
                    }
                    
                }
            }
        }
    }
}


struct LazyVGridPrac_Previews: PreviewProvider {
    static var previews: some View {
        LazyVGridPrac()
    }
}
