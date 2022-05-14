//
//  StepperPrac.swift
//  SwiftUIDictionary
//
//  Created by 박성수 on 2022/05/07.
//

import SwiftUI

struct StepperPrac: View {
    @State var isStepping:Int = 3
    @State var value = 0
    var Properties:[String] = ["111", "222", "333", "444", "555"]
    
    var body: some View {
        VStack(spacing: 50) {
            Stepper(value:$isStepping, in:0...20){
                Text("isStepping : \(isStepping)")
            }
            
            Stepper(label: {Text("This is Preperty Stepper : \(Properties[value])")}, onIncrement: {
                if value < Properties.count - 1{
                    value += 1
                }else{
                    value = 4
                }
            }, onDecrement: {
                if value < 1 {
                    value = 0
                }else{
                    value -= 1
                }
            })
        }
        .padding()
    }
}

struct StepperPrac_Previews: PreviewProvider {
    static var previews: some View {
        StepperPrac()
    }
}
