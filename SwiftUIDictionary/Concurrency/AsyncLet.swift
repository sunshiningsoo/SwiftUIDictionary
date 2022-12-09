//
//  AsyncLet.swift
//  SwiftUIDictionary
//
//  Created by 박성수 on 2022/12/03.
//

import SwiftUI

// REF: https://www.youtube.com/watch?v=1OmJJwVF7uQ&list=PLwvDm4Vfkdphr2Dl4sY4rS9PLzPdyi8PM&index=6
struct AsyncLet: View {
    
    @State private var images: [UIImage] = []
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    let url = URL(string: "https://picsum.photos/200")!
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(images, id: \.self) { image in
                        Image(uiImage: image)
                    }
                }
            }
            .navigationTitle("Async Let")
            .onAppear {
                // 단순히 Task 컴포넌트의 갯수를 늘려서 여러개의 Task로 만들어 줄 수도 있지만, task를 cancel해주는 것을 생각해보면, 하나의 Task에서 동시에 처리해주는 것이 좋음
                // 여러개의 Task를 만드는 것 보다 Single Task를 만드는 것이 더 다루기 좋음
                Task {
                    
                    async let imagege1 = fetchImage()
                    
                    let image = try await imagege1
                    self.images.append(image)
                    print("Task out of the closure \(Thread.current)")
                    
                    
                    do {
                        // 하단과 같이 해주면 한번에 이미지를 불러와준다
                        // 하나의 타입에서만 동작하는 것이 아니라, 여러 타입에서 같이 움직임
                        async let fetchImage1 = fetchImage()
                        async let fetchImage2 = fetchImage()
                        async let fetchImage3 = fetchImage()
                        async let fetchImage4 = fetchImage()
                        async let fetchTitle1 = fetchTitle()
                        
                        // try? 로 해주는 이유는, 그냥 try만 붙어 있으면 단 하나만이라도 error가 난다면, 아무 이미지도 받지 못하기 때문임
                        let (image1, image2, image3, image4, _) = await (try fetchImage1, try fetchImage2, try fetchImage3, try fetchImage4, fetchTitle1)
                        self.images.append(contentsOf: [image1, image2, image3, image4])
                        print("Task inside the closure \(Thread.current)")
                        
                        
                        // 하단과 같이 코딩을 한다면, serialize하게 이미지를 가져오게 됨
//                        let image1 = try await fetchImage()
//                        images.append(image1)
//                        let image2 = try await fetchImage()
//                        images.append(image2)
//                        let image3 = try await fetchImage()
//                        images.append(image3)
//                        let image4 = try await fetchImage()
//                        images.append(image4)
                    } catch {
                        throw error
                    }
                }
            }
        }
    }
    
    func fetchTitle() async -> String {
        return "TITLE"
    }
    
    func fetchImage() async throws -> UIImage {
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

struct AsyncLet_Previews: PreviewProvider {
    static var previews: some View {
        AsyncLet()
    }
}
