//
//  TimerView.swift
//  BreakTimer Watch App
//
//  Created by Park Sungmin on 2022/11/06.
//

import SwiftUI

struct TimerView: View {
    @StateObject var viewModel = TimerViewModel()
    
    var body: some View {
        ZStack{
            VStack(spacing: 8) {
                // Time Labels
                Spacer()
                VStack(spacing: -5) {
                    Text("\(viewModel.totalTime.convertToTimeFormat())")
                        .font(.system(size: 20))
                        .foregroundColor(.gray)
                    Text("\(viewModel.leftTime.convertToTimeFormat())")
                        .font(.system(size: 50, weight: .medium))
                }
                
                // StartPauseReset Button
                Button {
                    viewModel.tapStartPauseResetButton()
                } label: {
                    switch viewModel.timerState {
                    case .idle:
                        Text("Start")
                    case .isRunning:
                        Text("Pause")
                    case .pause:
                        Text("Resume")
                    case .stop:
                        Text("Reset")
                    }
                }
                .frame(height: 44)
                
                // Skip Add Button
                HStack {
                    Button("Skip") {
                        viewModel.tapSkipButton()
                    }
                    Button("+30s") {
                        viewModel.tapAddButton()
                    }
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
