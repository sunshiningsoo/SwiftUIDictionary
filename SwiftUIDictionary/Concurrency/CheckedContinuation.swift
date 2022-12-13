//
//  CheckedContinuation.swift
//  SwiftUIDictionary
//
//  Created by 박성수 on 2022/12/11.
//

import SwiftUI

// REF: https://www.youtube.com/watch?v=Tw_WLMIfEPQ&list=PLwvDm4Vfkdphr2Dl4sY4rS9PLzPdyi8PM&index=8
struct CheckedContinuationNetWorkManager {
    
    func fetchImage(url: URL) async throws -> Data {
        do {
            let (data, _) = try await URLSession.shared.data(from: url, delegate: nil)
            return data
        } catch {
            throw error
        }
    }
    
    func fetchImage2(url: URL) async throws -> Data {
        // withCheckedThrowingContinuation을 활용하게 되는 경우, resume이 1번 실행됨을 보장해 주어야 한다.
        return try await withCheckedThrowingContinuation({ continuation in
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    continuation.resume(returning: data)
                } else if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume(throwing: URLError(.badURL))
                }
            }
            .resume()
        })
    }
    
    func fetchHeartImageFromDatabase(completionHandler: @escaping((_ image: UIImage) -> ())) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            completionHandler(UIImage(systemName: "heart.fill")!)
        }
    }
    
    // 위의 코드를 아래로 변형한다면, 기존의 SDK, third-party 등에서 completionhandler만 사용되고 async를 지원하지 않는 경우
    // swift의 async await로 변경해서 사용해 줄 수 있는 이점이 있음
    func fetchHeartContinuation() async -> UIImage {
        // return 키워드가 내장되어 있어서 return을 생략해줘도 된다.
        await withCheckedContinuation { continuation in
            fetchHeartImageFromDatabase { image in
                continuation.resume(returning: image)
            }
        }
    }
}

class CheckedContinuationViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    let manager = CheckedContinuationNetWorkManager()
    
    func getImage() async {
        guard let url = URL(string: "https://picsum.photos/200") else{ return }
        
        do {
            let data = try await manager.fetchImage(url: url)
            await MainActor.run(body: {
                image = UIImage(data: data)
            })
        } catch {
            print(error)
        }
    }
    
    func getHeartImage() {
        manager.fetchHeartImageFromDatabase { image in
            self.image = image
        }
    }
    
    func getHeartContinuation() async {
        self.image = await manager.fetchHeartContinuation()
    }
    
}

struct CheckedContinuation: View {
    @StateObject var vm = CheckedContinuationViewModel()
    
    var body: some View {
        ZStack {
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 200, height: 200)
            }
        }
        .task {
//            await vm.getImage()
            await vm.getHeartContinuation()
        }
    }
}

struct CheckedContinuation_Previews: PreviewProvider {
    static var previews: some View {
        CheckedContinuation()
    }
}
