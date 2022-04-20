//
//  StackPrac.swift
//  SwiftUIDictionary
//
//  Created by 박성수 on 2022/04/21.
//

import SwiftUI

struct StackPrac: View {
    var body: some View {
        VStack(alignment:.leading, spacing:50){
            VStack{
                Text("1")
                Text("2")
                Text("3")
            }
            
            HStack{
                Text("1")
                Text("2")
                Text("3")
            }
            
            ZStack{
                Text("1")
                Text("2")
                Text("3")
            }
        }
    }
}

struct StackPrac_Previews: PreviewProvider {
    static var previews: some View {
        StackPrac()
    }
}
