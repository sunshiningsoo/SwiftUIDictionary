//
//  PickerPrac.swift
//  SwiftUIDictionary
//
//  Created by 박성수 on 2022/04/29.
//

import SwiftUI

struct PickerPrac: View {
    @State var isNow: String = "Red"
    var colorList: [String] = ["Red", "Blue"]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                Picker("pick one thing", selection: $isNow){
                    ForEach(colorList, id:\.self){
                        Text($0)
                    }
                }
                .pickerStyle(.segmented)
                Divider()
                
                Picker("pick one thing", selection: $isNow){
                    ForEach(colorList, id: \.self){
                        Text($0)
                    }
                }
                Divider()
                
                Picker("pick one thing", selection: $isNow){
                    ForEach(colorList, id: \.self){
                        Text($0)
                    }
                }.pickerStyle(.inline)
                Divider()
                
                Picker("pick one thing", selection: $isNow){
                    ForEach(colorList, id: \.self){
                        Text($0)
                    }
                }.pickerStyle(.menu)
                Divider()
                
                Picker("pick one thing", selection: $isNow){
                    ForEach(colorList, id: \.self){
                        Text($0)
                    }
                }.pickerStyle(.wheel)
                
                
                Picker("pick one thing", selection: $isNow){
                    ForEach(colorList, id: \.self){
                        Text($0)
                    }
                }.pickerStyle(SegmentedPickerStyle())
            }
        }
        
    }
}

struct SegmentPickerPrac_Previews: PreviewProvider {
    static var previews: some View {
        PickerPrac()
    }
}
