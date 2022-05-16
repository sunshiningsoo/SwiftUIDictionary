//
//  SecuredFieldPrac.swift
//  SwiftUIDictionary
//
//  Created by 박성수 on 2022/05/16.
//

import SwiftUI

struct SecuredFieldPrac: View {
    @State var password:String = ""
    
    var body: some View {
        VStack {
            SecureField(text: $password, prompt: Text("Required"), label: {
                Text("pass")
            })
            Text(password)
        }
    }
}

struct SecuredFieldPrac_Previews: PreviewProvider {
    static var previews: some View {
        SecuredFieldPrac()
    }
}
