//
//  AsyncPublisher.swift
//  SwiftUIDictionary
//
//  Created by 박성수 on 2022/12/26.
//

import SwiftUI
import Combine

// REF: https://www.youtube.com/watch?v=ePPm2ftSVqw&list=PLwvDm4Vfkdphr2Dl4sY4rS9PLzPdyi8PM&index=13

class AsyncPublisherDataManager {
    
    @Published var myData: [String] = []
    
    func addData() async {
        myData.append("Apple")
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        myData.append("Banana")
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        myData.append("Orange")
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        myData.append("Water")
        
    }
    
}

class AsyncPublisherViewModel: ObservableObject {
    
    @MainActor @Published var dataArray: [String] = []
    let manager = AsyncPublisherDataManager()
    var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    private func addSubscribers() {
        
        Task {
            await MainActor.run(body: {
                self.dataArray = ["One"]
            })
            
            
            for await value in manager.$myData.values {
                await MainActor.run(body: {
                    self.dataArray = value
                })
//                break
            }
            
            // 여기는 실행이 안될 것임 위에서 계속 loop 돌고 있음
            await MainActor.run(body: {
                self.dataArray = ["Two"]
            })
        }
        
        
        manager.$myData
            .receive(on: DispatchQueue.main, options: nil)
            .sink { dataArray in
                DispatchQueue.main.async {
                    self.dataArray = dataArray
                }
            }
            .store(in: &cancellables)
    }
    
    func start() async {
        await manager.addData()
    }
    
}

struct AsyncPublisher: View {
    @StateObject private var viewModel = AsyncPublisherViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.dataArray, id: \.self) {
                    Text($0)
                        .font(.headline)
                }
            }
        }
        .task {
            await viewModel.start()
        }
    }
}

struct AsyncPublisher_Previews: PreviewProvider {
    static var previews: some View {
        AsyncPublisher()
    }
}
