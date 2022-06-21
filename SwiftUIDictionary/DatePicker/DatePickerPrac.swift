//
//  DatePickerPrac.swift
//  SwiftUIDictionary
//
//  Created by 박성수 on 2022/04/26.
//

import SwiftUI

struct DatePickerPrac: View {
    @State var now:String?
    @State private var date = Date()
    
    var dateFormatter = DateFormatter()
    
    let dateRange: ClosedRange<Date> = {
        // This can make the range of the date picker
        let calendar = Calendar.current
        let startComponents = DateComponents(year: 2021, month: 11, day: 15)
        let endComponents = DateComponents(year: 2022, month: 5, day: 20, hour: 23, minute: 59, second: 59)
        return calendar.date(from:startComponents)!
            ...
            calendar.date(from:endComponents)!
    }()
    
    
    var body: some View {
        VStack {
//            DatePicker("Start date", selection: $date, in:dateRange) // dateRange에 표시된 범위만큼만
            DatePicker("Start date", selection: $date, in:...Date()) // 과거부터 오늘 날짜까지
                .datePickerStyle(.graphical) // Can see this "Date Picker" in Calender mode
                .padding()
            
            Button("press"){
                // This button print the year of the chosen year
                print(date) // date type
                dateFormatter.dateFormat = "yyyy"
                // dateFormatter로 Date타입에서 년도만 4자리 추출하겠다는 의도
                
                now = dateFormatter.string(from: date)
                
                print("\(now!) 년도입니다") //String type으로 년도 정보 가져온다
            }
        }
    }
}

struct DatePickerPrac_Previews: PreviewProvider {
    static var previews: some View {
        DatePickerPrac()
    }
}
