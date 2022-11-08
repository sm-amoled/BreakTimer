//
//  TimerViewModel.swift
//  BreakTimer Watch App
//
//  Created by Park Sungmin on 2022/11/07.
//

import SwiftUI
import UserNotifications

class TimerViewModel: ObservableObject {
    
    @Published var totalTime: Double = 0
    @Published var timerState: TimerState = .idle
    @Published var leftTime: Double = 0
    @State var timer = Timer.publish(every: 0.1, on: .current, in: .common).autoconnect()
    
    func tapStartPauseResetButton() {
        switch timerState {
        case .idle:
            startTimer()
        case .stop:
            nextTimer()
            startTimer()
        case .isRunning:
            pauseTimer()
        case .pause:
            resumeTimer()
        }
    }
    
    func tapSkipButton() {
        nextTimer()
    }
    
    func tapAddButton() {
        extendTimer()
    }
}

extension TimerViewModel {
    func startTimer() {
        timerState = .isRunning
    }
    
    func pauseTimer() {
        timerState = .pause
        
//        timer?.suspend()
    }
    
    func resumeTimer() {
        timerState = .isRunning
        
//        timer?.resume()
    }
    
    func nextTimer() {
//        if self.timerState == .pause { self.timer?.resume() }
//        self.timer?.cancel()
//
//        self.timer = nil
        self.timerState = .idle
        
        leftTime = totalTime
    }
    
    func extendTimer() {
        leftTime += 30
        startTimer()
    }
}
