//
//  URLSessionPrac.swift
//  SwiftUIDictionary
//
//  Created by 박성수 on 2022/05/17.
//

import SwiftUI

let api = "https://jsonplaceholder.typicode.com/todos"

// json 파일의 형식이 이렇게 생겼다.
//[
//  {
//    "userId": 1,
//    "id": 1,
//    "title": "delectus aut autem",
//    "completed": false
//  },
//  {
//    "userId": 1,
//    "id": 2,
//    "title": "quis ut nam facilis et officia qui",
//    "completed": false
//  },
//  ...

// User 객체 각각에 json 파일과 맞춰주어 fetch 할 것이기 때문에 Codable(Encodabel + Decodable)을 사용한다.
struct User: Identifiable, Codable {
    var id: Int
    var title: String
}

class Users: ObservableObject{
    @Published var users: [User] = []
    
    func dataFetch(){
        guard let url = URL(string: api) else { return }
        
        // 2)guard let data = try? Data(contentsOf: url) else { return }
        // 2)의 형식으로 Data로 가져오게 되면, 동기적으로 진행하게 되어, 데이터를 가져올 동안 다른 일은 하지 않는다.
        // -> 효율 및 UX의 문제로 판단됨!
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            // task는 비동기로 진행된다. URL을 통한 데이터를 가져옴과 동시에 다른 일도 진행한다. -> good!
            //MARK: 1. Block the ERR
            if let err = err {
                print(err.localizedDescription) // 이 에러가 어떤 에러의 종류인지 print해주게 된다.
                return
            }
            //MARK: 2. Block the Failed Response
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                //response가 200의 success를 가져오지 않으면 아래 코드 실행 못하게 막아버림
                return
            }
            //MARK: 2. Block the Failed data Load
            guard let data = data else { return } // data가 nil인 것을 막아준다.
            DispatchQueue.main.async { [weak self] in // weak self를 붙여 도중에 사용자가 나가는 것을 고려해준다. deinit을 해주기 가능
                do{
                    self?.users = try JSONDecoder().decode([User].self, from: data) // data가 위에서 nil인 것을 막아줬으므로 강제 언래핑을 제외할 수 있다.
                }
                catch{
                    print(error)
                }
            }
///            Publishing changes from background threads is not allowed; make sure to publish values from the main thread (via operators like receive(on:)) on model updates.
///            이 문제는 do catch 로 error를 잡지 못하고, 코더블을 하는 메인 쓰레드의 동작완료까지의 시간을 보장해주어야 하기 때문에
///            do catch 를 사용함으로서  try 의 강제 추출형식은 뺄 수 있다
///            DispatchQueue.main.async 로 위의 에러 메시지를 없앨 수 있다. -> 메인쓰레드에서의 실행을 보장해주게 되기 때문
///            뷰에서 그려지는 모든 행동은 main thread에서 이루어지게 된다.
        }
        .resume()
    }
}

struct URLSessionPrac: View {
    @ObservedObject var usersObject = Users()
    
    var body: some View {
        ScrollView {
            VStack {
                Button(action: {
                    usersObject.dataFetch()
                }, label: {
                    Text("Click to fetch Data")
                })
                
                ForEach(usersObject.users){user in
                    Text(user.title)
                }
            }
        }
    }
}

struct URLSessionPrac_Previews: PreviewProvider {
    static var previews: some View {
        URLSessionPrac()
    }
}
