//
//  LocalNotificationPrac.swift
//  SwiftUIDictionary
//
//  Created by 박성수 on 2022/08/29.
//

import SwiftUI
import UserNotifications

// REF: https://www.youtube.com/watch?v=mG9BVAs8AIo
class NotiCenter {
    static let instance = NotiCenter() // Singleton 활용한 접근 방식, 객체 하나만 사용하는 것임
    
    func getAuth() {
        let options:  UNAuthorizationOptions = [.badge, .sound, .alert]
        
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            if let error = error {
                print("error: \(error)")
            } else {
                print("SUCCESS!")
            }
        }
    }
    
    func timeIntervalAlert() {
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
        let content = UNMutableNotificationContent()
        content.title = "This is THat"
        content.subtitle = "SUBTITLE"
        content.body = "BODy"
        content.badge = 1 // 이 설정이 안되어있으면, 노티가 가도 Badge의 수가 오르지 않는다.
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    func clear() {
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        // Notification Center에 있는 알림을 삭제한다.
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        // pending되어있어 오지 못한 노티들을 없앤다.
    }
    
}

struct LocalNotificationPrac: View {
    var body: some View {
        VStack(spacing: 50) {
            Button("Auth") {
                NotiCenter.instance.getAuth()
                // Auth 권한을 받은 이후에 노티를 활용해야 함 무조건!
            }
            Button("Time interval Noti") {
                NotiCenter.instance.timeIntervalAlert()
            }
            Button("Noti Clear") {
                NotiCenter.instance.clear()
            }
        }
        .onAppear {
            UIApplication.shared.applicationIconBadgeNumber = 0
            // Icon Badge에 있는 number를 초기화 한다.
        }
    }
}

struct LocalNotificationPrac_Previews: PreviewProvider {
    static var previews: some View {
        LocalNotificationPrac()
    }
}
