//
//  ButtonAlert.swift
//  SwiftUIDictionary
//
//  Created by 박성수 on 2022/04/20.
//

import SwiftUI

struct ButtonAlertOneChoice: View {
    @State var isPresented:Bool = false
    @State var isPresented2:Bool = false
    
    var body: some View {
        VStack {
            Button("Alert is coming"){
                isPresented.toggle()
            }
            .alert(isPresented:$isPresented){
                Alert(title: Text("this is title"), message: Text("this is message"), dismissButton: .default(Text("dismiss")))
            }
            
            
            // 하단의 버튼은 클릭시 just OK 만 나오게 된다.
            Button(action: {
                isPresented2.toggle()
            }, label: {
                Text("Alert just OK")
            })
            .alert(isPresented: $isPresented2){
                Alert(title: Text("This is Title2"), message: Text("This is Message2"), dismissButton: .none)
            }
        }
    }
}

struct ButtonAlert_Previews: PreviewProvider {
    static var previews: some View {
        ButtonAlertOneChoice()
    }
}
