//
//  EnvironmentObjectPrac.swift
//  SwiftUIDictionary
//
//  Created by 박성수 on 2022/05/09.
//

import SwiftUI

class FakeData2:ObservableObject{
    @Published var num:Int = 0
}

struct EnvironmentObjectPrac: View {
    @StateObject var fakeData2:FakeData2 = FakeData2()
    var body: some View {
        NavigationView{
            NavigationLink(destination: EnvironmentObjectNextPage()){
                Text("Go to Next page!")
            }
        }
    }
}

struct EnvironmentObjectNextPage: View{
    var body: some View{
        NavigationLink(destination : LastPage()){
            Text("Click to move last page")
        }
    }
}

struct LastPage: View{
    @EnvironmentObject var fakedata2:FakeData2
    
    var body: some View{
        VStack {
            Button(action: {
                fakedata2.num += 1
            }, label: {
                Text("num plus!")
            })
            
            Text(String(fakedata2.num))
        }
    }
}

struct EnvironmentObjectPrac_Previews: PreviewProvider {
    static var previews: some View {
        EnvironmentObjectPrac()
            .environmentObject(FakeData2())
    }
}
