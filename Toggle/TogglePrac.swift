//
//  TogglePrac.swift
//  SwiftUIDictionary
//
//  Created by 박성수 on 2022/04/21.
//

import SwiftUI

struct TogglePrac: View {
    @State var toggleIs:Bool = false
    
    var body: some View {
        HStack{
            Toggle(isOn: $toggleIs){
                Text("this")
            }
        }
        .padding()
    }
}

struct TogglePrac_Previews: PreviewProvider {
    static var previews: some View {
        TogglePrac()
    }
}
