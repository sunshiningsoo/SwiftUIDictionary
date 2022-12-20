//
//  SendablePractice.swift
//  SwiftUIDictionary
//
//  Created by 박성수 on 2022/12/20.
//

import SwiftUI

// REF: https://www.youtube.com/watch?v=wSmTbtOwgbE&list=PLwvDm4Vfkdphr2Dl4sY4rS9PLzPdyi8PM&index=12

actor CurrentUserManager {
    
    func updateDataBase(userInfo: MyClassUserInfo) {
        
    }
    
}

// struct 는 thread safe하니까
// Sendable 프로토콜이 붙어있는 놈은 concurent code로 safe하게 보낼 수 있음
// 컴파일러에서 safe한 데이터라고 알리는 것임
// Sendable을 쓰지 않아도 되지만, 프로토콜로 명시한다면 약간의 performence 베네핏이 있다.
struct MyUserInfo: Sendable {
    let name: String
}

// Sendable을 사용하려면 final class로 만들어 주어야 함
final class MyClassUserInfo: @unchecked Sendable {
    
    // name이 var라면, mutable함으로 에러 발생함,
    // let으로 name을 만들거나,
    // @unchecked로 만들어 줘라 super dangerous -> queue를 만들어줘서 thread safe하게 만들어주어야 합니다.
    private var name: String
    
    let queue = DispatchQueue(label: "com.MyClassUserInfo")
    
    init(name: String) {
        self.name = name
    }
    
    func updateName(name: String) {
        queue.async {
            self.name = name
        }
    }
    
}

class SendableViewModel: ObservableObject {
    
    let manager = CurrentUserManager()
    
    func updateCurrentUserInfo() async {
        
        let info = MyClassUserInfo(name: "info")
        
        await manager.updateDataBase(userInfo: info)
    }
    
}

struct SendablePractice: View {
    @StateObject private var vm = SendableViewModel()
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .task {
                await vm.updateCurrentUserInfo()
            }
    }
}

struct SendablePractice_Previews: PreviewProvider {
    static var previews: some View {
        SendablePractice()
    }
}
