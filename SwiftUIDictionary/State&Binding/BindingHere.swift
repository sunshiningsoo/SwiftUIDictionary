//
//  BindingHere.swift
//  SwiftUIDictionary
//
//  Created by 박성수 on 2022/04/24.
//

import SwiftUI

struct BindingHere: View {
    @Binding var thisOn: Bool
    
    var body: some View {
        Text(thisOn ? "this is true now" : "this is false now")
    }
}

struct BindingHere_Previews: PreviewProvider {
    static var previews: some View {
        BindingHere(thisOn: .constant(false))
    }
}
