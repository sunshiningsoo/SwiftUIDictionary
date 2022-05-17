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


// User 객체 각각에 json 파일과 맞춰주어 fetch 할 것이기 때문에 Codable(Encodabel + Decodable)을 사용한다.
struct User:Identifiable, Codable{
    var id:Int
    var title:String
}

class Users:ObservableObject{
    @Published var users:[User] = []
    
    func dataFetch(){
        guard let url = URL(string: api) else { return }
        
        URLSession.shared.dataTask(with: url){ (data, response, err) in
            self.users = try! JSONDecoder().decode([User].self, from: data!)
        }
        .resume()
    }
        
}

struct URLSessionPrac: View {
    @ObservedObject var usersObject = Users()
    
    var body: some View {
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

struct URLSessionPrac_Previews: PreviewProvider {
    static var previews: some View {
        URLSessionPrac()
    }
}
