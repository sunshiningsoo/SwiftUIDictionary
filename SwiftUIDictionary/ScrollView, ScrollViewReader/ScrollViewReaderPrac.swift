//
//  ScrollViewReaderPrac.swift
//  SwiftUIDictionary
//
//  Created by 박성수 on 2022/04/30.
//

import SwiftUI

struct ScrollViewReaderPrac: View {
    @Namespace var topId
    @Namespace var bottomId
    
    var body: some View {
        ScrollViewReader { scroll in
            ScrollView {
                Button("Move to Bottom") {
                    withAnimation {
                        scroll.scrollTo(bottomId)
                    }
                }.id(topId)
                
                ForEach(0..<100, id:\.self) {
                    Text("\($0)")
                }
                
                Button("Move to Top") {
                    withAnimation {
                        scroll.scrollTo(topId)
                    }
                }.id(bottomId)
            }
        }
    }
}

struct ScrollViewReaderPrac_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewReaderPrac()
    }
}
