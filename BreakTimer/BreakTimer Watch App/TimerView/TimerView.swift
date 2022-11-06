//
//  TimerView.swift
//  BreakTimer Watch App
//
//  Created by Park Sungmin on 2022/11/06.
//

import SwiftUI

struct TimerView: View {
    var body: some View {
        VStack(spacing: 4) {
            // Time
            Spacer()
            VStack(spacing: -5) {
                Label("01:30", image: "")
                    .font(.system(size: 20))
                    .foregroundColor(.gray)
                Label("01:30", image: "")
                    .font(.system(size: 50, weight: .medium))
            }
            
            // StartPauseReset
            Button("Start") {
                print("start")
            }
            .frame(height: 44)
                        
            // Skip Add
            HStack {
                Button("Skip") {
                    print("Skip")
                }
                Button("+30") {
                    print("+30")
                }
            }
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
