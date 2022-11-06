//
//  TimerViewModel.swift
//  BreakTimer Watch App
//
//  Created by Park Sungmin on 2022/11/07.
//

import Foundation
import SwiftUI

class TimerViewModel: ObservableObject {
    
    @State var totalTime: Int = 90
    
    @Published var timerState: TimerState = .idle
    @Published var timer: DispatchSourceTimer?
    @Published var leftTime: Int = 90
    
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
        
        if self.timer == nil {
            self.timer = DispatchSource.makeTimerSource(flags: [], queue: .main)
            
            self.timer?.schedule(deadline: .now()+1, repeating: 1)
            self.timer?.setEventHandler(handler: {
                
                self.leftTime -= 1
                
                if self.leftTime == 0 {
                    self.timerState = .stop
                    
                    self.timer?.cancel()
                    self.timer = nil
                }
            })
            self.timer?.resume()
        }
    }
    
    func pauseTimer() {
        timerState = .pause
        
        timer?.suspend()
    }
    
    func resumeTimer() {
        timerState = .isRunning
        
        timer?.resume()
    }
    
    func nextTimer() {
        if self.timerState == .pause { self.timer?.resume() }
        self.timer?.cancel()
        
        self.timer = nil
        self.timerState = .idle
        
        leftTime = totalTime
    }
    
    func extendTimer() {
        leftTime += 30
        startTimer()
    }
}
