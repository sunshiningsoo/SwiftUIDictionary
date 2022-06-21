//
//  ModalForFullScreen.swift
//  SwiftUIDictionary
//
//  Created by 박성수 on 2022/04/30.
//

import SwiftUI

struct ModalForFullScreen: View {
    @State var showModal:Bool = false
    
    var body: some View {
        VStack{
            Button(action: {
                showModal.toggle()
            }, label: {
                Text("Click and Full Modal Come out!")
            })
            .fullScreenCover(isPresented: $showModal){
                ModalFull(showModal: $showModal)
            }
        }
    }
}

struct ModalFull: View{
    @Binding var showModal:Bool
    
    var body: some View{
        VStack(spacing:30){
            Text("This is full screen of Modal View")
            Button(action: {
                showModal.toggle()
            }, label: {
                Text("click to close Modal")
            })
        }
    }
}

struct ModalForFullScreen_Previews: PreviewProvider {
    static var previews: some View {
        ModalForFullScreen()
    }
}
