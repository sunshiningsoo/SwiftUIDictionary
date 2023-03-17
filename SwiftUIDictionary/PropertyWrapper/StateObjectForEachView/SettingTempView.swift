//
//  SettingTempView.swift
//  SwiftUIDictionary
//
//  Created by 박성수 on 2023/03/18.
//

import SwiftUI

struct SettingTempView: View {
    @StateObject var settingManager = SettingManager()
    
    var body: some View {
        List {
            Section("section 1") {
                HStack {
                    Text("1")
                    Spacer()
                    Toggle("", isOn: $settingManager.isnotificationOn)
                }
                
            }
            if settingManager.isnotificationOn {
                Section("section 2") {
                    Text("1")
                    Text("2")
                    Text("3")
                }
            }
        }
    }
}

struct SettingTempView_Previews: PreviewProvider {
    static var previews: some View {
        SettingTempView()
    }
}
