//
//  SliderPrac.swift
//  SwiftUIDictionary
//
//  Created by 박성수 on 2022/05/09.
//

import SwiftUI

struct SliderPrac: View {
    @State var value:Float = 20.0
    
    var body: some View {
        VStack(spacing:50) {
            Slider(value: $value, in:0...100)
            Text("The value is  : \(value)")
        }
    }
}

struct SliderPrac_Previews: PreviewProvider {
    static var previews: some View {
        SliderPrac()
    }
}
