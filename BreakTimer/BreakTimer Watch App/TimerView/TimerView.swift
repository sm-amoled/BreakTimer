//
//  TimerView.swift
//  BreakTimer Watch App
//
//  Created by Park Sungmin on 2022/11/06.
//

import SwiftUI

struct TimerView: View {
    
    var totalTime: Int
    @StateObject var viewModel: TimerViewModel = TimerViewModel()
    
    init(totalTime: Int) {
        self.totalTime = totalTime
    }
    
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
                
                // Skip Add Button
                HStack {
                    Button("Skip") {
                        viewModel.tapSkipButton()
                    }
                    Button("+30s") {
                        viewModel.tapAddButton()
                    }
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
            }
        }
        .onAppear {
            viewModel.totalTime = totalTime
            viewModel.leftTime = totalTime
        }
    }
}
