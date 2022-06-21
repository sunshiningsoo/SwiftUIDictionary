//
//  ButtonPrac.swift
//  SwiftUIDictionary
//
//  Created by 박성수 on 2022/04/17.
//

import SwiftUI

struct ButtonPrac: View {
    var body: some View {
        VStack(spacing:50){
            Button("This is Button") {
                print("Button pushed")
            }
            .background(.red)
            .foregroundColor(.white)
            .cornerRadius(30)
            
            Button(action: {
                print("Button2 pushed")
            }, label: {
                Text("This is button2")
                
            })
        }
    }
}

struct ButtonPrac_Previews: PreviewProvider {
    static var previews: some View {
        ButtonPrac()
    }
}
