//
//  URLSessionPexelPrac.swift
//  SwiftUIDictionary
//
//  Created by 박성수 on 2022/06/23.
//

import SwiftUI

struct Img: Codable {
    var page: Int = 0
    var photos: [ImgInfo]?
}

struct ImgInfo: Codable {
    var src: ImgReal?
}

struct ImgReal: Codable {
    var original: String = ""
}

class Instance: ObservableObject {
    @Published var content: String = "this is content"
    @Published var contentImg: Img = Img()
    @Published var imageGetFrom: UIImage?
}

struct URLSessionPexelPrac: View {
    @StateObject var instance: Instance = Instance()
    @State private var imageName: String = "" //2 State 변수들 체크
    @State var url: String = "https://api.pexels.com/v1/curated?per_page=1"
    
    init() {
        // 1 가장 처음
    }
    
    var body: some View {
        // 3 괜찮은지 체크
        VStack {
            TextField("want to finding", text: $imageName)
                .padding()
            Button(action: {
                imageDataFetch()
            }, label: {
                Text("click")
            })
            Text("\(instance.contentImg.photos?[0].src?.original ?? "nothing")")
            if instance.contentImg.photos?.isEmpty != nil {
                Image(uiImage: instance.imageGetFrom!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
        .onAppear() // 4 뷰가 생성되고 나서
    }
    
    func imageGet(){
        guard let url = URL(string: instance.contentImg.photos![0].src!.original) else { return }
        
        if let data = try? Data(contentsOf: url) {
            instance.imageGetFrom =  UIImage(data: data)
        }
    }
    
    func imageDataFetch() {
        guard let url1 = URL(string: url) else {
            print("URL Crash")
            return
        }
        var urlRequest = URLRequest(url: url1)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue(KEY, forHTTPHeaderField: "Authorization") // key값 추가하기
        URLSession.shared.dataTask(with: urlRequest){ (data, response, err) in
            guard let content = data else { return }
            if let err = err {
                print(err.localizedDescription)
            }
            debugPrint(content)
            DispatchQueue.main.async {
                do {
                    self.instance.contentImg = try JSONDecoder().decode(Img.self, from: content)
                    imageGet()
                } catch {
                    print("Decoding Error!")
                }
            }
        }
        .resume()
    }
}

struct URLSessionPexelPrac_Previews: PreviewProvider {
    static var previews: some View {
        URLSessionPexelPrac()
    }
}
