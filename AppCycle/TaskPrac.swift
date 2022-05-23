//
//  TaskPrac.swift
//  SwiftUIDictionary
//
//  Created by 박성수 on 2022/05/24.
//

import SwiftUI

struct TaskPrac: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        
            // View가 나타날때, 수행할 비동기(동시에 일어나지 않는) 작업을 추가하는 것!
            // View가 그려지기 전에 task가 완료 되었다면, View가 사라져도 문제 없음
            // View가 그려지고 나서도 task가 완료되지 않고, View가 지워진다면, task안의 작업이 취소되고, 이는 SwiftUI가 해준다.
            .task {
                print(Thread.current)
                if Thread.current.isMainThread {
                    print("This is main thread!")
                }
            }
        
    }
}

struct TaskPrac_Previews: PreviewProvider {
    static var previews: some View {
        TaskPrac()
    }
}
