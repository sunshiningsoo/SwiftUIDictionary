//
//  AboutDateType.swift
//  SwiftUIDictionary
//
//  Created by 박성수 on 2022/04/26.
//

import SwiftUI

struct AboutDateType: View {
    var currentDate:Date = Date()
    @State var changeString:String = ""
    
    var body: some View {
        ScrollView {
            Text("\(currentDate)")
            // Date타입으로 값이 출력된다.
            
            Button("날짜 보내기"){
                changeString = dateFormatterChange(changeOne: currentDate)
                print(changeString)
            }
        }
    }
}

func dateFormatterChange(changeOne : Date) -> String{
    // date를 나타내어 주는 방법으로 포맷을 시킨 후에 string을 리턴해주게 된다.
    let dateFormatter:DateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yy년도 MM월 dd일 입니다"
    return dateFormatter.string(from: changeOne)
}

struct AboutDateType_Previews: PreviewProvider {
    static var previews: some View {
        AboutDateType()
    }
}
