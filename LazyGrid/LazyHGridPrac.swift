//
//  LazyHGridPrac.swift
//  SwiftUIDictionary
//
//  Created by 박성수 on 2022/05/11.
//

import SwiftUI

struct LazyHGridPrac: View {
    
    var data:[String] = Array(0...100).map{String($0)}
//    var rows:[GridItem] = [GridItem(.adaptive(minimum:100))]
    var rows:[GridItem] = [GridItem(.flexible(maximum:100)), GridItem(.flexible(maximum:100))]
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: rows){
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

struct LazyHGridPrac_Previews: PreviewProvider {
    static var previews: some View {
        LazyHGridPrac()
    }
}
