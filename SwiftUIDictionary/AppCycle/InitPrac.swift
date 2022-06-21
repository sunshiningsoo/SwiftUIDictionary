//
//  InitPrac.swift
//  SwiftUIDictionary
//
//  Created by 박성수 on 2022/06/22.
//

import SwiftUI

struct InitPrac: View {
    var number:Int
    
    // View가 그려지기 전에 값을 넣어서 그 값의 변화를 주거나 뷰에 변해진 값을 보여주려 할 때
    // init() 함수를 이용해서 그 값을 뷰가 그려지기 전 넣어 줄 수 있다.
    // 단순한 값 뿐만 아니라, 객체를 대상으로도 가능하다.
    init() {
        number = 10
    }
    
    var body: some View {
        Text("\(number)")
    }
}

struct InitPrac_Previews: PreviewProvider {
    static var previews: some View {
        InitPrac()
    }
}
