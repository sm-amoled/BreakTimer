//
//  SettingView.swift
//  BreakTimer Watch App
//
//  Created by Park Sungmin on 2022/11/06.
//

import SwiftUI

struct SettingView: View {
    @State var isAllowVibe: Bool = true
    @State var isAllowNoti: Bool = true
    
    var body: some View {
        List {
            Toggle("진동", isOn: $isAllowVibe)
            Toggle("완료 시 알림", isOn: $isAllowNoti)
        }
        .navigationTitle("설정")
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
