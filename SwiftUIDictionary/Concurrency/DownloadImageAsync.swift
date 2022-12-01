//
//  DownloadImageAsync.swift
//  SwiftUIDictionary
//
//  Created by 박성수 on 2022/12/01.
//

import SwiftUI
import Combine

// REF: https://www.youtube.com/watch?v=9fXI6o39jLQ&list=PLwvDm4Vfkdphr2Dl4sY4rS9PLzPdyi8PM&index=3

class DownloadImageAsyncLoader {
    
    let url = URL(string: "https://picsum.photos/200")!
    
    func handleResponse(data: Data?, response: URLResponse?) -> UIImage? {
        guard
            let data = data,
            let image = UIImage(data: data),
            let response = response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
                return nil
        }
        return image
    }
    
    func downloadImageEscaping(completionHandler: @escaping (_ image: UIImage?, _ error: Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            let image = self?.handleResponse(data: data, response: response)
            completionHandler(image, error)
        }
        .resume()
    }
    
    func downloadImageCombine() -> AnyPublisher<UIImage?, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map(handleResponse)
            .mapError { $0 }
            .eraseToAnyPublisher()
    }
    
    func downloadImageAsync() async throws -> UIImage? {
        // async를 사용하는 이유가 위의 closure로 진행하는 경우에, 해당 코드가 async한지 잘 알기 어려움
        // 그러나 async를 사용해주면, 바로 알기 쉽다
        // weak self를 사용해주지 않아도 됨
        // completionHandler를 까먹어도 컴파일이 되지만, async 에서는 컴파일이 되지 않으므로 실수할 확률이 적어짐
        do {
            let (data, response) = try await URLSession.shared.data(from: url, delegate: nil)
            return handleResponse(data: data, response: response)
        } catch {
            throw error
        }
    }
    
}

class DownloadImageAsyncViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    let loader = DownloadImageAsyncLoader()
    var cancellable = Set<AnyCancellable>()
    
    func fetchImage() {
        loader.downloadImageEscaping { [weak self] image, error in
            DispatchQueue.main.async {
                self?.image = image
            }
        }
    }
    
    func fetchCombineImage() {
        loader.downloadImageCombine()
            .receive(on: DispatchQueue.main)
            .sink { _ in
                
            } receiveValue: { [weak self] image in
                self?.image = image
            }
            .store(in: &cancellable)
    }
    
    func fetchAsyncImage() async {
        let image = try? await loader.downloadImageAsync()
        // MainActor는 메인스레드로 넣어주는 것임, but Main Thread보다 작음
        await MainActor.run {
            self.image = image
        }
    }
    
}

struct DownloadImageAsync: View {
    @StateObject private var vm = DownloadImageAsyncViewModel()
    
    var body: some View {
        ZStack {
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250)
            }
        }
        .onAppear {
//            vm.fetchImage()
//            vm.fetchCombineImage()
            
            // async context로 들어가기 위해서 Task를 사용한 것임
            // aysnc 환경으로 들어가는 것임
            Task {
                await vm.fetchAsyncImage()
            }
        }
        
    }
}

struct DownloadImageAsync_Previews: PreviewProvider {
    static var previews: some View {
        DownloadImageAsync()
    }
}
