//
//  Subscribtion.swift
//  SwiftUIDictionary
//
//  Created by 박성수 on 2022/10/30.
//

import SwiftUI
import Combine

class SubscriptionViewModel: ObservableObject {
    @Published var timer: AnyCancellable? = nil
    @Published var num: Int = 0
    
    init() {
        timerSetting()
    }
    
    func timerSetting() {
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .scan(0, { (count, _) in
                return count + 1
            })
            .filter({ count in
                return count < 3
            })
            // filter에서 1차적으로 Auth같은 것을 걸러줌 그러고 나서 무거운 작업같은 서버통신을 sink에 넣어준다
            .sink(receiveCompletion: { completion in
                print("receive Completion: \(completion)")
            }, receiveValue: { receiveValue in
                print("receiveValue: \(receiveValue)")
                self.num = receiveValue
            })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.timer?.cancel()
        }
    }
}

struct Subscription: View {
    @StateObject var vm = SubscriptionViewModel()
    
    var body: some View {
        Text("\(vm.num)")
    }
}

struct Subscription_Previews: PreviewProvider {
    static var previews: some View {
        Subscription()
    }
}
