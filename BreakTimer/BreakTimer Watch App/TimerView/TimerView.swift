//
//  TimerView.swift
//  BreakTimer Watch App
//
//  Created by Park Sungmin on 2022/11/06.
//

import SwiftUI
import WatchKit
import UserNotifications

struct TimerView: View {
    
    @Environment(\.scenePhase) var scenePhase
    @Environment(\.isLuminanceReduced) var isLuminanceReduced
    
    var totalTime: Double
    @StateObject var viewModel: TimerViewModel = TimerViewModel()
    
    init(totalTime: Double) {
        self.totalTime = totalTime
    }
    
    var body: some View {
        TimelineView(.periodic(from: .now, by: 0.3)) { _ in
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
        }
        .onReceive(viewModel.timer, perform: { _ in
            if viewModel.timerState == .isRunning {
                viewModel.leftTime -= 0.1
                
                if viewModel.leftTime == 1 || viewModel.leftTime == 2 {
                    WKInterfaceDevice.current().play(WKHapticType.stop)
                }
                
                if viewModel.leftTime <= 0 {
                    WKInterfaceDevice.current().play(WKHapticType.notification)
                    viewModel.timerState = .stop
                }
            }
        })
        .onAppear {
            viewModel.totalTime = totalTime
            viewModel.leftTime = totalTime
        }
        .onChange(of: scenePhase) { newScenePhase in
            switch newScenePhase {
            case .inactive:
                print("inactive mode")
                
                UserDefaults.standard.set(Date(), forKey: "inactiveTime")
                setOneTimeNotification(timeFor: Double(viewModel.leftTime))
                
            case .active:
                print("active mode")
                
                UNUserNotificationCenter.current().removeAllDeliveredNotifications()
                UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                
                if viewModel.timerState == .isRunning {
                    let diff = (UserDefaults.standard.object(forKey: "inactiveTime") as! Date).timeIntervalSinceNow
                    viewModel.leftTime -= Double(diff) + 1
                }
                
            case .background:
                print("background mode")
                
            @unknown default:
                print("unknown mode")
            }
        }
    }
}

func setOneTimeNotification(timeFor: Double) {
    let content = UNMutableNotificationContent()
    content.title = "쉬는 시간 완료!"
    content.subtitle = "다음 세트를 준비해주세요"
    
    if timeFor <= 1 { return }
    
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(timeFor), repeats: false)
    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
    
    UNUserNotificationCenter.current().add(request)
}
