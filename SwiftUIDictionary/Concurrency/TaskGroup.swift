//
//  TaskGroup.swift
//  SwiftUIDictionary
//
//  Created by 박성수 on 2022/12/03.
//

import SwiftUI

class TaskGroupDataManager {
    
    let url = "https://picsum.photos/200"
    var arrays: [UIImage] = []
    
    func fetchImageWithAsyncLet() async throws -> [UIImage] {
        do {
            async let imageFetch1 = fetchImage(urlString: url)
            async let imageFetch2 = fetchImage(urlString: url)
            
            let (image1, image2) = await (try imageFetch1, try imageFetch2)
            arrays.append(contentsOf: [image1, image2])
            return arrays
        } catch {
            throw error
        }
    }
    
    func fetchImagesWithTaskGroup() async throws -> [UIImage] {
        
        let urlStrings: [String] = [
            "https://picsum.photos/200",
            "https://picsum.photos/200",
            "https://picsum.photos/200",
            "https://picsum.photos/200",
        ]
        
        return try await withThrowingTaskGroup(of: UIImage?.self) { group in
            var images: [UIImage] = []
            // 컴파일러에게 개발을 하는 사람은 그 크기를 아니까 어느정도로 메모리 공간을 잡아 놓으라고 지정해주는 것 어플리케이션의 속도 boost됨
            images.reserveCapacity(urlStrings.count)
            
            for urlString in urlStrings {
                group.addTask {
                    // 50개 요청해서 중간 몇개가 취소되었다고, nil로 나가버리면 이미지가 다 안뜨기 때문에 try?를 사용해서 에러처리 해주는 것이 좋음
                    // 위의 타입에서 UIImage도 옵셔널 값으로 바뀌어야 함
                    try? await self.fetchImage(urlString: urlString)
                }
            }
            
            // 아래와 같이 group에 addTask를 일일히 해줄 수 있지만, 상단처럼 Array로 다뤄주는 것이 더 편함
//            group.addTask {
//                try await self.fetchImage(urlString: self.url)
//            }
//            group.addTask {
//                try await self.fetchImage(urlString: self.url)
//            }
//            group.addTask {
//                try await self.fetchImage(urlString: self.url)
//            }
//            group.addTask {
//                try await self.fetchImage(urlString: self.url)
//            }
            
            for try await image in group {
                if let image = image {
                    images.append(image)
                }
            }
            
            return images
        }
    }
    
    private func fetchImage(urlString: String) async throws -> UIImage {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url, delegate: nil)
            if let image = UIImage(data: data) {
                return image
            } else {
                throw URLError(.badURL)
            }
        } catch {
            throw error
        }
    }
}

class TaskGroupViewModel: ObservableObject {
    @Published var images: [UIImage] = []
    let manager = TaskGroupDataManager()
    
    
    func getImages() async {
//        if let images = try? await manager.fetchImageWithAsyncLet() {
//            self.images.append(contentsOf: images)
//        }
        
        if let images = try? await manager.fetchImagesWithTaskGroup() {
            self.images.append(contentsOf: images)
        }
    }
}

struct TaskGroup: View {
    
    @StateObject var viewModel = TaskGroupViewModel()
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(viewModel.images, id: \.self) { image in
                        Image(uiImage: image)
                    }
                }
            }
            .navigationTitle("Async Let")
            .task {
                await viewModel.getImages()
            }
        }
    }
}

struct TaskGroup_Previews: PreviewProvider {
    static var previews: some View {
        TaskGroup()
    }
}
