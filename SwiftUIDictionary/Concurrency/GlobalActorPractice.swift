//
//  GlobalActor.swift
//  SwiftUIDictionary
//
//  Created by 박성수 on 2022/12/19.
//

import SwiftUI

// MARK: - GLOBAL ACTORS
@globalActor final class MyFirstGlobalActor1 {
    
    static var shared = MyNewDataManager()
}

@globalActor struct MyFirstGlobalActor {
    
    // globalActor는 actor를 shared로 만들어 싱글톤의 actor를 사용하게 된다
    // 싱글톤이 아니라 그냥 만들어서 대입하면, globalActor의 부분과 실제 사용 부분의 instance가 다른 instance가 되어
    // 제대로 동작하지 못함
    static var shared = MyNewDataManager()
    
}

// MARK: - ACTOR
actor MyNewDataManager {
    
    // 아래도 static하게 사용이 가능하지만, globalActor가 더 custom해서 사용하기 편리하다.
    // static var shared = MyNewDataManager()
    
    func getDataFromDataBase() -> [String] {
        return ["One", "Two", "Three"]
    }
}

// 모든 동작이 MainActor에서 이루어진다고 만들어두고, 만약 다른 actor에서 동작하게 된다면,
// 안에 들어가 MyFirstGlobalActor를 붙여주던가 nonisolated를 붙여주면 된다.
class GlobalActorViewModel: ObservableObject {
    
    // dataArray가 우리는 main thread에서 동작해야 함을 알기 때문에 명시적으로 작성해 줄 수 있음
    // -> 해당 변수가 사용될 때, warning이 뜸
    @MainActor @Published var dataArray: [String] = []
    
    let globalActorManager = MyFirstGlobalActor.shared
    let normalManager = MyNewDataManager()
    
    // getData 를 MyFirstGlobalActor로 isolate 시켜버림
    // GlobalActor가 getData를 actor에 isolate 시키지 않도록 하는 것임
    @MyFirstGlobalActor func getDataFromGlobal() {
        // 여기 안이 만약 HEAVY COMPLEX task 라면..
        // MainActor혹은 Main thread에서 해당 massive한 task를 가지게 할 수 없다.
        Task {
            let data = await globalActorManager.getDataFromDataBase()
            print("\(Thread.current)에서 진행중")
            await MainActor.run(body: {
                self.dataArray = data
            })
        }
    }
    
    @MainActor func getDataFromMain() {
        Task {
            // getDataFromDataBase가 actor안에 정의되어 있어서 await를 작성해주어야 한다.
            let data = await globalActorManager.getDataFromDataBase()
            self.dataArray = data
        }
    }
}

struct GlobalActorPractice: View {
    @StateObject private var vm = GlobalActorViewModel()
    var body: some View {
        ScrollView {
            VStack {
                ForEach(vm.dataArray, id: \.self) {
                    Text($0)
                        .font(.headline)
                }
            }
        }
        .onAppear {
            Task {
                while true {
                    // 해당 라인을 실행시킴으로, 같은 GlobalActor에서 실행되어도 같은 thread에서 실행되는 것을
                    // 보장하는게 아닌 것을 알 수 있다.
                    await vm.getDataFromGlobal()
                }
            }
        }
        
        .onAppear {
            vm.getDataFromMain()
        }
        
        .task {
            await vm.getDataFromGlobal()
            vm.getDataFromMain()
        }
    }
    
}

struct GlobalActor_Previews: PreviewProvider {
    static var previews: some View {
        GlobalActorPractice()
    }
}
