//
//  AsyncAwait.swift
//  SwiftUIDictionary
//
//  Created by 박성수 on 2022/12/01.
//

import SwiftUI

// REF: https://www.youtube.com/watch?v=-5kIzkBqAzc&list=PLwvDm4Vfkdphr2Dl4sY4rS9PLzPdyi8PM&index=4

class AsyncAwaitViewModel: ObservableObject {
    
    @Published var dataArray: [String] = []
    
    func addTitle1() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.dataArray.append("Title1: \(Thread.current)")
        }
    }
    
    func addTitle2() {
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            let title = "Title2: \(Thread.current)"
            
            DispatchQueue.main.async {
                self.dataArray.append(title)
                self.dataArray.append("Title3: \(Thread.current)")
            }
        }
    }
    
    func addAuthor1() async {
        let author1 = "Author1: \(Thread.current)"
        
        
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        // try? await doSomething() 이면 해당 줄에서 doSomething()의 끝남을 보장함
        
        let author2 = "Author2: \(Thread.current)"
        await MainActor.run(body: {
            self.dataArray.append(author1)
            self.dataArray.append(author2)
            
            let author3 = "Author3: \(Thread.current)"
            self.dataArray.append(author3)
        })
    }
    
    func addSomething() async {
        let something1 = "Something1: \(Thread.current)"
        
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        await MainActor.run(body: {
            self.dataArray.append(something1)
            let something2 = "Something2: \(Thread.current)"
            self.dataArray.append(something2)
        })
    }
    
    func doSomething() async throws {
        print("HI")
    }
    
}

struct AsyncAwait: View {
    @StateObject var vm = AsyncAwaitViewModel()
    
    var body: some View {
        List {
            ForEach(vm.dataArray, id: \.self) { data in
                Text(data)
            }
        }
        .onAppear {
//            vm.addTitle1()
//            vm.addTitle2()
            
            // Task는 context를 async 환경으로 들어가게 함
            Task {
                // await이 다 끝날때까지 해당 줄을 기다림
                // await으로 비동기 처리를 기다려주고, UI의 변화는 main thread에서 다뤄준다.
                await vm.addAuthor1()
                await vm.addSomething()
                vm.dataArray.append("Final Text: \(Thread.current)")
            }
        }
    }
}

struct AsyncAwait_Previews: PreviewProvider {
    static var previews: some View {
        AsyncAwait()
    }
}
