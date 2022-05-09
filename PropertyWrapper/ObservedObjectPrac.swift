//
//  ObservedObjectPrac.swift
//  SwiftUIDictionary
//
//  Created by 박성수 on 2022/05/09.
//

import SwiftUI

class FakeData:ObservableObject{
    @Published var num:Int = 0
}

struct ObservedObjectPrac: View {
    @StateObject var fakeData:FakeData = FakeData()
    var body: some View {
        NavigationView{
            NavigationLink(destination: ObservableNextPage(fakeData: fakeData)){
                Text("Click to move site")
            }
        }
    }
}

struct ObservableNextPage: View{
    @ObservedObject var fakeData:FakeData
    
    var body: some View{
        VStack{
            Button(action: {
                fakeData.num += 1
            }, label: {
                Text("Click to plus the num!")
            })
            Text(String(fakeData.num))
        }
    }
}

struct ObservedObjectPrac_Previews: PreviewProvider {
    static var previews: some View {
        ObservedObjectPrac()
    }
}
