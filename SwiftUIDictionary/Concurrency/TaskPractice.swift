//
//  TaskPractice.swift
//  SwiftUIDictionary
//
//  Created by 박성수 on 2022/12/02.
//

import SwiftUI

// REF: https://www.youtube.com/watch?v=fTtaEYo14jI
class TaskPracticeViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var image2: UIImage? = nil
    
    func fetchImage() async {
        try? await Task.sleep(nanoseconds: 5_000_000_000)
        
        // for문처럼 연쇄적으로 돌아가는 async한 sequence가 있다면
        // Task.checkCancellation()를 해주어 cancel되었는지 확인 후 메모리를 잡아먹지 않도록 처리해주어야 한다.
        
        guard let url = URL(string: "https://picsum.photos/200") else { return }
        do {
            let (data, _) = try await URLSession.shared.data(from: url, delegate: nil)
            await MainActor.run(body: {
                self.image = UIImage(data: data)
                print("Image Returned Successfully")
            })
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchImage2() async {
        guard let url = URL(string: "https://picsum.photos/200") else { return }
        do {
            let (data, _) = try await URLSession.shared.data(from: url, delegate: nil)
            await MainActor.run(body: {
                self.image2 = UIImage(data: data)
                print("Image Returned Successfully")
            })
        } catch {
            print(error.localizedDescription)
        }
    }
    
}

struct TaskPracticeMain: View {
    var body: some View {
        NavigationView {
            ZStack {
                NavigationLink("Click ME") {
                    TaskPractice()
                }
            }
        }
    }
}


struct TaskPractice: View {
    @StateObject var vm = TaskPracticeViewModel()
    @State private var imageFetchTask: Task<(), Never>? = nil
    
    var body: some View {
        VStack(spacing: 40) {
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
            if let image = vm.image2 {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
        }
        // onAppear, onDisappear의 역할을 task가 할 수 있다.
        .task {
            await vm.fetchImage()
        }
//        .onDisappear {
//            imageFetchTask?.cancel()
//        }
        .onAppear {
//            // Task의 priority가 높다고 먼저 끝나는 것이 보장되는 것이 아니라, 먼저 시작하는 것을 보장해주는 것임
//            imageFetchTask = Task {
//                await vm.fetchImage()
//            }
//            Task {
//                await vm.fetchImage2()
//            }
            
        
            // priority가 높을수록 더 먼저 시작됨을 보장한다. 다만 끝나는 건 보장하지 않음
            Task(priority: .high) {
//                try await Task.sleep(nanoseconds: 2_000_000_000)
                await Task.yield()
                print("high: \(Thread.current): \(Task.currentPriority)")
            }
            Task(priority: .userInitiated) {
                print("userInitiated: \(Thread.current): \(Task.currentPriority)")
            }
            Task(priority: .medium) {
                print("medium: \(Thread.current): \(Task.currentPriority)")
            }
            Task(priority: .low) {
                print("low: \(Thread.current): \(Task.currentPriority)")
            }
            Task(priority: .utility) {
                print("utility: \(Thread.current): \(Task.currentPriority)")
            }
            Task(priority: .background) {
                print("background: \(Thread.current): \(Task.currentPriority)")
            }
            
            // Task의 detached 확인, detach가 없다면, 같은 priority로 실행된다.
            Task(priority: .low) {
                print("low: \(Thread.current): \(Task.currentPriority)")

                Task.detached {
                    print("detached: \(Thread.current): \(Task.currentPriority)")
                }
            }
            
        }
    }
}

struct TaskPractice_Previews: PreviewProvider {
    static var previews: some View {
        TaskPractice()
    }
}
