//
//  TextFieldPrac.swift
//  SwiftUIDictionary
//
//  Created by 박성수 on 2022/05/16.
//

import SwiftUI

struct TextFieldPrac: View {
    enum FocusedField {
           case username, password
       }

       @FocusState private var focusedField: FocusedField?
       @State private var username = "Anonymous"
       @State private var password = "sekrit"

       var body: some View {
           VStack {
               TextField("Enter your username", text: $username)
                   .focused($focusedField, equals: .username)

               SecureField("Enter your password", text: $password)
                   .focused($focusedField, equals: .password)
           }
           .onSubmit {
               if focusedField == .username {
                   focusedField = .password
               } else {
                   focusedField = nil
               }
           }
       }
}

struct TextFieldPrac_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldPrac()
    }
}
