//
//  HomeView.swift
//  BreakTimer Watch App
//
//  Created by Park Sungmin on 2022/11/06.
//

import SwiftUI
import UserNotifications

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    
    @State private var path = NavigationPath()
    
    @State var keyColorName: String = "Red"
    @State var scrollAmount: Double = 12.0
    
    @State var darkColor: Color = Color("BTDarkRed")
    @State var tintColor: Color = Color("BTRed")
    
    enum Destination: Hashable {
        case setting, timer
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack(spacing: 0) {
                NavigationLink(value: Destination.setting) {
                    Spacer()
                    Image(systemName: "gearshape")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 24, height: 24)
                        .cornerRadius(40)
                        .foregroundColor(.gray)
                }
                .buttonStyle(.borderless)
                
                ZStack {
                    // background
                    Circle()
                        .foregroundColor(darkColor)
                    
                    // time gauge
                    Circle()
                        .stroke(
                            Color.gray,
                            lineWidth: 4
                        )
                    Circle()
                        .trim(from: 0, to: scrollAmount / 30)
                        .stroke(
                            Color.white,
                            // 1
                            style: StrokeStyle(
                                lineWidth: 4,
                                lineCap: .round
                            )
                        )
                        .rotationEffect(.degrees(-90))
                    
                    // shadow
                    Rectangle()
                        .frame(width: 75, height: 100)
                        .rotationEffect(.degrees(30))
                        .offset(x: -25, y: 43.3)
                        .foregroundColor(.black.opacity(0.4))
                    
                    // button background
                    Circle()
                        .foregroundColor(.black)
                        .frame(width: 75, height: 75)
                    
                    // button
                    NavigationLink(value: Destination.timer) {
                        ZStack{
                            Circle()
                                .foregroundColor(tintColor)
                            Text(crownAmountToSeconds().convertToTimeFormat())
                                .foregroundColor(.white)
                                .font(.system(size: 25, weight: .medium))
                        }
                    }
                    .frame(width: 75, height: 75)
                    .buttonStyle(.borderless)
                    
                }
            }
            .padding(.horizontal, 0)
            .padding(.vertical, 0)
            .navigationTitle("BreakTimer")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: Destination.self) {
                switch $0 {
                case .timer:
                    TimerView(totalTime: crownAmountToSeconds())
                case .setting:
                    SettingView()
                }
            }
        }
        .focusable(true)
        .digitalCrownRotation($scrollAmount, from: 0, through: 30, by: 1, sensitivity: .low, isContinuous: false, isHapticFeedbackEnabled: true)
        .onChange(of: scrollAmount) { scrollAmount in
            if scrollAmount < 7 {
                darkColor = Color("BTDarkYellow")
                tintColor = Color("BTYellow")
            } else if scrollAmount < 13 {
                darkColor = Color("BTDarkRed")
                tintColor = Color("BTRed")
            } else if scrollAmount < 19 {
                darkColor = Color("BTDarkGreen")
                tintColor = Color("BTGreen")
            } else if scrollAmount < 25 {
                darkColor = Color("BTDarkBlue")
                tintColor = Color("BTBlue")
            } else {
                darkColor = Color("BTDarkGray")
                tintColor = Color("BTGray")
            }
        }
        .onAppear {
            UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .sound, .alert]) { _, _  in
                
            }
        }
    }
    
    func crownAmountToSeconds() -> Int {
        if scrollAmount <= 6 {
            return Int(scrollAmount) * 10
        } else if scrollAmount <= 12 {
            return 60 + Int(scrollAmount - 6) * 5
        } else if scrollAmount <= 18 {
            return 90 + Int(scrollAmount - 12) * 5
        } else if scrollAmount <= 24 {
            return 120 + Int(scrollAmount - 18) * 10
        } else {
            return 180 + Int(scrollAmount - 24) * 20
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
