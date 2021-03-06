//
//  ButtonAlert.swift
//  SwiftUIDictionary
//
//  Created by 박성수 on 2022/04/20.
//

import SwiftUI

struct ButtonAlertOneChoice: View {
    @State var isPresented:Bool = false
    @State var isPresented2:Bool = false
    @State var isPresented3:Bool = false
    @State var isPresented4:Bool = false
    
    var body: some View {
        VStack {
            Button("Alert is coming"){
                isPresented.toggle()
            }
            .alert(isPresented:$isPresented){
                Alert(title: Text("this is title"),
                      message: Text("this is message"),
                      dismissButton: .default(Text("dismiss"))
                )
            }
            
            
            // 하단의 버튼은 클릭시 just OK 만 나오게 된다.
            Button(action: {
                isPresented2.toggle()
            }, label: {
                Text("Alert just OK")
            })
            .alert(isPresented: $isPresented2){
                Alert(title: Text("This is Title2"),
                      message: Text("This is Message2"),
                      dismissButton: .none)
            }
            
            // function을 이용한 Alert
            Button(action: {
                isPresented3.toggle()
            }, label: {
                Text("This is using function!")
            })
            .alert(isPresented: $isPresented3,
                   content: alertReturn)
            
            // primaryButton, secondaryButton
            Button(action: {
                isPresented4.toggle()
            }, label: {
                Text("This is primary, secondary")
            })
            .alert(isPresented: $isPresented4){
                Alert(title: Text("Title!"),
                      message: Text("This is message"),
                      primaryButton: .destructive(Text("destructive")),
                      secondaryButton: .cancel(Text("cancel")))
                // Alert.Button 타입임 -> Alert.Button.destructive()이지만,
                // 예상 가능한 타입이기 때문에, 줄임이 가능하다.
            }
        }
    }
    
    // Alert를 return하는 함수, "Alert"를 uppercased()해서 대문자로 받은 점도 인상적!
    func alertReturn() -> Alert{
        return Alert(title: Text("Alert".uppercased()))
    }
}

struct ButtonAlert_Previews: PreviewProvider {
    static var previews: some View {
        ButtonAlertOneChoice()
    }
}
