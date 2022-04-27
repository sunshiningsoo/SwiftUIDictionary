//
//  ModalPrac.swift
//  SwiftUIDictionary
//
//  Created by 박성수 on 2022/04/27.
//

import SwiftUI

struct ModalPrac: View {
    @State var showModal:Bool = false
    
    var body: some View {
        VStack{
            Text("Here is main page")
            Button(action: {
                showModal.toggle()
            }, label: {
                Text("Modal up if you click!")
                    .sheet(isPresented: $showModal){
                        ModalPage()
                    }
            })
        }
    }
}

struct ModalPage:View{
    @Environment(\.presentationMode) var presentation
    
    var body: some View{
        VStack {
            Text("This is modal page")
                .foregroundColor(.black)
            Button(action: {
                presentation.wrappedValue.dismiss()
            }, label: {
                Text("click and close the modal")
            })
            .padding()
            .background(RoundedRectangle(cornerRadius: 20).fill(Color.blue))
            .foregroundColor(.white)
        }
        
    }
}

struct ModalPrac_Previews: PreviewProvider {
    static var previews: some View {
        ModalPrac()
    }
}
