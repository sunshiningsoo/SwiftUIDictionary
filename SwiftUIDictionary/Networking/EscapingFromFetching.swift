//
//  EscapingFromFetching.swift
//  SwiftUIDictionary
//
//  Created by 박성수 on 2022/09/04.
//

import SwiftUI

struct FetchModel: Identifiable, Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

class EscapingFromFetchingViewModel: ObservableObject {
    @Published var models: [FetchModel] = []
    
    init() {
        getData()
    }
    
    func getData() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        getJSONData(fromUrl: url) { data in
            if let data = data {
                guard let newData = try? JSONDecoder().decode([FetchModel].self, from: data) else { return }
                
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    // 위의 guard let 구문처럼 조금 이상하긴 하지만, self의 ? 를 빼주기 위해서 이렇게도 가능하다.
                    self.models = newData
                }
            } else {
                print("DATA is not in here")
            }
        }
    }
    
    func getJSONData(fromUrl url: URL, completionHandler: @escaping (_ data: Data?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return completionHandler(nil)}
            guard error == nil  else { return completionHandler(nil)}
            
            completionHandler(data)
        }.resume()
    }
    
}

struct EscapingFromFetching: View {
    @StateObject var vm: EscapingFromFetchingViewModel = EscapingFromFetchingViewModel()
    var body: some View {
        List {
            ForEach(vm.models) { model in
                VStack {
                    Text(model.title)
                        .font(.headline)
                    Text(model.body)
                        .font(.subheadline)
                    
                }
            }
        }
    }
}

struct EscapingFromFetching_Previews: PreviewProvider {
    static var previews: some View {
        EscapingFromFetching()
    }
}
