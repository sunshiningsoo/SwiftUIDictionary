//
//  ButtonAlertManyChoice.swift
//  SwiftUIDictionary
//
//  Created by 박성수 on 2022/04/20.
//

import SwiftUI

struct ButtonAlertManyChoice: View {
    @State var isPresent:Bool = false
    
    var body: some View {
        Button("Alert!"){
            isPresent.toggle()
        }
        .alert(isPresented:$isPresent){
            Alert(title: Text("this is text"), message: Text("this is message"), primaryButton: .default(Text("left")), secondaryButton: .default(Text("right")))
        }
    }
}

struct ButtonAlertManyChoice_Previews: PreviewProvider {
    static var previews: some View {
        ButtonAlertManyChoice()
    }
}
