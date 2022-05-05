//
//  PopToRootPrac.swift
//  SwiftUIDictionary
//
//  Created by 박성수 on 2022/05/05.
//

import SwiftUI

struct PopToRootPrac: View {
    @State var goToPage1:Bool = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 50) {
                Text("This is Page 1")
                
                Button(action: {
                    goToPage1.toggle()
                }, label: {
                    Text("Go to Page 2")
                })
                .background(NavigationLink(destination: Page2(goToPage1: $goToPage1), isActive: $goToPage1, label: {EmptyView()}).isDetailLink(false)
                )
            }
        }
    }
}

struct Page2:View{
    @Binding var goToPage1:Bool
    @State var goToPage2:Bool = false
    
    var body: some View{
        VStack(spacing: 50){
            Text("This is Page2")
            
            Button(action: {
                goToPage2.toggle()
            }, label: {
                Text("Go to Page3")
            })
            .background(NavigationLink(destination: Page3(goToPage1 : $goToPage1, goToPage2: $goToPage2), isActive: $goToPage2, label:{EmptyView()}).isDetailLink(false))
        }
    }
}

struct Page3:View{
    @Binding var goToPage1:Bool
    @Binding var goToPage2:Bool
    @State var goToPage4:Bool = false
    
    var body: some View{
        VStack(spacing: 50){
            Text("This is Page3")
            
            Button(action: {
                goToPage1.toggle()
            }, label: {
                Text("Go Back To Page1")
            })
            
            Button(action: {
                goToPage2.toggle()
            }, label: {
                Text("Go Back To Page2")
            })
            
            Button(action: {
                goToPage4.toggle()
            }, label: {
                Text("Go to Page4")
            })
            .background(NavigationLink(destination: Page4(goToPage1:$goToPage1, goToPage2:$goToPage2, goToPage4:$goToPage4), isActive: $goToPage4, label: {EmptyView()}).isDetailLink(false))
        }
    }
}

struct Page4: View{
    @Binding var goToPage1:Bool
    @Binding var goToPage2:Bool
    @Binding var goToPage4:Bool
    
    var body: some View{
        VStack(spacing: 50){
            Text("This is Page4")
            
            Button(action: {
                goToPage1.toggle()
            }, label: {
                Text("Go Back To Page1")
            })
            
            Button(action: {
                goToPage2.toggle()
            }, label: {
                Text("Go Back To Page2")
            })
            
            Button(action: {
                goToPage4.toggle()
            }, label: {
                Text("Go Back To Page3")
            })
        }
    }
    
}

struct PopToRootPrac_Previews: PreviewProvider {
    static var previews: some View {
        PopToRootPrac()
    }
}
