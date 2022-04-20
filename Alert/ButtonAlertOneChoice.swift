//
//  ButtonAlert.swift
//  SwiftUIDictionary
//
//  Created by 박성수 on 2022/04/20.
//

import SwiftUI

struct ButtonAlertOneChoice: View {
    @State var isPresented:Bool = false
    
    var body: some View {
        Button("Alert is coming"){
            isPresented.toggle()
        }
        .alert(isPresented:$isPresented){
            Alert(title: Text("this is title"), message: Text("this is message"), dismissButton: .default(Text("dismiss")))
        }
    }
}

struct ButtonAlert_Previews: PreviewProvider {
    static var previews: some View {
        ButtonAlertOneChoice()
    }
}
