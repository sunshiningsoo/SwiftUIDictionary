//
//  ModalPrac.swift
//  SwiftUIDictionary
//
//  Created by 박성수 on 2022/04/27.
//

import SwiftUI

struct ModalCommonPrac: View {
    @State var showModal:Bool = false
    // Modal을 열어줄지 말지를 결정하는 변수 false이면 모달이 없고, true라면 모달이 올라옴
    
    var body: some View {
        VStack{
            Text("Here is main page")
            Button(action: {
                showModal.toggle() // showModal 값을 false->true로 바꿔준다
            }, label: {
                Text("Modal up if you click!")
                    .sheet(isPresented: $showModal){
                        ModalPage()
                        // showModal의 값이 true가 되어 ModalPage가 올라온다
                        
                        //다만 ForEach 안에 있는 구문의 경우에 ForEach 바깥에서 sheet을 만들어주는 것을
                        //원칙으로 한다. 모든 객체에서 Modal이 만들어 질 필요가 없다.
                    }
            })
            
        }
    }
}

struct ModalPage:View{
    @Environment(\.presentationMode) var presentation // 이전 화면으로 돌아가기 위해서 환경변수를 변수로 가져온다. presentationMode의 환경변수를 presentation 변수에 넣은 것
    
    var body: some View{
        VStack {
            Text("This is modal page")
                .foregroundColor(.black)
            Button(action: {
                presentation.wrappedValue.dismiss()
                // 현재의 화면에서 이전화면으로 갈 수 있다.
                // wrapped 되어있는 화면을 dismiss한다고 이해
            }, label: {
                Text("click and close the modal")
            })
            .padding()
            .background(RoundedRectangle(cornerRadius: 20).fill(Color.blue))
            .foregroundColor(.white)
        }
        
        
        
    }
}

struct ModalCommonPrac_Previews: PreviewProvider {
    static var previews: some View {
        ModalCommonPrac()
    }
}
