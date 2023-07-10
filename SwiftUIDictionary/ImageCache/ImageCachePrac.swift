//
//  ImageCachePrac.swift
//  SwiftUIDictionary
//
//  Created by 박성수 on 2023/07/10.
//

import SwiftUI

class ImageCache {
    
    var imageDictionary: [String: UIImage] = [:]
    static let shared = ImageCache()
    
    func ImageFetch(url: String, completionHandler: @escaping (_ image: UIImage) -> ()) async {
        let request = URLRequest(url: URL(string: url)!)
        URLSession.shared.dataTask(with: request) { data, _, _ in
            guard let data = data else { return }
            
            completionHandler(UIImage(data: data) ?? UIImage())
        }
        .resume()
        
        completionHandler(UIImage())
    }
    
}

class ImageFetcher: ObservableObject {
    @Published var image = UIImage()
    let url = "https://randomuser.me/api/portraits/men/50.jpg"
    
    func fetchImage() async {
        if let cachedImage = ImageCache.shared.imageDictionary[url] {
            print("Cached")
            await MainActor.run {
                self.image = cachedImage
            }
        } else {
            print("Not Cached")
            await ImageCache.shared.ImageFetch(url: url) { image in
                DispatchQueue.main.async {
                    self.image = image
                }
                
                ImageCache.shared.imageDictionary[self.url] = image
            }
        }
    }
    
}

struct ImageCachePrac: View {
    @ObservedObject var imageFetcher = ImageFetcher()
    var body: some View {
        VStack {
            Image(uiImage: imageFetcher.image)
            Button {
                Task {
                    await imageFetcher.fetchImage()
                }
            } label: {
                Text("REFRESH")
            }

        }
    }
}

struct ImageCachePrac_Previews: PreviewProvider {
    static var previews: some View {
        ImageCachePrac()
    }
}
