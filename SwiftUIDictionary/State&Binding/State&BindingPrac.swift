//
//  State&BindingPrac.swift
//  SwiftUIDictionary
//
//  Created by 박성수 on 2022/04/24.
//

import SwiftUI

struct State_BindingPrac: View {
    @State private var thisOn: Bool = false
    
    var body: some View {
        ScrollView{
            Toggle(isOn: $thisOn){
                Text("thisOn is")
            }
            BindingHere(thisOn: $thisOn)
        }
        .padding()
    }
}

struct State_BindingPrac_Previews: PreviewProvider {
    static var previews: some View {
        State_BindingPrac()
    }
}
