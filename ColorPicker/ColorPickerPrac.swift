//
//  ColorPickerPrac.swift
//  SwiftUIDictionary
//
//  Created by 박성수 on 2022/04/27.
//

import SwiftUI

struct ColorPickerPrac: View {
    @State private var bgColor =
            Color(.sRGB, red: 0.98, green: 0.9, blue: 0.2)

        var body: some View {
            VStack {
                ColorPicker("Alignment Guides", selection: $bgColor, supportsOpacity: false)
                //supportsOpacity : false 는 색상을 선택할 때 opacity를 선택할 수 있는 유무를 제공해준다.
                //supportsOpacity : false provides chosing opacity of the color
                Rectangle()
                    .frame(width: 100, height: 100)
                    .foregroundColor(bgColor)
            }
        }
}

struct ColorPickerPrac_Previews: PreviewProvider {
    static var previews: some View {
        ColorPickerPrac()
    }
}
