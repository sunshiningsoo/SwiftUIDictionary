//
//  WhichThreadNowPrac.swift
//  SwiftUIDictionary
//
//  Created by 박성수 on 2022/09/01.
//

import SwiftUI

class ThreadFinder: ObservableObject {
    @Published var nums: [Int] = []
    
    func getData() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            print("Is This Main thread?: \(Thread.isMainThread ? "YES!" : "NO!")")
            print("Now this work in: \(Thread.current)")
            let data = self?.arrayFetch() ?? []
            // arrayFetch 과정에서도 탈출되는 사항이 있을 수 있기에, weak self를 걸어줌
            
            DispatchQueue.main.async { [weak self] in
                print("Is This Main thread?: \(Thread.isMainThread ? "YES!" : "NO!")")
                print("Now this work in: \(Thread.current)")
                self?.nums = data
                // main thread에서 UI를 바꿔주는 과정에서 사용자가 페이지 바깥으로 나갈 수 있기 때문에, weak self 로 만들어준다.
                // + main thread에서 UI 업데이트를 담당하므로, UI 업데이트와 관련된 사항은 main thead 즉 thread number 1에서 담당해주어야 한다.
            }
        }
    }
    
    func arrayFetch() -> [Int] {
        let arr = Array(repeating: 1, count: 100)
        return arr
    }
    
}


struct WhichThreadNowPrac: View {
    @StateObject var threadFinder: ThreadFinder = ThreadFinder()
    
    var body: some View {
        ScrollView {
            VStack {
                Button("Tap") {
                    threadFinder.getData()
                }
                ForEach(threadFinder.nums, id:\.self) { item in
                    Text("\(item)")
                }
            }
        }
    }
}

struct WhichThreadNowPrac_Previews: PreviewProvider {
    static var previews: some View {
        WhichThreadNowPrac()
    }
}
