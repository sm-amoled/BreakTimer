//
//  TimerViewModel.swift
//  BreakTimer Watch App
//
//  Created by Park Sungmin on 2022/11/07.
//

import SwiftUI
import UserNotifications

class TimerViewModel: ObservableObject {
    
    @Published var totalTime: Int = 0
    
    @Published var timerState: TimerState = .idle
    @Published var timer: DispatchSourceTimer?
    @Published var leftTime: Int = 0
    
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
            self.timer = DispatchSource.makeTimerSource(flags: .strict, queue: .global())
            
            self.timer?.schedule(deadline: .now()+1, repeating: 1)
            self.timer?.setEventHandler(handler: {
                DispatchQueue.main.async {
                    self.leftTime -= 1
                    
                    if self.leftTime == 0 {
                        self.timerState = .stop
                        
                        WKInterfaceDevice.current().play(.notification)
                        self.notify()
                        
                        self.timer?.cancel()
                        self.timer = nil
                    } else if self.leftTime <= 2 {
                        WKInterfaceDevice.current().play(.start)
                    }
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
    
    func notify() {
        let content = UNMutableNotificationContent()
        content.title = "message"
        content.subtitle = "hello~~"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        
        let request = UNNotificationRequest(identifier: "noti", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
}
