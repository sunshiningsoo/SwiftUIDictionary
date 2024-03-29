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
                Image(uiImage: instance.imageGetFrom ?? UIImage())
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
        }
        .onAppear() // 4 뷰가 생성되고 나서
    }
    
    func imageGet(){
        guard let url = URL(string: instance.contentImg.photos![0].src!.original) else { return }
        
        if let data = try? Data(contentsOf: url) {
            instance.imageGetFrom = UIImage(data: data)
        }
    }
    
    func imageDataFetch() {
        // 1. make URL
        guard let newUrl = URL(string: url) else {
            print("URL Crash")
            return
        }
        // 2. Request or Session
        var urlRequest = URLRequest(url: newUrl)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue(KEY, forHTTPHeaderField: "Authorization") // key값 추가하기
        // 3. dataTask -> default로 백그라운드 thread에서 프로그램이 실행됨
        URLSession.shared.dataTask(with: urlRequest) { (data, response, err) in
            guard let content = data else { return }
            if let err = err {
                print(err.localizedDescription)
            }
            debugPrint(content)
            DispatchQueue.main.async {
                // background thread에서 실행되던 코드를 UI 업데이트니까 main thread로 옮겨줌
                // 4. decode
                do {
                    self.instance.contentImg = try JSONDecoder().decode(Img.self, from: content)
                    imageGet()
                } catch {
                    print("Decoding Error!")
                }
            }
        }
        // 5. datatask resume
        .resume()
        // 모든 task는 일시정지 상태로 시작되기 때문에, resume()으로 task를 실행해야 합니다.
        /*
         * NSURLSessionTask objects are always created in a suspended state and
         * must be sent the -resume message before they will execute.
         */
        // datatask가 return 하는 타입이 URLSessionTask이다.
        // 위의 definition으로 URLSessionTask가 일시정지 된 상태로 생겨나기 때문에, resume()을 해주어야 하는 이유가 된다!
    }
}

struct URLSessionPexelPrac_Previews: PreviewProvider {
    static var previews: some View {
        URLSessionPexelPrac()
    }
}
