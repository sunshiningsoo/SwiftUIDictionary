//
//  Actors.swift
//  SwiftUIDictionary
//
//  Created by 박성수 on 2022/12/19.
//

import SwiftUI

// 1. what is the problem that actor are solving
// 2. how was this problem solved prior to actors
// 3. actors can solve the problem

class MyDataManager {
    
    static let instance = MyDataManager()
    private init() { }
    
    var data: [String] = []
    
    private let lock = DispatchQueue(label: "com.park.ConcurrencyActor")
    
    func getRandomData(completionHandler: @escaping(_ title: String?) -> ()) {
        // actor 이전에는 lock이라는 DispatchQueue를 만들어 lock처럼 동작하게 만들어 다른 task가 끝나기를 기다려 줌
        lock.async {
            self.data.append(UUID().uuidString)
            print(Thread.current)
            completionHandler(self.data.randomElement())
        }
        
    }
}

// 위와 같이 class로 구현하게 되면 thread safe 하지 않기 때문에 queue를 하나 만들어 주어 lock으로 그 순서를 만들어 주고, completionHandler까지 만들어 주어야 하지만,
// actor는 thread Safe하기 때문에 그렇게 해줄 필요가 없다 await만 적용해주면 완성임
actor MyActorManager {
    
    // actor안의 동작은 isolated되어 있음 -> thread safe하다는 것
    
    static let instance = MyActorManager()
    private init() { }
    
    var data: [String] = []
    
    // myText는 await말고 바로 접근 할 수 있도록 해주고 싶을때
    nonisolated let myText: String = "HEllo"
        
    func getRandomData() -> String? {
        
        self.data.append(UUID().uuidString)
        print(Thread.current)
        return self.data.randomElement()
        
    }
    
    // getSavedData만 isolated되게 하고 싶지 않다면!
    nonisolated func getSavedData() -> String {
        return "NEW DATA!!"
    }
    
}

struct HomeView: View {
    
    let manager = MyDataManager.instance
    let actorManager = MyActorManager.instance
    @State private var text: String = ""
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.8).ignoresSafeArea()
            
            Text(text)
                .font(.headline)
        }
        .onAppear {
            let newString = actorManager.getSavedData()
            let noneIsolatedString = actorManager.myText
            
            // 위처럼 사용하면 됨 하단처럼 사용할 필요가 없음
            Task {
                // let newString = actorManager.getSavedData()
            }
        }
        .onReceive(timer) { _ in
            Task {
                if let data = await actorManager.getRandomData() {
                    await MainActor.run(body: {
                        self.text = data
                    })
                }
            }
        }
        
//            // 여러 쓰레드에서 동일한 class로 접근하고 있기 때문에 문제가 생길 수 있음 data race..
//            DispatchQueue.global(qos: .background).async {
//                manager.getRandomData { title in
//                    if let data = title {
//                        DispatchQueue.main.async {
//                            self.text = data
//                        }
//                    }
//                }
//            }
//        }
    }
}

struct BrowseView: View {
    
    let manager = MyDataManager.instance
    let actorManager = MyActorManager.instance
    @State private var text: String = ""
    let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    
    
    var body: some View {
        ZStack {
            Color.yellow.opacity(0.8).ignoresSafeArea()
            
            Text(text)
                .font(.headline)
        }
        .onReceive(timer) { _ in
            // context를 비동기로 진입하게 함
            Task {
                if let data = await actorManager.getRandomData() {
                    await MainActor.run(body: {
                        self.text = data
                    })
                }
            }
            
            // global thread로 접근하면서부터 문제가 생길 수 있는데,
            // 이 concurrency문제를 다뤄주기 위해서, Queue를 만들어 사용하게 됨
//            DispatchQueue.global(qos: .default).async {
//                manager.getRandomData { title in
//                    if let data = title {
//                        DispatchQueue.main.async {
//                            self.text = data
//                        }
//                    }
//                }
            
            // main thread에서만 작동하고 있는 경우
//            if let data = manager.getRandomData() {
//                DispatchQueue.main.async {
//                    self.text = data
//                }
//            }
        }
    }
}


struct Actors: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            BrowseView()
                .tabItem {
                    Label("Browse", systemImage: "magnifyingglass")
                }
        }
    }
}

struct Actors_Previews: PreviewProvider {
    static var previews: some View {
        Actors()
    }
}
