//
//  StateAndBinding.swift
//  SwiftUIDictionary
//
//  Created by 박성수 on 2022/05/08.
//

import SwiftUI

struct StateAndBinding: View {
    @State var stateVar:Int = 0
    var body: some View {
        VStack(spacing: 50){
            Button(action: {
                stateVar += 1
            }, label: {
                Text("Plus the Binding value!")
                
            })
            BindingCome(stateVar: $stateVar)
        }
    }
}

struct BindingCome: View {
    @Binding var stateVar:Int
    
    var body : some View{
        Text("Binding here : \(stateVar)")
    }
}

struct StateAndBinding_Previews: PreviewProvider {
    static var previews: some View {
        StateAndBinding()
    }
}
