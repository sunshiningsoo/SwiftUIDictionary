//
//  AppCyclePrac.swift
//  SwiftUIDictionary
//
//  Created by 박성수 on 2022/06/23.
//

import SwiftUI

struct AppCyclePrac: View {
    @State private var hello: String = "this is in State" // 2. second check State, Binding
    
    init() {
        hello = "this is in init"
    } // 1. first doing Action
    
    var body: some View {
        // 3. third check UI is OK?
        Text(hello)
            .onAppear {
                self.hello = "this is in onAppear" // View is showing this hello word -> cause this is loaded at the last part
            } // 4. fourth doing onAppear after view is loaded
            .onDisappear {
                self.hello = "this is in onDisappear" // if View is Closed, them 'hello' will be changed to this
            } // last. View is disappear and onDisappear is loaded
    }
}

struct AppCyclePrac_Previews: PreviewProvider {
    static var previews: some View {
        AppCyclePrac()
    }
}
